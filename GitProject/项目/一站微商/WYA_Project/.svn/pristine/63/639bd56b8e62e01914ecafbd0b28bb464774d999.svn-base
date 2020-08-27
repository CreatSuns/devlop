//
//  WYACourseCatalogVC.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/13.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYACourseCatalogVC.h"
#import "WYACourseCatalogHeadView.h"
#import "WYACourseCatalogFootView.h"
#import "WYACourseCatalogCell.h"
#import "WYACourseCatalogNetRequst.h"

#import "WYAReportViewController.h"
#import "WYATestVolumeViewController.h"
#import "WYACourseDetailVC.h"
#import "WYALocalDownloadModel.h"

@interface WYACourseCatalogVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) WYACourseCatalogNetRequst * netRequest;

@property (nonatomic, strong) WYACourseCatalogModel * courseCatalogModel;

@property (nonatomic, strong) WYACourseCatalogCell * onCell;

@property (nonatomic, strong) WYACourseCatalogChaptersModel * recordModel;

@property (nonatomic, copy) NSString * notChapterID; //通知传递的chanpterID

@property (nonatomic, assign) BOOL flag;    //cell被点击状态

@end

@implementation WYACourseCatalogVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self loadCourseCatalogData];
    [self addNotice];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- Lazy
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];
        [_tableView registerClass:[WYACourseCatalogCell class] forCellReuseIdentifier:@"catalogCell"];
        [_tableView registerClass:[WYACourseCatalogHeadView class] forHeaderFooterViewReuseIdentifier:@"head"];
        [_tableView registerClass:[WYACourseCatalogFootView class] forHeaderFooterViewReuseIdentifier:@"foot"];
    }
    return _tableView;
}

- (WYACourseCatalogNetRequst *)netRequest{
    if (!_netRequest) {
        _netRequest = [[WYACourseCatalogNetRequst alloc]init];
    }
    return _netRequest;
}

#pragma mark --- Private method
- (void)addNotice{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(needCatalogCellChangeColor:) name:CATALOGCELLSTATECOLOR object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadCourseCatalogData) name:CATALOGNEEDRELOADDATA object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upDataCell) name:WYADOWNLOADFILESTATE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upDateTableView) name:TESTCOMPLETED object:nil];
    
}

#pragma mark --- NSNotification
- (void)needCatalogCellChangeColor:(NSNotification *)not{
    self.videoModel = nil;
    self.recordModel = nil;
    self.notChapterID = not.userInfo[@"chapterID"];
    [self loadCourseCatalogData];
}

- (void)loadCourseCatalogData{
    
    NSMutableDictionary * params = [NSMutableDictionary new];
    [params setValue:[NSNumber numberWithInteger:self.model.course_id] forKey:@"course_id"];
    
    [self.netRequest loadCourseCatalogWithParams:params Success:^(id data) {
        if (!data) return;
        WYACourseCatalogModel * catalogModel = (WYACourseCatalogModel *)data;
        if (self.onlyShowDownloadFinish) {
            NSArray * array = [self.netRequest queryFileDownloadState:self.tableName QueryConditions:@"WHERE fileState = '4'"];
            
            for (int a = 0; a < catalogModel.groups.count; a++) {
                WYACourseCatalogGroupsModel * groupModel = catalogModel.groups[a];
                for (int b = 0; b < groupModel.chapters.count; b++) {
                    WYACourseCatalogChaptersModel * chapterModel = groupModel.chapters[b];
                    for (int c = 0; c < array.count; c++) {
                        WYALocalDownloadModel * localModel = array[c];
                        if (![localModel.fileID isEqualToString:chapterModel.chapter_id] && [localModel.fileNumber isEqualToString:@"2"]) {
                            [groupModel.chapters removeObject:chapterModel];
                        }
                    }
                }
            }
        }
        
        self.courseCatalogModel = catalogModel;
        
        [self.tableView reloadData];
        
        
        if (self.courseCatalogModel.course_paper) {
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44.f)];
            view.backgroundColor = [UIColor whiteColor];
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, (44-16)/2, 16, 16)];
            imageView.image = [UIImage imageNamed:@"考试成绩"];
            [view addSubview:imageView];
            
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right+10, 0, ScreenWidth-imageView.right-100, 44)];
            if (self.courseCatalogModel.course_paper) {
                label.text = checkString(self.courseCatalogModel.course_paper.paper_title);
            }
            
            label.font = [UIFont systemFontOfSize:15.f];
            label.textColor = [UIColor WYAJHBlackTextColor];
            [view addSubview:label];
            
            UILabel * pointsLabel = [[UILabel alloc]initWithFrame:CGRectMake(label.right, 0, 80, 44)];
            if (self.courseCatalogModel.course_paper.points) {
                pointsLabel.text = [NSString stringWithFormat:@"%@分",self.courseCatalogModel.course_paper.points];
            }
            pointsLabel.textAlignment = NSTextAlignmentRight;
            pointsLabel.font = [UIFont systemFontOfSize:12.f];
            pointsLabel.textColor = [UIColor WYAJHBaseRedColor];
            [view addSubview:pointsLabel];
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = view.frame;
            [button addTarget:self action:@selector(goTestPaperClick) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
            self.tableView.tableFooterView = view;
            
        }
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}

