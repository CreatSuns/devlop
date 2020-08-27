//
//  WYAMineViewController.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/4.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//      

#import "WYAMineViewController.h"
#import "WYAMineTableView.h"
#import "WYAMineHeaderView.h"
#import "WYAOpinionVC.h"
#import "WYASettingTableVC.h"
#import "WYAMyCourseListVC.h"
#import "WYANewCourseVC.h"
#import "WYAAttentionViewController.h"
#import "WYATestVolumeViewController.h"
#import "WYATestScoresVC.h"
#import "WYAMineCollectionVC.h"
#import "WYAMineInfoVC.h"
#import "WYAMineAdminInfoNetRequest.h"
#import "WYAMineDownloadVC.h"

@interface WYAMineViewController ()<WYAMineTableViewDelegate,WYAMineHeaderViewDelegate>
@property(nonatomic, strong) WYAMineTableView * mineTableView;
@property(nonatomic, strong) WYAMineHeaderView * mineTableHeaderView;
@property(nonatomic, strong) WYAMineAdminInfoNetRequest * netRequest;
@end

@implementation WYAMineViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self.netRequest mineAdminInfoWithParams:[NSMutableDictionary dictionary] Success:^(id data) {
        self.mineTableHeaderView.model = data;
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mineTableView];
  

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    
    // Dispose of any resources that can be recreated.
}
#pragma mark ====== get Admin_info
- (WYAMineAdminInfoNetRequest *)netRequest
{
    if (_netRequest == nil) {
        _netRequest = [[WYAMineAdminInfoNetRequest alloc]init];
    }
    return _netRequest;
}
#pragma mark ====== creat UI
- (WYAMineHeaderView *)mineTableHeaderView
{
    if (_mineTableHeaderView == nil) {
        _mineTableHeaderView = [[WYAMineHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,Size_ratio*275.f+RectStatus.size.height)];
        _mineTableHeaderView.backgroundColor = [UIColor whiteColor];
        _mineTableHeaderView.delegate = self;
      
    }
    return _mineTableHeaderView;
}
- (UITableView *)mineTableView
{
    if (_mineTableView == nil) {
        _mineTableView = [[WYAMineTableView alloc]initWithFrame:CGRectMake(0, -(RectStatus.size.height), ScreenWidth, ScreenHeight)];
        _mineTableView.mineDelegate = self;
        _mineTableView.tableHeaderView = self.mineTableHeaderView;
    }
    return _mineTableView;
}
#pragma mark ====== WYAMineTableViewDelegate
- (void)WYAMineTableViewDidSelectCell:(NSInteger)index
{
    
    switch (index) {
        case 0:
            {
                // 我的收藏
                WYAMineCollectionVC * vc = [[WYAMineCollectionVC alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        case 1:
            {
                // 我的关注
                WYAAttentionViewController * vc = [[WYAAttentionViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        case 2:
            {
                // 我的下载
                WYAMineDownloadVC * vc = [[WYAMineDownloadVC alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        case 3:
            {
                // 意见反馈
                WYAOpinionVC * opinion = [[WYAOpinionVC alloc]init];
                opinion.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:opinion animated:YES];
            }
            break;
        case 4:
            {
                // 设置
                WYASettingTableVC * setting = [[WYASettingTableVC alloc]initWithStyle:UITableViewStylePlain];
                setting.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:setting animated:YES];
            }
            break;
        default:
            break;
    }

    // push对应的控制器
}
#pragma mark ===== WYAMineHeaderViewDelegate
- (void)userIconClickedEvent:(UIButton *)sender
{
    // 用户头像入口
    NSLog(@"usericon");
//    self.mineTableHeaderView.model.shop_logo;
    WYAMineInfoVC * vc = [[WYAMineInfoVC alloc]init];
    vc.model = self.mineTableHeaderView.model;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
- (void)classTableClickedEvent:(UIButton *)sender
{
    // 课表
    NSLog(@"class");
    
    WYAMyCourseListVC * courseList = [[WYAMyCourseListVC alloc]init];
    courseList.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:courseList animated:YES];
}
- (void)testScoresClickedEvent:(UIButton *)sender
{
    //测试成绩
    NSLog(@"test");
    
    WYATestScoresVC * vc = [[WYATestScoresVC alloc]init];
    
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];



}
- (void)courseNewClickedEvent:(UIButton *)sender
{
    //新课上架
    NSLog(@"course");
    
    WYANewCourseVC * newCourse = [[WYANewCourseVC alloc]initWithStyle:UITableViewStylePlain];
    newCourse.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newCourse animated:YES];
    
    
}
@end
