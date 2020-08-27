//
//  WYASearchArticleViewController.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/25.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYASearchArticleViewController.h"
#import "WYAArticleTableViewCell.h"
#import "WYAArticleDetailsVC.h"
#import "WYAArticleListModel.h"
#import "WYAArticleNetRequest.h"

#define Article_CELL @"ArticleTableViewCell"

@interface WYASearchArticleViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView * searchArticleTabView;
@property(nonatomic, strong) WYAArticleNetRequest *netRequest;
@property(nonatomic, strong) WYAEmptyDataView * emptyView;

@end
static NSInteger tempPage = 1;

@implementation WYASearchArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _articleDataSources = [NSMutableArray array];
    [self.view addSubview:self.searchArticleTabView];
    [self refreshNewData];
    [self.searchArticleTabView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark ====== netRequest
- (WYAArticleNetRequest *)netRequest{
    if(_netRequest == nil){
        _netRequest = [[WYAArticleNetRequest alloc]init];
    }
    return _netRequest;
}
#pragma mark ====== refresh
- (void)refreshNewData
{
    __weak typeof(self) weakSelf = self;
    self.searchArticleTabView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        tempPage--;
        if (tempPage <= 1) {
            tempPage = 1;
        }
        [weakSelf featchData:tempPage];
        
    }];
    [self.searchArticleTabView.mj_header beginRefreshing];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.searchArticleTabView.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    self.searchArticleTabView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        tempPage++;
        [weakSelf featchData:tempPage];
        
        
    }];
}
- (void)featchData:(NSInteger)tempPage{
    if (self.searchText!=nil) {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        dic[@"page"] = @(tempPage);
        dic[@"search"] = self.searchText;
        [self.netRequest loadArticlListWithParams:dic Success:^(id data) {
            // 请求成功结束刷新
            [self.searchArticleTabView.mj_header endRefreshing];
            [self.searchArticleTabView.mj_footer endRefreshing];
            if (tempPage == 1) {
                [self.articleDataSources removeAllObjects];
                self.articleDataSources = data;
            }else if (data != nil)
            {
                [self.articleDataSources addObjectsFromArray:data];
            }
            if(self.articleDataSources &&self.articleDataSources.count!=0){
                [self.emptyView removeFromSuperview];
                [self.searchArticleTabView reloadData];
            }else
            {
                
                [self.searchArticleTabView addSubview:self.emptyView];
            }
        } Fail:^(NetRequestCode netCode, NSString *errorDes) {
            [self.searchArticleTabView.mj_header endRefreshing];
            [self.searchArticleTabView.mj_footer endRefreshing];
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
- (UITableView *)searchArticleTabView
{
    if (_searchArticleTabView == nil) {
        _searchArticleTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-WYANavBarHeight-WYAStatusBarHeight-WYATabBarHeight) style:UITableViewStylePlain];
        [_searchArticleTabView registerClass:[WYAArticleTableViewCell class] forCellReuseIdentifier:Article_CELL];
        _searchArticleTabView.dataSource = self;
        _searchArticleTabView.delegate = self;
        _searchArticleTabView.showsVerticalScrollIndicator = NO;
        [_searchArticleTabView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        _searchArticleTabView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _searchArticleTabView;
}
#pragma mark tableDelegate
#pragma mark ====== UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return self.articleDataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        WYAArticleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Article_CELL];
        if (cell == nil) {
            cell = [[WYAArticleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Article_CELL];
        }
        cell.cellModel = self.articleDataSources[indexPath.row];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
}
// cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 93*Size_ratio;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    //    cell点击事件文章详情
    WYAArticleListModel * model = self.articleDataSources[indexPath.row];
    WYAArticleDetailsVC * articleVc = [[WYAArticleDetailsVC alloc]init];
    articleVc.article_id = model.article_id;
    [self.navigationController pushViewController:articleVc animated:YES];
}
@end