- (void)upDataCell{
    [self loadCourseCatalogData];
}

- (void)upDateTableView{
    [self loadCourseCatalogData];
}


#pragma mark --- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.courseCatalogModel.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    WYACourseCatalogGroupsModel * groupModel = self.courseCatalogModel.groups[section];
    return groupModel.flag ? groupModel.chapters.count : 0 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WYACourseCatalogCell * cell = [[WYACourseCatalogCell alloc]initWithStyle:0 reuseIdentifier:@"cell"];
    
    WYACourseCatalogGroupsModel * groupModel = self.courseCatalogModel.groups[indexPath.section];
    WYACourseCatalogChaptersModel * chapterModel = groupModel.chapters[indexPath.row];
    
    cell.model = chapterModel;
    
    if (self.videoModel) {
        //页面初次加载时传入的播放视频的model
        cell.pushModel = self.videoModel;
    }else{
        if (self.flag == NO) {
            
        }else{
            //点击cell的model
            cell.currentModel = self.recordModel;
        }
        if ([self.notChapterID isEqualToString:chapterModel.chapter_id]) {
            cell.currentModel = nil;
            cell.videoTitleLabel.textColor = [UIColor WYAJHBasePurpleColor];
        }
    }
    
    cell.canWatchVideo = ^(WYACourseCatalogChaptersModel * chapterModel) {
        self.flag = YES;
        self.notChapterID = nil;
        self.videoModel = nil;
        self.recordModel = chapterModel;
        
        NSMutableDictionary * params = [NSMutableDictionary dictionaryWithCapacity:0];
        [params setObject:chapterModel forKey:@"model"];
        
        NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter postNotificationName:SWITCHPLAYVIDEO object:nil userInfo:params];
        [self loadCourseCatalogData];
    };
    cell.testPaper = ^(ChapterTestPaperType paperType, NSString *paperID) {
        
        if (paperType == ChapterWatchTestPaper) {
            self.lastVC.detailView.needSuspended = YES;
            //不需要测试，跳转测试卷答题报告
            WYAReportViewController * vc = [[WYAReportViewController alloc]init];
            vc.paper_id = paperID;
            vc.reportPushType = WYAReportPushForCourseController;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (paperType == ChapterNeedTestPaper){
            //需要测试，跳转测试卷测试
            WYATestVolumeViewController * vc = [[WYATestVolumeViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.pushFromWhere = WYATestPushForCourseController;
            vc.paper_id = paperID;
            
            NSString * skip = self.model.allow_skip;
            if ([skip isEqualToString:@"2"]) {
                //限制乱序播放（顺序播放）
                if (indexPath.row == 0) {
                    //第一行
                    if (indexPath.section == 0) {
                        //第一个区
                        [self.navigationController pushViewController:vc animated:YES];
                        
                        
                        NSString * currentSceonds = [WYAJHTools getNowTimeTimestampForSeconds];
                        [[NSUserDefaults standardUserDefaults] setObject:currentSceonds forKey:@"beginTime"];
                        self.lastVC.detailView.needSuspended = YES;
                    }else{
                        WYACourseCatalogGroupsModel * groupModel = self.courseCatalogModel.groups[indexPath.section - 1];
                        WYACourseCatalogGroupPaperModel * paperModel = groupModel.group_paper;
                        if (paperModel.points) {
                            //上个章节考试完成
                            [self.navigationController pushViewController:vc animated:YES];
                            
                            
                            NSString * currentSceonds = [WYAJHTools getNowTimeTimestampForSeconds];
                            [[NSUserDefaults standardUserDefaults] setObject:currentSceonds forKey:@"beginTime"];
                            self.lastVC.detailView.needSuspended = YES;
                        }else{
                            [WYAShowMessageView showToastAWithMessage:@"上章节有未完成的测试卷"];
                        }
                    }
                }else{
                    //不是第一行
                    WYACourseCatalogGroupsModel * groupModel = self.courseCatalogModel.groups[indexPath.section];
                    WYACourseCatalogChaptersModel * chapterModel = groupModel.chapters[indexPath.row - 1];
                    WYACourseCatalogChapterPaperModel * paperModel = chapterModel.chapter_paper;
                    if (paperModel.points) {
                        //当前章上个节考试已完成
                        [self.navigationController pushViewController:vc animated:YES];
                        
                        
                        NSString * currentSceonds = [WYAJHTools getNowTimeTimestampForSeconds];
                        [[NSUserDefaults standardUserDefaults] setObject:currentSceonds forKey:@"beginTime"];
                        self.lastVC.detailView.needSuspended = YES;
                    }else{
                        [WYAShowMessageView showToastAWithMessage:@"上节有未完成的测试卷"];
                    }
                }
            }else if ([skip isEqualToString:@"1"]) {
                //不限制乱序播放
                WYACourseCatalogGroupsModel * groupModel = self.courseCatalogModel.groups[indexPath.section];
                WYACourseCatalogChaptersModel * chapterModel = groupModel.chapters[indexPath.row];
                if (chapterModel.is_completed) {
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    
                    NSString * currentSceonds = [WYAJHTools getNowTimeTimestampForSeconds];
                    [[NSUserDefaults standardUserDefaults] setObject:currentSceonds forKey:@"beginTime"];
                    self.lastVC.detailView.needSuspended = YES;
                }else{
                    [WYAShowMessageView showToastAWithMessage:@"该节有未看完的视频"];
                }
            }
            
            
        }
        
    };
    
    NSArray * array = [self.netRequest queryFileDownloadState:self.tableName QueryConditions:nil];
    for (WYALocalDownloadModel * model in array) {
        if ([model.fileID isEqualToString:chapterModel.chapter_id] && [model.fileNumber isEqualToString:@"2"]) {
            switch (model.fileState) {
                case 0:
                    // 未下载 或 下载删除了
                    break;
                case 1:
                    // 等待下载
                    cell.downloadlabel.text = @"等待下载";
                    break;
                case 2:
                    // 正在下载
                    cell.downloadlabel.text = @"下载中";
                    break;
                case 3:
                    // 下载暂停
                    cell.downloadlabel.text = @"暂停下载";
                    break;
                case 4:
                    // 下载完成
                    cell.downloadlabel.text = @"已下载";
                    break;
                case 5:
                    // 下载失败
                    cell.downloadlabel.text = @"下载失败";
                    break;
                default:
                    break;
            }
            
        }
    }
    
    return cell;
}

#pragma mark --- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WYACourseCatalogGroupsModel * groupModel = self.courseCatalogModel.groups[indexPath.section];
    WYACourseCatalogChaptersModel * chapterModel = groupModel.chapters[indexPath.row];
    return [WYACourseCatalogCell cellHeight:chapterModel];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    WYACourseCatalogGroupsModel * groupModel = self.courseCatalogModel.groups[section];
    if (groupModel.group_paper) {
        return 44*heightScale;
    }else{
        return 0.1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WYACourseCatalogHeadView * headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    headView.model = self.courseCatalogModel.groups[section];
    headView.HeaderClickedBack = ^(BOOL isExpand){
        
        [tableView reloadSections:[[NSIndexSet alloc] initWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    WYACourseCatalogFootView * footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"foot"];
    WYACourseCatalogGroupsModel * groupModel = self.courseCatalogModel.groups[section];
    footView.model = groupModel.group_paper;
    footView.testPaper = ^(GroupTestPaperType paperType, NSString *papaerID) {
        if (paperType == GroupNeedTestPaper) {
            //需要测试，跳转测试卷测试
            
            WYATestVolumeViewController * vc = [[WYATestVolumeViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.pushFromWhere = WYATestPushForCourseController;
            vc.paper_id = papaerID;
            
            
            NSString * skip = self.model.allow_skip;
            if ([skip isEqualToString:@"2"]) {
                //限制乱序播放（顺序播放）
                if (section == 0) {
                    //点击的是第一行
                    WYACourseCatalogGroupsModel * group = self.courseCatalogModel.groups[section];
                    
                    __block NSInteger index;
                    [group.chapters enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        WYACourseCatalogChaptersModel * model = (WYACourseCatalogChaptersModel *)obj;
                        if (model.chapter_paper) {
                            WYACourseCatalogChapterPaperModel * chapterPaper = model.chapter_paper;
                            if (!chapterPaper.points) {
                                [WYAShowMessageView showToastAWithMessage:@"该章有未完成的测试卷"];
                                *stop = YES;
                            }else{
                                index ++;
                                if (index == group.chapters.count) {
                                    self.lastVC.detailView.needSuspended = YES;
                                    [self.navigationController pushViewController:vc animated:YES];
                                    
                                    NSString * currentSceonds = [WYAJHTools getNowTimeTimestampForSeconds];
                                    [[NSUserDefaults standardUserDefaults] setObject:currentSceonds forKey:@"beginTime"];
                                }
                            }
                        }else{
                            [WYAShowMessageView showToastAWithMessage:@"该章有未完成的测试卷"];
                            *stop = YES;
                        }
                    }];
                }else{
                    WYACourseCatalogGroupsModel * group = self.courseCatalogModel.groups[section];
                    WYACourseCatalogGroupsModel * lastGroup = self.courseCatalogModel.groups[section - 1];
                    WYACourseCatalogGroupPaperModel * lastGroupPaper = lastGroup.group_paper;
                    
                    if (lastGroupPaper.points) {
                        //上个章都考完试了
                        __block NSInteger index;
                        [group.chapters enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            WYACourseCatalogChaptersModel * model = (WYACourseCatalogChaptersModel *)obj;
                            if (model.chapter_paper) {
                                WYACourseCatalogChapterPaperModel * chapterPaper = model.chapter_paper;
                                if (!chapterPaper.points) {
                                    [WYAShowMessageView showToastAWithMessage:@"该章有未完成的测试卷"];
                                    *stop = YES;
                                }else{
                                    index ++;
                                    if (index == group.chapters.count) {
                                        self.lastVC.detailView.needSuspended = YES;
                                        [self.navigationController pushViewController:vc animated:YES];
                                        
                                        NSString * currentSceonds = [WYAJHTools getNowTimeTimestampForSeconds];
                                        [[NSUserDefaults standardUserDefaults] setObject:currentSceonds forKey:@"beginTime"];
                                    }
                                }
                            }else{
                                [WYAShowMessageView showToastAWithMessage:@"该章有未完成的测试卷"];
                                *stop = YES;
                            }
                        }];
                    }else{
                        //上个章节没有考完
                        [WYAShowMessageView showToastAWithMessage:@"上章有未完成的测试卷"];
                    }
                }
            }else if ([skip isEqualToString:@"1"]){
                //乱序播放
                self.lastVC.detailView.needSuspended = YES;
                [self.navigationController pushViewController:vc animated:YES];
                
                NSString * currentSceonds = [WYAJHTools getNowTimeTimestampForSeconds];
                [[NSUserDefaults standardUserDefaults] setObject:currentSceonds forKey:@"beginTime"];
            }
            
        }else{
            //不需要测试，跳转测试卷答题报告
            self.lastVC.detailView.needSuspended = YES;
            WYAReportViewController * vc = [[WYAReportViewController alloc]init];
            vc.paper_id = papaerID;
            vc.reportPushType = WYAReportPushForCourseController;
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    return footView;
}

- (void)goTestPaperClick{
    if (self.courseCatalogModel.course_paper.points) {
        self.lastVC.detailView.needSuspended = YES;
        //不需要测试，跳转测试卷答题报告
        WYAReportViewController * vc = [[WYAReportViewController alloc]init];
        vc.paper_id = self.courseCatalogModel.course_paper.paper_id;
        vc.reportPushType = WYAReportPushForCourseController;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        //需要测试，跳转测试卷测试
        WYATestVolumeViewController * vc = [[WYATestVolumeViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.pushFromWhere = WYATestPushForCourseController;
        vc.paper_id = self.courseCatalogModel.course_paper.paper_id;
        
        
        NSString * skip = self.model.allow_skip;
        
        if ([skip isEqualToString:@"2"]) {
            //限制乱序播放（顺序播放）
            __block NSInteger index;
            [self.courseCatalogModel.groups enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                WYACourseCatalogGroupsModel * group = (WYACourseCatalogGroupsModel *)obj;
                if (group.group_paper) {
                    WYACourseCatalogGroupPaperModel * paper = group.group_paper;
                    if (paper.points) {
                        index ++;
                        if (index == self.courseCatalogModel.groups.count) {
                            self.lastVC.detailView.needSuspended = YES;
                            [self.navigationController pushViewController:vc animated:YES];
                            
                            NSString * currentSceonds = [WYAJHTools getNowTimeTimestampForSeconds];
                            [[NSUserDefaults standardUserDefaults] setObject:currentSceonds forKey:@"beginTime"];
                        }else{
                            [WYAShowMessageView showToastAWithMessage:@"有未完成的测试卷"];
                            *stop = YES;
                        }
                    }else{
                        [WYAShowMessageView showToastAWithMessage:@"有未完成的测试卷"];
                        *stop = YES;
                    }
                }else{
                    [WYAShowMessageView showToastAWithMessage:@"有未完成的测试卷"];
                    *stop = YES;
                }
            }];
        }else if ([skip isEqualToString:@"1"]){
            self.lastVC.detailView.needSuspended = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
            NSString * currentSceonds = [WYAJHTools getNowTimeTimestampForSeconds];
            [[NSUserDefaults standardUserDefaults] setObject:currentSceonds forKey:@"beginTime"];
        }
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
