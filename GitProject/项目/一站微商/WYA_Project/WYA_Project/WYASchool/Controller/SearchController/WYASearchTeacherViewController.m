//
//  WYASearchArticleViewController.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/25.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYASearchTeacherViewController.h"
#import "WYALecturerTableViewCell.h"
#import "WYALecturerModel.h"
#import "WYALecturerPersonalVC.h"
#import "WYALecturerNetRequest.h"
#define Lecturer_Cell @"LecturerTableViewCell"

@interface WYASearchTeacherViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView * searchTeacherTabView;
@property(nonatomic, strong) WYALecturerNetRequest *netRequest;
@property(nonatomic, strong) WYAEmptyDataView * emptyView;
@end
static NSInteger tempPage = 1;

@implementation WYASearchTeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _teacherDataSources = [NSMutableArray array];
    [self.view addSubview:self.searchTeacherTabView];
    [self refreshNewData];
    [self.searchTeacherTabView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark ====== netRequest
- (WYALecturerNetRequest *)netRequest{
    if(_netRequest == nil){
        _netRequest = [[WYALecturerNetRequest alloc]init];
    }
    return _netRequest;
}
#pragma mark ====== refresh
- (void)refreshNewData
{
    __weak typeof(self) weakSelf = self;
    self.searchTeacherTabView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        tempPage--;
        if (tempPage <= 1) {
            tempPage = 1;
        }
        [weakSelf featchData:tempPage];
        
    }];
    [self.searchTeacherTabView.mj_header beginRefreshing];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.searchTeacherTabView.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    self.searchTeacherTabView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        tempPage++;
        [weakSelf featchData:tempPage];
        
        
    }];
}
- (void)featchData:(NSInteger)tempPage{
    if (self.searchText) {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"page"] = @(tempPage);
    dic[@"search"] = self.searchText;
    [self.netRequest lecturerListDataWithParams:dic Success:^(id data) {
        [self.searchTeacherTabView.mj_header endRefreshing];
        [self.searchTeacherTabView.mj_footer endRefreshing];
        if (tempPage == 1) {
            [self.teacherDataSources removeAllObjects];
            self.teacherDataSources = data;
        }else if (data != nil)
        {
            [self.teacherDataSources addObjectsFromArray:data];
        }
        if(self.teacherDataSources &&self.teacherDataSources.count!=0){
            [self.emptyView removeFromSuperview];
            [self.searchTeacherTabView reloadData];
        }else
        {
            
            [self.searchTeacherTabView addSubview:self.emptyView];
        }
        
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        [self.searchTeacherTabView.mj_header endRefreshing];
        [self.searchTeacherTabView.mj_footer endRefreshing];
    }];
        
    }
}
#pragma mark ====== createUI
- (WYAEmptyDataView *)emptyView
{
    if (_emptyView == nil) {
        _emptyView = [[WYAEmptyDataView alloc]initWithFrame:CGRectMake(0,6.5*Size_ratio, ScreenWidth, ScreenHeight- WYATabBarHeight-WYATopHeight-43.5*Size_ratio)];
    }
    return _emptyView;
}
- (UITableView *)searchTeacherTabView
{
    if (_searchTeacherTabView == nil) {
        _searchTeacherTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-WYANavBarHeight-WYAStatusBarHeight-WYATabBarHeight) style:UITableViewStylePlain];
        [_searchTeacherTabView registerClass:[WYALecturerTableViewCell class] forCellReuseIdentifier:Lecturer_Cell];
        _searchTeacherTabView.dataSource = self;
        _searchTeacherTabView.delegate = self;
        _searchTeacherTabView.showsVerticalScrollIndicator = NO;
        [_searchTeacherTabView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        _searchTeacherTabView.separatorInset = UIEdgeInsetsMake(0, 0, 0,0);
    }
    return _searchTeacherTabView;
}
#pragma mark tableDelegate
#pragma mark ====== UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.teacherDataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYALecturerTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Lecturer_Cell];
    if (cell == nil) {
        cell = [[WYALecturerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Lecturer_Cell];
    }
    cell.cellModel = self.teacherDataSources[indexPath.row];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
// cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 117*Size_ratio;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    cell点击事件文章详情
    WYALecturerModel * lecturerModel = self.teacherDataSources[indexPath.row];
    WYALecturerPersonalVC * personalVc = [[WYALecturerPersonalVC alloc]init];
    personalVc.teacher_name = lecturerModel.teacher_name;
    personalVc.teacher_id = lecturerModel.teacher_id;
    [self.navigationController pushViewController:personalVc animated:YES];
}
@end
