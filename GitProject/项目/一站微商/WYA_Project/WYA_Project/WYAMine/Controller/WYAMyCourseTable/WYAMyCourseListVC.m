//
//  WYAMyCourseListVC.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/9.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMyCourseListVC.h"
#import "WYAMyCourseListNetRequest.h"
#import "WYAMyCourseListModel.h"
#import "WYAMyCourseTableCell.h"
#import "WYAMyCouresTableNoDataView.h"
#import "WYACourseDetailVC.h"
static NSString * Cell = @"WYAMyCourseTableCell";

@interface WYAMyCourseListVC ()

@property (nonatomic, strong) WYAMyCourseListNetRequest * netRequest;

@property (nonatomic, strong) WYAMyCouresTableNoDataView * noDataView;

@property (nonatomic, strong) NSMutableArray * dataSource;

@property (nonatomic, assign) NSInteger page;
@end

@implementation WYAMyCourseListVC

- (WYAMyCourseListNetRequest *)netRequest{
    if (!_netRequest) {
        _netRequest = [[WYAMyCourseListNetRequest alloc]init];
    }
    return _netRequest;
}

-(WYAMyCouresTableNoDataView *)noDataView{
    if (!_noDataView) {
        _noDataView = [[WYAMyCouresTableNoDataView alloc]init];
    }
    return _noDataView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"我的课表";
    [self.tableView registerClass:[WYAMyCourseTableCell class] forCellReuseIdentifier:Cell];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    
    [self.tableView.mj_header beginRefreshing];
    // 设置自动切换透明度
    //    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)headRefresh{
    self.page = 1;
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"page"] = [NSString stringWithFormat:@"%ld",(long)self.page];
    [self.netRequest loadMyCoureseListWithParams:dict Success:^(id data) {
        [self.tableView.mj_header endRefreshing];
        WYAMyCourseListModel * model = (WYAMyCourseListModel *)data;
        self.dataSource = [model.list mutableCopy];
        self.replacePlaceholdView = self.noDataView;
        
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView cyl_reloadData];
        
    }];
}

- (void)footRefresh{
    self.page ++;
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"page"] = [NSString stringWithFormat:@"%ld",(long)self.page];
    [self.netRequest loadMyCoureseListWithParams:dict Success:^(id data) {
        [self.tableView.mj_footer endRefreshing];
        WYAMyCourseListModel * model = (WYAMyCourseListModel *)data;
        [self.dataSource addObjectsFromArray:model.list];
        [self.tableView cyl_reloadData];
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        [self.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WYAMyCourseTableCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell forIndexPath:indexPath];
    
    cell.model = self.dataSource[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 107.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MyCourseList * list = self.dataSource[indexPath.row];
    WYACourseDetailVC * detail = [[WYACourseDetailVC alloc]init];
    detail.courseID = list.course_id;
    detail.course_id = list.course_id;
    detail.img_url = list.img_url;
    detail.course_title = list.title;
    detail.onlyShowDownloadFinish = YES;
    detail.titleColorSelected= [UIColor WYAJHBasePurpleColor];
    detail.titleColorNormal = [UIColor WYAJHBlackTextColor];
    detail.menuHeight = 40.f;
    detail.menuViewStyle = WMMenuViewStyleLine;
    detail.progressColor = [UIColor WYAJHBasePurpleColor];
    detail.automaticallyCalculatesItemWidths = YES;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
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
