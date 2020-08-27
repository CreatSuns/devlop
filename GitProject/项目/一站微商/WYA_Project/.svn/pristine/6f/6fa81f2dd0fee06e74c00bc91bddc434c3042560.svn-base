//
//  WYALecturerPersonalVC.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/10.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYALecturerPersonalVC.h"
#import "WYALecturerHeaderView.h"
#import "WYALecturerPageView.h"
#import "WYAArticleTableViewCell.h"
#import "WYACouresListCell.h"
#import "WYALecturerDetailsNetRequest.h"

#import "WYACouresListModel.h"
#import "WYACourseDetailVC.h"
#import "WYAArticleDetailsVC.h"
#import "WYAArticleListModel.h"


#define COURSE_CELLID @"COURSE_CELLID"
#define ARTICLE_CELLID @"ARTICLE_CELLID"

@interface WYALecturerPersonalVC ()<UITableViewDataSource,UITableViewDelegate,WYALecturerPageViewDelegate,WYALecturerHeaderDelegate>
//@property(nonatomic, assign) NSInteger page;
@property(nonatomic, strong) WYALecturerHeaderView * headerView;
@property(nonatomic, strong) UITableView * tableView;
@property(nonatomic, strong) WYALecturerPageView * pageView;
@property(nonatomic, strong) WYALecturerDetailsNetRequest * netRequest;
@property(nonatomic, strong) NSMutableArray * courseDataSources;
@property(nonatomic, strong) NSMutableArray * articleDataSources;
@property(nonatomic, strong) UISwipeGestureRecognizer * rightRecognizer;
@property(nonatomic, strong) UISwipeGestureRecognizer * leftRecognizer;
@property(nonatomic, assign) BOOL isPushShowNav;
@end
static NSInteger isleftItem;
static BOOL isShowOtherItem;
static NSInteger tempPage = 1;

@implementation WYALecturerPersonalVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.title = self.teacher_name;
    self.isPushShowNav = NO;

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.isPushShowNav = YES;

    self.tableView.contentOffset = CGPointMake(0, 211*Size_ratio);

    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _courseDataSources = [NSMutableArray array];
    _articleDataSources = [NSMutableArray array];
    self.tableView.contentOffset = CGPointMake(0, -WYAStatusBarHeight);
    isShowOtherItem = NO;
    isleftItem = 1;
    [self.view addSubview:self.tableView];
    
    [self responeHeaderViewData];
    [self refreshNewData];
    [self.tableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark ====== Create UI
- (WYALecturerHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[WYALecturerHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, Size_ratio*376.f)];
        _headerView.delegate = self;
    }
    return _headerView;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -WYAStatusBarHeight, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _tableView.tableHeaderView = self.headerView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, ScreenWidth - 145);
        _rightRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
        _leftRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
        [_rightRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [_leftRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
        [_tableView addGestureRecognizer:_rightRecognizer];
        [_tableView addGestureRecognizer:_leftRecognizer];
        [_tableView registerClass:[WYACouresListCell class] forCellReuseIdentifier:COURSE_CELLID];
        [_tableView registerClass:[WYAArticleTableViewCell class] forCellReuseIdentifier:ARTICLE_CELLID];
        [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _tableView;
}
- (WYALecturerPageView *)pageView
{
    if (_pageView == nil) {
        _pageView = [[WYALecturerPageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, Size_ratio*50.f)];
        _pageView.delegate = self;
    }
    return _pageView;
}
#pragma mark ====== netRequest
- (WYALecturerDetailsNetRequest *)netRequest
{
    if (_netRequest == nil) {
        _netRequest = [[WYALecturerDetailsNetRequest alloc]init];
    }
    return _netRequest;
}

- (void)responeHeaderViewData
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"teacher_id"] = self.teacher_id;
    [self.netRequest lecturerDetailsWithParams:dict Success:^(id data) {
        self.headerView.model = data;
        self.pageView.model = data;
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
#pragma mark ====== refresh
- (void)refreshNewData
{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        tempPage--;
        if (tempPage <= 1) {
            tempPage = 1;
        }
        [weakSelf featchData:tempPage];
        
    }];
    [self.tableView.mj_header beginRefreshing];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        tempPage++;
        [weakSelf featchData:tempPage];
        
        
    }];
}
- (void)featchData:(NSInteger)tempPage{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"page"] = @(tempPage);
    dic[@"teacher_id"] = self.teacher_id;
    if (isShowOtherItem) {
        [self.netRequest lecturerAllArticleWithParams:dic Success:^(id data) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if (tempPage == 1) {
                [self.articleDataSources removeAllObjects];
                self.articleDataSources = data;
                [self.tableView reloadData];
            }else if (data != nil)
            {
                NSArray * array = data;
                if (array&&array.count!=0) {
                    [self.articleDataSources addObjectsFromArray:data];
                    [self.tableView reloadData];
                    [self.tableView.mj_footer endRefreshing];
                    
                }else
                {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
    
        } Fail:^(NetRequestCode netCode, NSString *errorDes) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }];
    }else
    {
        [self.netRequest lecturerAllCourseWithParams:dic Success:^(id data) {
            WYACouresListModel * model = (WYACouresListModel *)data;
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if (tempPage == 1) {
                [self.courseDataSources removeAllObjects];
                self.courseDataSources = [model.list mutableCopy];
                [self.tableView reloadData];

            }else if (model.list != nil)
            {
                NSArray * array = model.list;
                if (array&&array.count!=0) {
                    [self.courseDataSources addObjectsFromArray:[model.list mutableCopy]];
                    [self.tableView reloadData];
                    [self.tableView.mj_footer endRefreshing];
                    
                }else
                {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
            
        } Fail:^(NetRequestCode netCode, NSString *errorDes) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }];
    }
}

