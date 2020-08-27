//
//  WYAVideoControlView.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/11.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAVideoControlView.h"
#import <AFNetworkReachabilityManager.h>

@interface WYAVideoControlView ()<TestPaperDelegate>

@property (nonatomic, strong) LastChapter * lastChapter;

/**
 是否是第一次进入课程详情播放视频的
 */
@property (nonatomic, assign) BOOL notFristPlayVideo;
@end

@implementation WYAVideoControlView

- (UIButton *)playButton{
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateSelected];
        [_playButton addTarget:self action:@selector(playButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _playButton.hidden = YES;
    }
    return _playButton;
}

- (UIView *)learnView{
    if (!_learnView) {
        _learnView = [[UIView alloc]init];
        _learnView.backgroundColor = [UIColor colorWithWhite:0.05 alpha:0.0];//
    }
    return _learnView;
}

- (UILabel *)learnLabel{
    if (!_learnLabel) {
        _learnLabel = [[UILabel alloc]init];
        _learnLabel.textColor = [UIColor whiteColor];
        _learnLabel.font = [UIFont systemFontOfSize:14];
        _learnLabel.textAlignment = NSTextAlignmentCenter;
        _learnLabel.text = @"最近学到: ";
    }
    return _learnLabel;
    
}

- (UIButton *)learnButton{
    if (!_learnButton) {
        _learnButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_learnButton setBackgroundColor:[UIColor clearColor]];
        [_learnButton setTitle:@"开始学习" forState:UIControlStateNormal];
        [_learnButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_learnButton addTarget:self action:@selector(startLearnClick) forControlEvents:UIControlEventTouchUpInside];
        _learnButton.titleLabel.font = [UIFont systemFontOfSize:15*Size_ratio];
        _learnButton.layer.cornerRadius = 5.f;
        _learnButton.layer.masksToBounds = YES;
        _learnButton.layer.borderWidth = 0.5;
        _learnButton.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _learnButton;
}

-(WYACourseTestView *)testView{
    if (!_testView) {
        _testView = [[WYACourseTestView alloc]init];
        _testView.testDelegate = self;
        _testView.hidden = YES;
    }
    return _testView;
}

-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        self.fullScreenBtn.enabled = NO;
        [self addSubview:self.playButton];
        [self addSubview:self.learnView];
        [self.learnView addSubview:self.learnLabel];
        [self.learnView addSubview:self.learnButton];
        
        [self.learnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(50, 50, 50, 50));
        }];
        [self.learnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.learnView.mas_centerY).with.offset(-20.f);
            make.centerX.mas_equalTo(self.learnView.mas_centerX);
        }];
        [self.learnButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.learnView.mas_centerX);
            make.centerY.mas_equalTo(self.learnView.mas_centerY).with.offset(20.f);
            make.width.mas_equalTo(88*Size_ratio);
            make.height.mas_equalTo(29*Size_ratio);
        }];
        
        [self addSubview:self.testView];
        
        [self.testView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(50, 50, 50, 50));
        }];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.playButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(36.f, 36.f));
    }];
    
    
}


#pragma mark Setter
- (void)setChapter:(LastChapter *)chapter{
    if (chapter) {
        self.lastChapter     = chapter;
        self.learnLabel.text = [NSString stringWithFormat:@"最近学到： %@",chapter.chapter_title];
        [self.learnButton setTitle:@"继续学习" forState:UIControlStateNormal];
    }
}

#pragma mark Private method
- (void)playButtonClick:(UIButton *)sender{
    
    if (self.notFristPlayVideo == NO && [self.lastChapter.process floatValue] == 0) {
        [self startLearnClick];
        self.notFristPlayVideo = YES;
    }
    sender.selected = !sender.selected;
    
    if (self.videoCoverViewControlDelegate && [self.videoCoverViewControlDelegate respondsToSelector:@selector(videoPlayButtonClick: Progress:)]) {
        [self.videoCoverViewControlDelegate videoPlayButtonClick:sender Progress:nil];
    }
    if (sender.selected) {
        [UIView animateWithDuration:0.35f animations:^{
            
        } completion:^(BOOL finished) {
            self.playButton.hidden = YES;
        }];
    }
    
}

- (void)startLearn{
    self.fullScreenBtn.enabled = YES;
    self.learnView.hidden = YES;
    
    self.playButton.selected = YES;
    self.playButton.hidden = NO;
    self.playButton.alpha = 1;

    if (self.videoCoverViewControlDelegate && [self.videoCoverViewControlDelegate respondsToSelector:@selector(videoStartLearnClick:)]) {
        [self.videoCoverViewControlDelegate videoStartLearnClick:self.learnButton];
    }
}

- (void)goTest{
    
    if (self.videoCoverViewControlDelegate && [self.videoCoverViewControlDelegate respondsToSelector:@selector(goTestPaper)]) {
        [self.videoCoverViewControlDelegate goTestPaper];
    }
}

#pragma mark Private method
- (void)startLearnClick{
    
    AFNetworkReachabilityManager * manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown) {
            [self startLearn];
        }else if (status == AFNetworkReachabilityStatusNotReachable) {
            
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
            NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
            
            if ([ud boolForKey:AllowDataConnectionAndPlay]) {
                [self startLearn];
            }else{
                self.showAlert();
            }
        }else if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
            [self startLearn];
        }
    }];
    // 开始监控
    [manager startMonitoring];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
