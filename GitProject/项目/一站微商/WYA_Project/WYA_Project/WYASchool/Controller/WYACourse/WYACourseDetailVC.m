//
//  WYACourseDetailVC.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/11.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
// 

#import "WYACourseDetailVC.h"

#import "WYACourseShortIntroductionVC.h"
#import "WYACourseCatalogVC.h"
#import "WYACourseDownloadTableVC.h"
#import "WYATestVolumeViewController.h"
#import "WYAChooseDownloadVC.h"

#import "WYACouresNetRequest.h"
#import "WYACourseCatalogNetRequst.h"

#import "WYACourseDetailModel.h"
#import "WYACourseCatalogModel.h"
#import "WYATableNameModel.h"
#import "WYALocalDownloadModel.h"

#import "WYANetErrorView.h"

@interface WYACourseDetailVC ()<WYAVideoControlDelegate>

@property (nonatomic, strong) WYACouresNetRequest * netRequest;
@property (nonatomic, strong) WYACourseCatalogNetRequst * catalogNetRequest;
@property (nonatomic, strong) WYANetErrorView * netErrorView;
@property (nonatomic, strong) WYACourseDetailModel * conversionModel;
@property (nonatomic, strong) WYACourseCatalogModel * catalogModel;

@property (nonatomic, assign) NSInteger currentGroupVideoNumber;
@property (nonatomic, assign) NSInteger currentChapterVideoNumber;
@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) JQFMDB * fmdb;

@property (nonatomic, assign) BOOL isReportVCPop;   //是否从试卷返回

@property (nonatomic, assign) BOOL isDetailVCPop;   //是否从详情页面返回

@end

@implementation WYACourseDetailVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self preferredStatusBarStyle];
    
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.detailView];
    
    self.viewFrame = CGRectMake(0, WYAiPhoneX ? 211.f*Size_ratio+WYAStatusBarHeight:211.f*Size_ratio, ScreenWidth, WYAiPhoneX ? ScreenHeight-211.f*Size_ratio-WYAStatusBarHeight :ScreenHeight-211.f*Size_ratio);
    self.menuView.backgroundColor = [UIColor whiteColor];
    
    [self configUI];
    [self configNotice];
    [self configUserDefaults];
    [self configFMDB];
    [self loadCourseDetailData];
    [self loadCourseCatalogData];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
    [self uploadLearnTime];
    
    self.detailView.pushOrPresent = YES;
    
    if (self.isDetailVCPop) {
        self.detailView.resetVideo = YES;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent; 
}

- (void)dealloc{
    self.detailView.videoControlDelegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SWITCHPLAYVIDEO object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TESTCOMPLETED object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---- 懒加载
- (JQFMDB *)fmdb{
    if (!_fmdb) {
        _fmdb = [JQFMDB shareDatabase:FileDownload_DataBase path:[NSString downloadFilePath]];
    }
    return _fmdb;
}

-(WYACourseDetailView *)detailView{
    if (!_detailView) {
        _detailView = [[WYACourseDetailView alloc] initWithFrame:CGRectMake(0, WYAiPhoneX ? 44:0, ScreenWidth, 211.f*Size_ratio) PlaceHoldImage:self.img_url];
        _detailView.videoControlDelegate = self;
        
        WeakSelf(weakSelf);
        _detailView.showAlert = ^{
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"你在当前在3G/4G网络下，下载或观看视频会消耗较多流量，系统已自动暂停，你可在设置界面开启。" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * knowAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:knowAction];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        };
    }
    return _detailView;
}

-(WYACouresNetRequest *)netRequest{
    if (!_netRequest) {
        _netRequest = [[WYACouresNetRequest alloc]init];
    }
    return _netRequest;
}

- (WYACourseCatalogNetRequst *)catalogNetRequest{
    if (!_catalogNetRequest) {
        _catalogNetRequest = [[WYACourseCatalogNetRequst alloc] init];
    }
    return _catalogNetRequest;
}

