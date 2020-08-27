//
//  WYALecturerListVC.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/9.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYALecturerListVC.h"
#import "WYALecturerNetRequest.h"
#import "WYALecturerTableViewCell.h"
#import "WYALecturerModel.h"
#import "WYALecturerPersonalVC.h"

#define LECTURER_CELL_ID @" LECTURER_CELL_ID"

@interface WYALecturerListVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong) WYALecturerNetRequest *netRequest;
@property(nonatomic, strong) NSMutableArray *dataSources;
@property(nonatomic, strong) UITableView *lecturerListView;
@property(nonatomic, strong) WYAEmptyDataView * emptyView;

@end
static NSInteger tempPage = 1;
@implementation WYALecturerListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.lecturerListView];
    self.view.backgroundColor = [UIColor WYAJHLightGreyColor];
    [self refreshNewData];
    [self.lecturerListView.mj_header beginRefreshing];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark ====== refresh
- (void)refreshNewData
{
    __weak typeof(self) weakSelf = self;
    self.lecturerListView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        tempPage--;
        if (tempPage <= 1) {
            tempPage = 1;
        }
        [weakSelf featchData:tempPage];
        
    }];
    [self.lecturerListView.mj_header beginRefreshing];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.lecturerListView.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    self.lecturerListView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        tempPage++;
        [weakSelf featchData:tempPage];
        
        
    }];
}
- (void)featchData:(NSInteger)tempPage{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"page"] = @(tempPage);
    [self.netRequest lecturerListDataWithParams:dic Success:^(id data) {
        [self.lecturerListView.mj_header endRefreshing];
        [self.lecturerListView.mj_footer endRefreshing];
        if (tempPage == 1) {
            [self.dataSources removeAllObjects];
            self.dataSources = data;
            [self.lecturerListView reloadData];

        }else if (data != nil)
        {
            NSArray * array = data;
            if (array&&array.count!=0) {
                [self.dataSources addObjectsFromArray:data];
                [self.lecturerListView reloadData];
                [self.lecturerListView.mj_footer endRefreshing];
                
            }else
            {
                [self.lecturerListView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        
        
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        [self.lecturerListView.mj_header endRefreshing];
        [self.lecturerListView.mj_footer endRefreshing];
    }];
}
- (WYAEmptyDataView *)emptyView
{
    if (_emptyView == nil) {
        _emptyView = [[WYAEmptyDataView alloc]initWithFrame:CGRectMake(0,6.5*Size_ratio, ScreenWidth, ScreenHeight- WYATabBarHeight-WYATopHeight-43.5*Size_ratio)];
    }
    return _emptyView;
}
#pragma mark ====== creatUI
- (UITableView *)lecturerListView
{
    if(_lecturerListView == nil){
        _lecturerListView = [[UITableView alloc]initWithFrame:CGRectMake(0,6.5*Size_ratio, ScreenWidth, ScreenHeight- WYATabBarHeight-WYATopHeight-6.5*Size_ratio)];
        [_lecturerListView registerClass:[WYALecturerTableViewCell class] forCellReuseIdentifier:LECTURER_CELL_ID];
         _lecturerListView.showsVerticalScrollIndicator = NO;
        _lecturerListView.delegate = self;
        _lecturerListView.dataSource = self;
        [_lecturerListView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        _lecturerListView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _lecturerListView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];

    }
    return _lecturerListView;
}
- (NSMutableArray *)dataSources
{
    if(_dataSources == nil)
    {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}
#pragma mark ====== netRequest
- (WYALecturerNetRequest *)netRequest{
    if(_netRequest == nil){
        _netRequest = [[WYALecturerNetRequest alloc]init];
    }
    return _netRequest;
}
#pragma mark ====== UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYALecturerTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LECTURER_CELL_ID];
    if(cell == nil)
    {
        cell = [[WYALecturerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LECTURER_CELL_ID];
    }
    cell.cellModel = self.dataSources[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 117.f*Size_ratio;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WYALecturerModel * model = self.dataSources[indexPath.row];
    WYALecturerPersonalVC * lecturerPersonalVC = [[WYALecturerPersonalVC alloc]init];
    lecturerPersonalVC.hidesBottomBarWhenPushed = YES;
    lecturerPersonalVC.teacher_id = model.teacher_id;
    lecturerPersonalVC.teacher_name = model.teacher_name;
    [self.navigationController pushViewController:lecturerPersonalVC animated:YES];
}
@end