#pragma mark ====== UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isShowOtherItem) {
        return self.articleDataSources.count;
    }else
    {
        return self.courseDataSources.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isShowOtherItem) {

        WYAArticleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ARTICLE_CELLID];
        if(cell == nil)
        {
            cell = [[WYAArticleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ARTICLE_CELLID];
        }
        if(self.articleDataSources.count!=0&&self.articleDataSources){
        cell.cellModel = self.articleDataSources[indexPath.row];
        }
        isleftItem = 0;
        return cell;
    }else
    {
        WYACouresListCell *cell = [tableView dequeueReusableCellWithIdentifier:COURSE_CELLID forIndexPath:indexPath];
        isleftItem = 1;
        // Configure the cell...
        if(self.courseDataSources.count!=0&&self.courseDataSources){
        cell.model = self.courseDataSources[indexPath.row];
        }
        cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        return cell;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (isShowOtherItem) {
        [self.pageView.leftButton setTitleColor:[UIColor WYAJHgrayTextColor] forState:UIControlStateNormal];
       self.pageView.leftLineLabel.backgroundColor = [UIColor whiteColor];
        
        [self.pageView.rightButton setTitleColor:[UIColor WYAJHBasePurpleColor] forState:UIControlStateNormal];
        self.pageView.rightLineLabel.backgroundColor = [UIColor WYAJHBasePurpleColor];
    }else
    {
        [self.pageView.rightButton setTitleColor:[UIColor WYAJHgrayTextColor] forState:UIControlStateNormal];
        self.pageView.rightLineLabel.backgroundColor = [UIColor whiteColor];
        
        [self.pageView.leftButton setTitleColor:[UIColor WYAJHBasePurpleColor] forState:UIControlStateNormal];
        self.pageView.leftLineLabel.backgroundColor = [UIColor WYAJHBasePurpleColor];
    }
    return self.pageView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50*Size_ratio;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return isShowOtherItem?93.f*Size_ratio:107.f*Size_ratio;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (isShowOtherItem) {
        self.isPushShowNav = YES;
        tableView.contentOffset = CGPointMake(0, 211*Size_ratio);
        WYAArticleListModel * model = self.articleDataSources[indexPath.row];
        WYAArticleDetailsVC * articleVc = [[WYAArticleDetailsVC alloc]init];
        articleVc.article_id = model.article_id;
        [self.navigationController pushViewController:articleVc animated:YES];
    }else{
        WYASearchCourseModel * model = self.courseDataSources[indexPath.row];
        WYACourseDetailVC * courseDetailVc = [[WYACourseDetailVC alloc]init];
        courseDetailVc.courseID = model.course_id;
        courseDetailVc.course_title = model.course_title;
        courseDetailVc.course_id = model.course_id;
        courseDetailVc.img_url = model.img_url;
        [self.navigationController pushViewController:courseDetailVc animated:YES];
    }
}
#pragma mark WYALecturerHeaderDelegate
- (void)attentionButtonClicked:(UIButton *)sender
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"teacher_id"] = self.teacher_id;
    [self.netRequest lecturerAttentionWithParams:dic Success:^(id data) {
        NSString * buttonTitle = sender.titleLabel.text;
        if ([buttonTitle isEqualToString:@"关注"]) {
            [sender setTitle:@"已关注" forState:UIControlStateNormal];
            [WYAShowMessageView showToastBWithMessage:@"已关注"];

        } if ([buttonTitle isEqualToString:@"已关注"]) {
            [sender setTitle:@"关注" forState:UIControlStateNormal];
            [WYAShowMessageView showToastBWithMessage:@"已取消"];

        }
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
#pragma mark WYALecturerPageViewDelegate
- (void)courseButtonClickedEvent:(UIButton *)sender
{
    //加载课程
    isShowOtherItem = NO;
    [self featchData:1];
}
- (void)articleButtonClickedEvent:(UIButton *)sender
{
    //加载文章
    isShowOtherItem = YES;
    [self featchData:1];
}
#pragma mark ===== 监听tableView滑动
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"])
    {
        CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
        if (self.isPushShowNav) {
            self.navigationController.navigationBar.hidden = NO;
        }else
        {
        if (offset.y >210.f*Size_ratio) {
              self.navigationController.navigationBar.hidden = NO;
            self.tableView.frame = CGRectMake(0,44, ScreenWidth, ScreenHeight-WYATopHeight);
        }else
        {
            self.navigationController.navigationBar.hidden = YES;
            self.tableView.frame = CGRectMake(0, -(RectStatus.size.height), ScreenWidth, ScreenHeight);
        }
        }
    }
    
}
- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    if(recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        isShowOtherItem = YES;
        [self featchData:1];
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        isShowOtherItem = NO;
        [self featchData:1];
    }
}
- (void)dealloc
{
    [self.tableView removeObserver:self forKeyPath:@"contentOffset" context:nil];
}
@end
