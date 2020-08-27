//
//  WYASearchCourseViewController.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/25.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYASearchCourseViewController.h"
#import "WYACouresListCell.h"
#import "WYASearchCourseModel.h"
#import "WYACourseDetailVC.h"
#import "WYACouresListModel.h"
#import "WYACouresNetRequest.h"

#define Course_CELL @"courseTableViewCell"

@interface WYASearchCourseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView * searchCourseTabView;
@property (nonatomic, strong) WYACouresNetRequest * netRequest;
@property(nonatomic, strong) WYAEmptyDataView * emptyView;

@end
static NSInteger tempPage = 1;
@implementation WYASearchCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.searchCourseTabView];
    [self refreshNewData];
    [self.searchCourseTabView.mj_header beginRefreshing];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(WYACouresNetRequest *)netRequest{
    if (!_netRequest) {
        _netRequest = [[WYACouresNetRequest alloc]init];
    }
    return _netRequest;
}
#pragma mark ====== refresh
- (void)refreshNewData
{
    __weak typeof(self) weakSelf = self;
    self.searchCourseTabView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        tempPage--;
        if (tempPage <= 1) {
            tempPage = 1;
        }
        [weakSelf featchData:tempPage];
        
    }];
    [self.searchCourseTabView.mj_header beginRefreshing];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.searchCourseTabView.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    self.searchCourseTabView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        tempPage++;
        [weakSelf featchData:tempPage];
        
        
    }];
}
- (void)featchData:(NSInteger)tempPage{
    if (self.searchText) {
        NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:0];
        [dic setObject:[NSNumber numberWithInteger:tempPage] forKey:@"page"];
        [dic setObject:self.searchText forKey:@"search"];
        
        [self.netRequest loadCouresListWithParams:dic Success:^(id data) {
            WYACouresListModel * model = (WYACouresListModel *)data;
            self.courseDataSources = [model.list mutableCopy];
            [self.searchCourseTabView.mj_header endRefreshing];
            [self.searchCourseTabView.mj_footer endRefreshing];
            if (tempPage == 1) {
                [self.courseDataSources removeAllObjects];
                self.courseDataSources = [model.list mutableCopy];
            }else if (data != nil)
            {
                [self.courseDataSources addObjectsFromArray:[model.list mutableCopy]];
            }
            if(self.courseDataSources &&self.courseDataSources.count!=0){
                [self.emptyView removeFromSuperview];
                [self.searchCourseTabView reloadData];
            }else
            {
                
                [self.searchCourseTabView addSubview:self.emptyView];
            }
            
        } Fail:^(NetRequestCode netCode, NSString *errorDes) {
            [self.searchCourseTabView.mj_header endRefreshing];
            [self.searchCourseTabView.mj_footer endRefreshing];
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
- (UITableView *)searchCourseTabView
{
    if (_searchCourseTabView == nil) {
        _searchCourseTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-WYANavBarHeight-WYAStatusBarHeight-WYATabBarHeight)];
        [_searchCourseTabView registerClass:[WYACouresListCell class] forCellReuseIdentifier:Course_CELL];
        _searchCourseTabView.dataSource = self;
        _searchCourseTabView.delegate = self;
        _searchCourseTabView.showsVerticalScrollIndicator = NO;
        [_searchCourseTabView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        _searchCourseTabView.separatorInset = UIEdgeInsetsMake(0, 0, 0,0);
        
    }
    return _searchCourseTabView;
}
#pragma mark tableDelegate
#pragma mark ====== UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.courseDataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYACouresListCell * cell = [tableView dequeueReusableCellWithIdentifier:Course_CELL];
    if (cell == nil) {
        cell = [[WYACouresListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Course_CELL];
    }
    cell.model = self.courseDataSources[indexPath.row];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

// cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 107*Size_ratio;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    List * listModel = self.courseDataSources[indexPath.row];
    WYACourseDetailVC * courseDetailVc = [[WYACourseDetailVC alloc]init];
    courseDetailVc.courseID = listModel.course_id;
    courseDetailVc.course_title = listModel.course_title;
    courseDetailVc.course_id = listModel.course_id;
    courseDetailVc.img_url = listModel.img_url;
    [self.navigationController pushViewController:courseDetailVc animated:YES];
}
@end
