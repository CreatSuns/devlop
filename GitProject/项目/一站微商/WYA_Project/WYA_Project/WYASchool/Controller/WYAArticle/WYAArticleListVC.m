//
//  WYAArticleListVC.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/9.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAArticleListVC.h"
#import "WYAArticleListModel.h"
#import "WYAArticleNetRequest.h"
#import "WYAArticleTableViewCell.h"
#import "WYAArticleDetailsVC.h"
#define ARTICLE_CELL_ID @"WRTICLE_CELL_ID"
@interface WYAArticleListVC()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) WYAArticleNetRequest *netRequest;
@property(nonatomic, strong) NSMutableArray *dataSources;
@property(nonatomic, strong) UITableView *articleListView;
@property(nonatomic, strong) WYAEmptyDataView * emptyView;
@property(nonatomic, assign) NSInteger page;

@end
//static NSInteger tempPage = 1;

@implementation WYAArticleListVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.articleListView.mj_header beginRefreshing];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.articleListView];
    self.articleListView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    
    
    self.articleListView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark ====== refresh
- (void)headRefresh{
    if (self.articleCategoryId!=nil) {
        self.page = 1;
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        dic[@"page"] = @(1);
        dic[@"category_id"] = self.articleCategoryId;
        [self.netRequest loadArticlListWithParams:dic Success:^(id data) {
            self.dataSources = data;
            [self.articleListView.mj_header endRefreshing];
            [self.articleListView reloadData];
        } Fail:^(NetRequestCode netCode, NSString *errorDes) {
            [self.articleListView.mj_header endRefreshing];
            [self.articleListView reloadData];
            
        }];
    }
}

- (void)footRefresh{
    
    self.page ++;
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:0];
    [dic setObject:[NSNumber numberWithInteger:self.page] forKey:@"page"];
    dic[@"category_id"] = self.articleCategoryId;
    [self.netRequest loadArticlListWithParams:dic Success:^(id data) {
        NSArray * array = data;
        if (array&&array.count!=0) {
            [self.dataSources addObjectsFromArray:data];
            [self.articleListView reloadData];
            [self.articleListView.mj_footer endRefreshing];

        }else
        {
            [self.articleListView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        [self.articleListView.mj_footer endRefreshing];
        [self.articleListView reloadData];
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
- (UITableView *)articleListView
{
    if(_articleListView == nil){
        _articleListView = [[UITableView alloc]initWithFrame:CGRectMake(0,6.5*Size_ratio, ScreenWidth, ScreenHeight- WYATabBarHeight-WYATopHeight)];
        [_articleListView registerClass:[WYAArticleTableViewCell class] forCellReuseIdentifier:ARTICLE_CELL_ID];
        _articleListView.showsVerticalScrollIndicator = NO;
        _articleListView.delegate = self;
        _articleListView.dataSource = self;
  
        [_articleListView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        _articleListView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _articleListView;
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
- (WYAArticleNetRequest *)netRequest{
    if(_netRequest == nil){
        _netRequest = [[WYAArticleNetRequest alloc]init];
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
   
    WYAArticleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ARTICLE_CELL_ID];
    if(cell == nil)
    {
        cell = [[WYAArticleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ARTICLE_CELL_ID];
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataSources&&self.dataSources.count!=0&&indexPath.row<self.dataSources.count){
        
    cell.cellModel = self.dataSources[indexPath.row];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 93.f*Size_ratio;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WYAArticleListModel * model = self.dataSources[indexPath.row];
    WYAArticleDetailsVC * detailsVC = [[WYAArticleDetailsVC alloc]init];
    detailsVC.hidesBottomBarWhenPushed = YES;
    detailsVC.article_id = model.article_id;
    [self.navigationController pushViewController:detailsVC animated:NO];
    

}
@end
