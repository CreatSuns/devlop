//
//  WYACourseDetailView.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/11.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYACourseDetailView.h"
#import "WYACourseDetailModel.h"

@interface WYACourseDetailView ()<ZFPlayerDelegate, WYAVideoCoverViewControlDelegate>

@property (nonatomic, strong) ZFPlayerView * playerView;

@property (nonatomic, strong) ZFPlayerModel * playerModel;

@property (nonatomic, strong) WYACourseCatalogChapterPaperModel * chapterPaperModel;

/**
 判断是否是第一次播放
 */
@property (nonatomic, assign) BOOL notFrist;

/**
 播放了视频
 */
@property (nonatomic, assign) BOOL isPlayed;

@property (nonatomic, strong) UIButton * resetButton;

@end

@implementation WYACourseDetailView

- (UIButton *)resetButton{
    if (!_resetButton) {
        _resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resetButton setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
        [_resetButton addTarget:self action:@selector(resetClick) forControlEvents:UIControlEventTouchUpInside];
        _resetButton.hidden = YES;
    }
    return _resetButton;
}

-(instancetype)initWithFrame:(CGRect)frame PlaceHoldImage:(NSString *)placeholdImage{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.coverView = [[WYAVideoControlView alloc]init];
        self.coverView.videoCoverViewControlDelegate = self;
        WeakSelf(weakSelf);
        self.coverView.showAlert = ^{
            weakSelf.showAlert();
        };
        
        self.playerView = [[ZFPlayerView alloc]init];
        self.playerView.backgroundColor = [UIColor WYAJHBlackTextColor];
        self.playerView.hasPreviewView = YES;
        [self addSubview:self.playerView];
        
        self.playerModel = [[ZFPlayerModel alloc]init];
        self.playerModel.placeholderImageURLString = [placeholdImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        self.playerModel.fatherView = self;
//        self.playerView.userInteractionEnabled = NO;
        [self.playerView playerControlView:self.coverView playerModel:self.playerModel];
        
        self.playerView.delegate = self;
        self.resetButton.frame = CGRectMake((ScreenWidth-44)/2, (frame.size.height-44)/2, 44, 44);
        [self.playerView addSubview:self.resetButton];
    }
    
    return self;
    
}

#pragma mark --- ZFPlayerDelegate
/** 返回按钮事件 */
- (void)zf_playerBackAction{
    NSLog(@"back");
    _learnTime = self.coverView.learnTime;
    _allTime = self.coverView.allTime;
    if (self.videoControlDelegate && [self.videoControlDelegate respondsToSelector:@selector(videoBackButtonClick)]) {
        [self.videoControlDelegate videoBackButtonClick];
    }
}

/** 下载视频 */
- (void)zf_playerDownload:(NSString *)url{
    
    if (self.videoControlDelegate && [self.videoControlDelegate respondsToSelector:@selector(videoDownloadUrl:)]) {
        [self.videoControlDelegate videoDownloadUrl:url];
    }
}

- (void)zf_playerLikeVideoButtonClick:(UIButton *)sender{
    NSLog(@"收藏");
    if (self.videoControlDelegate && [self.videoControlDelegate respondsToSelector:@selector(videoLikeButtonClick:)]) {
        [self.videoControlDelegate videoLikeButtonClick:sender];
    }
}

/**
 视频暂停
 */
- (void)zf_playerVideoStop{
    self.coverView.playButton.hidden = NO;
    self.coverView.playButton.alpha = 1;
    self.coverView.playButton.selected = YES;
}

/** 控制层即将显示 */
- (void)zf_playerControlViewWillShow:(UIView *)controlView isFullscreen:(BOOL)fullscreen{
    self.coverView.playButton.hidden = NO;
}
/** 控制层即将隐藏 */
- (void)zf_playerControlViewWillHidden:(UIView *)controlView isFullscreen:(BOOL)fullscreen{
    self.coverView.playButton.hidden = YES;
}

/**
 播放完成
 */