-(WYANetErrorView *)netErrorView{
    if (!_netErrorView) {
        _netErrorView = [[WYANetErrorView alloc]init];
        _netErrorView.hidden = YES;
    }
    return _netErrorView;
}

#pragma mark --- Private method
- (void)configUI{
    [self.detailView addSubview:self.netErrorView];
    [self.netErrorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(50, 0, 50, 0));
    }];
    
    WeakSelf(weakSelf);
    self.netErrorView.netReload = ^{
        StrongSelf(strongSelf);
        [strongSelf loadCourseDetailData];
        strongSelf.netErrorView.hidden = YES;
    };
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor WYAJHLightGreyColor];
    [self.menuView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.menuView.mas_bottom).offset(0);
        make.left.equalTo(self.menuView.mas_left).offset(0);
        make.right.equalTo(self.menuView.mas_right).offset(0);
        make.height.mas_equalTo(1);
    }];
}

- (void)configFMDB{
    NSArray * array = [self.fmdb jq_lookupTable:FileDownload_TableName
                                     dicOrModel:[WYATableNameModel class]
                                    whereFormat:[NSString stringWithFormat:@"WHERE tableName = '%@'",self.course_title]];
    if (array.count>0)
    {
        //存在总表
    }
    else
    {
        //不存在就创建该课程的表并插入总表中
        WYATableNameModel * tableModel = [[WYATableNameModel alloc]init];
        tableModel.tableName = self.course_title;
        tableModel.course_title = self.course_title;
        tableModel.course_image_url = self.img_url;
        tableModel.course_id = self.course_id;
        tableModel.haveDownloadChapter = @"0";
        [self.fmdb jq_insertTable:FileDownload_TableName dicOrModel:tableModel];
        if ([self.fmdb jq_isExistTable:tableModel.tableName] == NO) {
            BOOL aa = [self.fmdb jq_createTable:tableModel.tableName dicOrModel:[WYALocalDownloadModel class]];
            NSLog(@"aa==%d",aa);
        }
        
    }
}

- (void)configNotice{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(replaceVideoContent:) name:SWITCHPLAYVIDEO object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayerState) name:TESTCOMPLETED object:nil];
}

- (void)configUserDefaults{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (![userDefaults boolForKey:AllowDataConnectionAndPlay]) {
        [userDefaults setBool:NO forKey:AllowDataConnectionAndPlay];
    }
    
    if (![userDefaults boolForKey:AllowDataConnectionAndDownload]) {
        [userDefaults setBool:NO forKey:AllowDataConnectionAndDownload];
    }
}

#pragma mark --- 网络数据相关
- (void)loadCourseDetailData{
    [self.netRequest loadCourseDetailWithParams:[@{@"course_id":checkString(self.courseID)} mutableCopy] Success:^(id data) {
        self.detailView.model = (WYACourseDetailModel *)data;
        self.conversionModel = (WYACourseDetailModel *)data;
        [self reloadData];
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        self.detailView.coverView.learnView.hidden = YES;
        self.netErrorView.hidden = NO;
        
    }];
}

