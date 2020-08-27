//
//  WYACouresListTableVC.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/8.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYACouresListTableVC.h"
#import "WYACouresNetRequest.h"
#import "WYACouresListModel.h"
#import "WYACouresListCell.h"
#import "WYACourseDetailVC.h"
#import "WYAMyCouresTableNoDataView.h"

@interface WYACouresListTableVC ()

@property (nonatomic, strong) WYACouresNetRequest * netRequest;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray * dataSource;

@property (nonatomic, strong) WYAMyCouresTableNoDataView * noDataView;

@end

@implementation WYACouresListTableVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.dataSource) {
        [self.dataSource removeAllObjects];
    }
    
    [self.tableView.mj_header beginRefreshing];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.tableView registerClass:[WYACouresListCell class] forCellReuseIdentifier:@"coures"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- Lazy
-(WYACouresNetRequest *)netRequest{
    if (!_netRequest) {
        _netRequest = [[WYACouresNetRequest alloc]init];
    }
    return _netRequest;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

-(WYAMyCouresTableNoDataView *)noDataView{
    if (!_noDataView) {
        _noDataView = [[WYAMyCouresTableNoDataView alloc]init];
        _noDataView.errorMessageLabel.text = @"暂时没有您想要的内容";
    }
    return _noDataView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WYACouresListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"coures" forIndexPath:indexPath];
    if (self.dataSource&&self.dataSource.count!=0&&indexPath.row<self.dataSource.count){
        cell.model = self.dataSource[indexPath.row];
        }
    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    return cell;
}

#pragma mark --- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 107.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    List * list = (List *)self.dataSource[indexPath.row];
    WYACourseDetailVC * detail = [[WYACourseDetailVC alloc]init];
    detail.courseID = list.course_id;
    detail.course_title = list.course_title;
    detail.course_id = list.course_id;
    detail.img_url = list.img_url;

    detail.titleColorSelected= [UIColor WYAJHBasePurpleColor];
    detail.titleColorNormal = [UIColor WYAJHBlackTextColor];
    detail.menuHeight = 40.f;
    detail.menuViewStyle = WMMenuViewStyleLine;
    detail.progressColor = [UIColor WYAJHBasePurpleColor];
    detail.titleSizeSelected = 15;
    detail.titleSizeNormal = 13;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
   
}

#pragma mark ---下拉刷新
- (void)headRefresh{
    self.page = 1;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:0];
    [dic setObject:[NSNumber numberWithInteger:self.page] forKey:@"page"];
    
    if (self.category_id) {
        [dic setObject:self.category_id forKey:@"category_id"];
    }
    
    [self.netRequest loadCouresListWithParams:dic Success:^(id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        WYACouresListModel * model = (WYACouresListModel *)data;
        [self.dataSource removeAllObjects];
        self.dataSource = [model.list mutableCopy];
        [self.tableView.mj_header endRefreshing];
        self.replacePlaceholdView = self.noDataView;
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView.mj_header endRefreshing];
        [self.tableView cyl_reloadData];
    }];
}

#pragma mark ---上拉加载
- (void)footRefresh{
    self.page ++;
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:0];
    [dic setObject:[NSNumber numberWithInteger:self.page] forKey:@"page"];
    
    if (self.category_id) {
        [dic setObject:self.category_id forKey:@"category_id"];
    }
    
    [self.netRequest loadCouresListWithParams:dic Success:^(id data) {
        WYACouresListModel * model = (WYACouresListModel *)data;
        if (model.totalPage == model.currentPage) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        [self.dataSource addObjectsFromArray:model.list];
        [self.tableView cyl_reloadData];
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView cyl_reloadData];
    }];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