- (void)zf_videoPlayEndAction{
    NSLog(@"播放完了");
    _learnTime = self.coverView.learnTime;
    _allTime = self.coverView.allTime;
    self.resetButton.hidden = YES;
    //先上传当前视频的进度
    if (self.videoControlDelegate && [self.videoControlDelegate respondsToSelector:@selector(saveCurrentVideoInfo)]) {
        [self.videoControlDelegate saveCurrentVideoInfo];
    }
    
    
    for (NSInteger i = 0; i<self.catalogModel.groups.count; i++) {
        WYACourseCatalogGroupsModel * groupModel = self.catalogModel.groups[i];
        
        for (NSInteger j = 0; j<groupModel.chapters.count; j++) {
            WYACourseCatalogChaptersModel * chapterM = groupModel.chapters[j];
            
            if ([chapterM.chapter_id isEqualToString:self.chapterModel.chapter_id]){
                //找到记录的当前视频
                if (chapterM.chapter_paper && !chapterM.chapter_paper.points) {
                    //如果有测试卷而且测试卷没有测试
                    
                    self.coverView.learnView.hidden = YES;
                    self.coverView.testView.hidden = NO;
                    self.coverView.testView.testTitleLabel.text = chapterM.chapter_paper.paper_title;
                    self.chapterPaperModel = chapterM.chapter_paper;
                    return;
                }else{
                    //进入下节视频
                    NSInteger index = [self.catalogModel.groups indexOfObject:groupModel];
                    NSInteger tag = [groupModel.chapters indexOfObject:chapterM];
                    if (index >= self.catalogModel.groups.count - 1) {
                        //最后一组
                        if (tag >= groupModel.chapters.count - 1) {
                            //最后一个
                            if (groupModel.group_paper) {
                                //最后一组有试卷
                                if (groupModel.group_paper.points.length>0) {
                                    //最后一组试卷考试过了
                                    self.coverView.learnView.hidden = YES;
                                    self.coverView.testView.hidden = NO;
                                    self.coverView.testView.testTitleLabel.text = self.catalogModel.course_paper.paper_title;
                                    self.chapterPaperModel = self.catalogModel.course_paper;
                                    
                                    return;
                                }else{
                                    //最后一组试卷没考试过了
                                    self.coverView.learnView.hidden = YES;
                                    self.coverView.testView.hidden = NO;
                                    self.coverView.testView.testTitleLabel.text = groupModel.group_paper.paper_title;
                                    self.chapterPaperModel = groupModel.group_paper;
                                    return;
                                }
                                
                            }else{
                                //最后一组没有试卷
                                if (self.catalogModel.course_paper && self.catalogModel.course_paper.points.length < 1) {
                                    //有课程试卷
                                    self.coverView.learnView.hidden = YES;
                                    self.coverView.testView.hidden = NO;
                                    self.coverView.testView.testTitleLabel.text = self.catalogModel.course_paper.paper_title;
                                    self.chapterPaperModel = self.catalogModel.course_paper;
                                    
                                    return;
                                }else{
                                    //没有课程试卷课程已经学习完毕
                                    self.coverView.learnView.hidden = YES;
                                    self.coverView.testView.hidden = YES;

                                    self.resetButton.hidden = NO;
                                    
                                }
                            }
                        }else{
                            //最后一组但不是最后一个
                            WYACourseCatalogChaptersModel * chapter = groupModel.chapters[tag + 1];
                            self.coverView.learnView.hidden = YES;
                            self.coverView.testView.hidden = YES;
                            
//                            self.coverView.playButton.hidden = NO;
                            self.chapterModel = chapter;
                            self.notFrist = YES;
                            [self.playerView resetToPlayNewVideo:self.playerModel];
                            self.coverView.playButton.selected = YES;
                            self.chapterID = chapter.chapter_id;
                            [[NSNotificationCenter defaultCenter] postNotificationName:CATALOGCELLSTATECOLOR object:nil userInfo:@{@"chapterID":chapter.chapter_id}];
                            return;
                        }
                        
                    }else{
                        //不是最后一组
                        if (tag >= groupModel.chapters.count - 1) {
                            //改组最后一个
                            WYACourseCatalogGroupsModel * nextGroupModel = self.catalogModel.groups[index + 1];
                            WYACourseCatalogChaptersModel * nextChapter = [nextGroupModel.chapters firstObject];
                            //
                            self.coverView.learnView.hidden = YES;
                            self.coverView.testView.hidden = YES;
                            
//                            self.coverView.playButton.hidden = NO;
                            
                            self.chapterModel = nextChapter;
                            self.notFrist = YES;
                            [self.playerView resetToPlayNewVideo:self.playerModel];
                            self.coverView.playButton.selected = YES;
                            self.chapterID = nextChapter.chapter_id;
                            [[NSNotificationCenter defaultCenter] postNotificationName:CATALOGCELLSTATECOLOR object:nil userInfo:@{@"chapterID":nextChapter.chapter_id}];
                            return;
                        }else{
                            WYACourseCatalogChaptersModel * chapter = groupModel.chapters[tag + 1];
                            self.coverView.learnView.hidden = YES;
                            self.coverView.testView.hidden = YES;
                            
//                            self.coverView.playButton.hidden = NO;
                            self.chapterModel = chapter;
                            self.notFrist = YES;
                            [self.playerView resetToPlayNewVideo:self.playerModel];
                            self.coverView.playButton.selected = YES;
                            self.chapterID = chapter.chapter_id;
                            [[NSNotificationCenter defaultCenter] postNotificationName:CATALOGCELLSTATECOLOR object:nil userInfo:@{@"chapterID":chapter.chapter_id}];
                            return;
                        }
                    }
                }
                
            }
        }
    }

    
    
}