- (void)loadCourseCatalogData{
    [self.catalogNetRequest loadCourseCatalogWithParams:[@{@"course_id":checkString(self.courseID)} mutableCopy] Success:^(id data) {
        self.catalogModel = (WYACourseCatalogModel *)data;
        self.detailView.catalogModel = self.catalogModel;
        if (self.isReportVCPop) {
            [self.detailView loadVideoPlayerAndEndTest];
        }
        
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}

- (void)uploadLearnTime{
    if (self.detailView.learnTime>0 && self.detailView.allTime > 0) {
        NSMutableDictionary * params = [NSMutableDictionary dictionaryWithCapacity:0];
        [params setObject:[NSNumber numberWithInteger:[self.courseID integerValue]] forKey:@"course_id"];
        [params setObject:[NSNumber numberWithInteger:[self.detailView.chapterID integerValue]] forKey:@"chapter_id"];
        [params setObject:[NSNumber numberWithInteger:self.detailView.learnTime] forKey:@"process"];
        if (self.detailView.learnTime >= self.detailView.allTime) {
            [params setObject:@1 forKey:@"is_completed"];
        }else{
            [params setObject:@0 forKey:@"is_completed"];
        }
        [self.netRequest changeLearnTimeWithParmas:params Success:^(id data) {
            
        } Fail:^(NetRequestCode netCode, NSString *errorDes) {
            
        }];
    }
}

#pragma mark --- NSNotification
- (void)replaceVideoContent:(NSNotification *)not{
    //先上传上次播放的视频进度
    [self uploadLearnTime];
    if (not) {
        [self loadCourseCatalogData];
        self.detailView.videoInfo = not.userInfo;
    }
}

- (void)videoPlayerState{
    self.isReportVCPop = YES;
    [self loadCourseCatalogData];
    
}

#pragma mark --- WYAVideoControlDelegate
- (void)videoBackButtonClick{
    self.isDetailVCPop = YES;
    [self.detailView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)videoLikeButtonClick:(UIButton *)sender{
    NSMutableDictionary * params = [@{@"course_id":checkString(self.courseID)} mutableCopy];
    [self.netRequest loadCourseCollectionWithParams:params Success:^(id data) {
        if (sender.selected) {
            sender.selected = NO;
        }else{
            sender.selected = YES;
        }
        [WYAShowMessageView showToastBWithMessage:data[@"msg"]];
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
        [WYAShowMessageView showToastAWithMessage:@"请检查你的网络连接或稍后再试"];
    }];
}

- (void)videoDownloadUrl:(NSString *)url{
    
    WYAChooseDownloadVC * vc = [[WYAChooseDownloadVC alloc]init];
    vc.courseID = checkString(self.courseID);
    vc.skip = self.conversionModel.course_info.allow_skip;
    vc.course_name = self.conversionModel.course_info.course_title;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)goChapterTestPaperWithPaperID:(NSString *)paperID{
    //测试题
    WYATestVolumeViewController * vc = [[WYATestVolumeViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.pushFromWhere = WYATestPushForCourseController;
    vc.paper_id = paperID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)saveCurrentVideoInfo{
    [self uploadLearnTime];
}

- (void)addMyLearnCourses{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:0];
    [dic setObject:self.course_id forKey:@"course_id"];
    [self.netRequest addMyLearnCourseWithParams:dic Success:^(id data) {
        
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}

#pragma mark --- WMPageController
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return 3;
}

- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    if (index == 0) {
        WYACourseShortIntroductionVC * shortIntroduction = [[WYACourseShortIntroductionVC alloc]init];
        if (self.conversionModel) {
            shortIntroduction.model = self.conversionModel.course_info;
        }
        return shortIntroduction;
    }else if (index == 1) {
        WYACourseCatalogVC * catalog = [[WYACourseCatalogVC alloc]init];
        if (self.conversionModel) {
            catalog.model = self.conversionModel.course_info;
        }
        if (self.onlyShowDownloadFinish) {
            catalog.onlyShowDownloadFinish = self.onlyShowDownloadFinish;
        }
        if (self.detailView.chapterModel) {
            catalog.videoModel = self.detailView.chapterModel;
        }
        catalog.tableName = self.course_title;
        catalog.lastVC = self;
        return catalog;
    }else if (index == 2) {
        WYACourseDownloadTableVC * download = [[WYACourseDownloadTableVC alloc]init];
        if (self.conversionModel) {
            download.model = self.conversionModel.course_info;
        }
        download.lastVC = self;
        download.courseID = checkString(self.courseID);
        download.course_name = self.conversionModel.course_info.course_title;
        return download;
    }
    return [[UIViewController alloc]init];
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    switch (index % 3) {
        case 0: return @"简介";
        case 1: return @"目录";
        case 2: return @"课件下载";
    }
    return @"NONE";
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