#pragma mark --- WYAVideoCoverViewControlDelegate
- (void)videoPlayButtonClick:(UIButton *)sender Progress:(NSString *)progress{
    
    if (progress) {
        self.playerModel.seekTime = [progress integerValue];
        [self.playerView resetToPlayNewVideo:self.playerModel];
    }
    
    if (sender.selected) {
        [self.playerView play];
    }else{
        [self.playerView pause];
    }
    
}

#pragma mark Public method
- (void)loadVideoPlayerAndEndTest{
    self.resetButton.hidden = YES;
    for (NSInteger i = 0; i<self.catalogModel.groups.count; i++) {
        WYACourseCatalogGroupsModel * groupModel = self.catalogModel.groups[i];
        
        for (NSInteger j = 0; j<groupModel.chapters.count; j++) {
            WYACourseCatalogChaptersModel * chapterM = groupModel.chapters[j];
            
            if ([chapterM.chapter_id isEqualToString:self.chapterModel.chapter_id]){
                //找到记录的当前视频
                if (chapterM.chapter_paper && !chapterM.chapter_paper.points) {
                    //如果有测试卷而且测试卷没有测试
                    
                    self.coverView.learnView.hidden = YES;
                    self.coverView.testView.hidden = NO;
                    self.coverView.testView.testTitleLabel.text = chapterM.chapter_paper.paper_title;
                    self.chapterPaperModel = chapterM.chapter_paper;
                    return;
                }else{
                    //进入下节视频
                    NSInteger index = [self.catalogModel.groups indexOfObject:groupModel];
                    NSInteger tag = [groupModel.chapters indexOfObject:chapterM];
                    if (index >= self.catalogModel.groups.count - 1) {
                        //最后一组
                        if (tag >= groupModel.chapters.count - 1) {
                            //最后一个
                            if (groupModel.group_paper) {
                                //最后一组有试卷
                                if (groupModel.group_paper.points.length>0) {
                                    //最后一组试卷考试过了
                                    self.coverView.learnView.hidden = YES;
                                    self.coverView.testView.hidden = NO;
                                    self.coverView.testView.testTitleLabel.text = self.catalogModel.course_paper.paper_title;
                                    self.chapterPaperModel = self.catalogModel.course_paper;
                                    
                                    return;
                                }else{
                                    //最后一组试卷没考试过了
                                    self.coverView.learnView.hidden = YES;
                                    self.coverView.testView.hidden = NO;
                                    self.coverView.testView.testTitleLabel.text = groupModel.group_paper.paper_title;
                                    self.chapterPaperModel = groupModel.group_paper;
                                    return;
                                }
                                
                            }else{
                                //最后一组没有试卷
                                if (self.catalogModel.course_paper && self.catalogModel.course_paper.points.length < 0) {
                                    //有课程试卷
                                    self.coverView.learnView.hidden = YES;
                                    self.coverView.testView.hidden = NO;
                                    self.coverView.testView.testTitleLabel.text = self.catalogModel.course_paper.paper_title;
                                    self.chapterPaperModel = self.catalogModel.course_paper;
                                    
                                    return;
                                }else{
                                    //没有课程试卷课程已经学习完毕
//                                    self.coverView.learnLabel.text = @"课程已经学习完毕";
//                                    [self.coverView.learnButton setTitle:@"返回" forState:UIControlStateNormal];
                                    self.notFrist = YES;
                                    self.coverView.learnView.hidden = YES;
                                    
                                    self.resetButton.hidden = NO;
                                    
                                }
                            }
                        }else{
                            //最后一组但不是最后一个
                            WYACourseCatalogChaptersModel * chapter = groupModel.chapters[tag + 1];
                            self.coverView.learnView.hidden = YES;
                            self.coverView.testView.hidden = YES;
                            
                            self.chapterModel = chapter;
                            self.notFrist = YES;
                            [self.playerView resetToPlayNewVideo:self.playerModel];
                            self.coverView.playButton.selected = YES;
                            self.chapterID = chapter.chapter_id;
                            
                            return;
                        }
                        
                    }else{
                        //不是最后一组
                        if (tag >= groupModel.chapters.count - 1) {
                            //改组最后一个
                            WYACourseCatalogGroupsModel * nextGroupModel = self.catalogModel.groups[index + 1];
                            WYACourseCatalogChaptersModel * nextChapter = [nextGroupModel.chapters firstObject];
                            //
                            self.coverView.learnView.hidden = YES;
                            self.coverView.testView.hidden = YES;
                            
                            
                            self.chapterModel = nextChapter;
                            self.notFrist = YES;
                            [self.playerView resetToPlayNewVideo:self.playerModel];
//                            [self.playerView pause];
                            self.coverView.playButton.selected = YES;
                            self.chapterID = nextChapter.chapter_id;
                            
                            return;
                        }else{
                            WYACourseCatalogChaptersModel * chapter = groupModel.chapters[tag + 1];
                            self.coverView.learnView.hidden = YES;
                            self.coverView.testView.hidden = YES;
                            
                            self.chapterModel = chapter;
                            self.notFrist = YES;
                            [self.playerView resetToPlayNewVideo:self.playerModel];
//                            [self.playerView pause];
                            self.coverView.playButton.selected = YES;
                            self.chapterID = chapter.chapter_id;
                            
                            return;
                        }
                    }
                }
                
            }
        }
    }
}

/**
 开始学习

 @param sender 按钮
 */
- (void)videoStartLearnClick:(UIButton *)sender{
    if (self.isPlayed == NO) {
        if (self.videoControlDelegate && [self.videoControlDelegate respondsToSelector:@selector(addMyLearnCourses)]) {
            [self.videoControlDelegate addMyLearnCourses];
            self.isPlayed = YES;
        }
    }
    if (self.playerView) {
        [self.playerView resetToPlayNewVideo:self.playerModel];
        self.coverView.playButton.selected = YES;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:CATALOGCELLSTATECOLOR object:nil userInfo:@{@"chapterID":self.chapterModel.chapter_id}];
    }
    
}

/**
 开始测试
 */
- (void)goTestPaper{
    if (self.videoControlDelegate && [self.videoControlDelegate respondsToSelector:@selector(goChapterTestPaperWithPaperID:)]) {
        [self.videoControlDelegate goChapterTestPaperWithPaperID:self.chapterPaperModel.paper_id];
    }
}


- (void)resetClick{
    self.playerModel.seekTime = 0;
    [self.playerView resetToPlayNewVideo:self.playerModel];
    self.coverView.playButton.selected = YES;
    self.resetButton.hidden = YES;
}

#pragma mark Set - Get
/**
 获取最后播放的视频信息

 @param model model
 */
-(void)setModel:(WYACourseDetailModel *)model{
    _model = model;
    if (model) {
        if ([model.course_info.allow_fast_forward isEqualToString:@"2"]) {
            //当为yes时禁止快进
            self.playerView.disablePanGesture = YES;
            
        }else{
            self.coverView.needSlider = YES;
        }
        if ([model.course_info.allow_download isEqualToString:@"2"]) {
            self.coverView.downLoadBtn.hidden = YES;
        }
        
        self.coverView.chapter = model.last_chapter;
        self.chapterModel = model.last_chapter;
        [[NSNotificationCenter defaultCenter] postNotificationName:CATALOGCELLSTATECOLOR object:nil userInfo:@{@"chapterID":model.last_chapter.chapter_id}];
        
        [self.playerView pause];
        self.coverView.playButton.selected = NO;
        if (model.course_info.is_collected) {
            self.coverView.likeButton.selected = YES;
            
        }
        if ([model.last_chapter.process floatValue]>0) {
            //看过
        }else{
            self.coverView.learnView.hidden = YES;
            self.coverView.playButton.hidden = NO;
            self.coverView.alpha = 1;
        }
    }
    
}


/**
 寻找当前学习章节

 @param catalogModel catalogModel
 */
- (void)setCatalogModel:(WYACourseCatalogModel *)catalogModel{
    _catalogModel = catalogModel;
    if (catalogModel) {
        for (WYACourseCatalogGroupsModel * groupModel in catalogModel.groups) {
            for (WYACourseCatalogChaptersModel * chapterModel in groupModel.chapters) {
                if ([self.model.last_chapter.chapter_id isEqualToString:chapterModel.chapter_id]) {
                    //寻找当前学习的章节
                    if (chapterModel.chapter_paper && [self.model.last_chapter.is_completed isEqualToString:@"1"] && [self.model.last_chapter.video_length isEqualToString:self.model.last_chapter.process] && !chapterModel.chapter_paper.points) {
                        //当前章节有测试试卷而且视频已看完而且进度必须和视频长度一致
                        self.coverView.learnView.hidden = YES;
                        self.coverView.testView.hidden = NO;
                        self.coverView.testView.testTitleLabel.text = chapterModel.chapter_paper.paper_title;
                        self.chapterPaperModel = chapterModel.chapter_paper;
                    }
                }
            }
        }
        
    }
}


/**
 切换视频传入的视频信息

 @param chapterModel chapterModel
 */
- (void)setChapterModel:(WYACourseCatalogChaptersModel *)chapterModel{
    _chapterModel = chapterModel;
    if (chapterModel) {
        
        self.playerModel.videoURL = [NSURL URLWithString:checkString(_chapterModel.video_url)];
        if (self.notFrist == NO) {
            self.playerModel.seekTime = [_chapterModel.process integerValue];
        }else{
            self.playerModel.seekTime = 0;
        }
        self.chapterID = _chapterModel.chapter_id;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:CATALOGCELLSTATECOLOR object:nil userInfo:@{@"chapterID":self.chapterModel.chapter_id}];
    }
}

/**
 切换视频

 @param videoInfo 视频信息
 */
- (void)setVideoInfo:(NSDictionary *)videoInfo{
    if (videoInfo) {
        self.coverView.fullScreenBtn.enabled = NO;
        self.coverView.learnView.hidden = YES;
        self.coverView.testView.hidden = YES;
        self.resetButton.hidden = YES;
        WYACourseCatalogChaptersModel * chapterModel = (WYACourseCatalogChaptersModel *)videoInfo[@"model"];
        chapterModel.process = @"0";
       
        self.chapterModel = chapterModel;
        self.notFrist = YES;
        [self.playerView resetToPlayNewVideo:self.playerModel];
        self.coverView.playButton.selected = YES;
//        [self.playerView pause];
//        self.chapterID = chapterModel.chapter_id;
    }
}

- (void)setNeedSuspended:(BOOL)needSuspended{
    if (needSuspended) {
        self.coverView.playButton.selected = NO;
        [self.playerView pause];
        
    }
}

- (void)setResetVideo:(BOOL)resetVideo{
    if (resetVideo) {
        [self.playerView pause];
        [self.playerView resetPlayer];
        self.coverView.videoCoverViewControlDelegate = nil;
        self.playerView.delegate = nil;
        
        [self.playerView removeFromSuperview];
        
    }
}

- (void)setPushOrPresent:(BOOL)pushOrPresent{
    _pushOrPresent = pushOrPresent;
    self.playerView.playerPushedOrPresented = _pushOrPresent;
}

- (void)dealloc{
    if (self.coverView) {
        self.coverView = nil;
    }
    
    if (self.playerView) {
        self.playerView = nil;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
