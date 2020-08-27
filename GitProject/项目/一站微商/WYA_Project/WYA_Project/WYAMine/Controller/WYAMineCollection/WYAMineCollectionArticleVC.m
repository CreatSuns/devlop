//
//  WYAMineCollectionArticleVC.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/17.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMineCollectionArticleVC.h"
#import "WYAMineCollectionNetRequest.h"
#import "WYAMineCollectionArticleModel.h"
#import "WYAMineCollectionCell.h"
#import <UIKit/NSIndexPath+UIKitAdditions.h>
#import "WYAMyCouresTableNoDataView.h"
#import "WYAArticleDetailsVC.h"
static NSString * WYAMineCollection = @"WYAMineCollection";

@interface WYAMineCollectionArticleVC ()

@property (nonatomic, strong) WYAMineCollectionNetRequest * netRequest;
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, strong) WYAMyCouresTableNoDataView * noDataView;

@end

@implementation WYAMineCollectionArticleVC

- (WYAMineCollectionNetRequest *)netRequest{
    if (!_netRequest) {
        _netRequest = [[WYAMineCollectionNetRequest alloc]init];
    }
    return _netRequest;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

- (WYAMyCouresTableNoDataView *)noDataView{
    if (!_noDataView) {
        _noDataView = [[WYAMyCouresTableNoDataView alloc]init];
        _noDataView.errorMessageLabel.text = @"亲！暂时没有收藏的文章哦~";
    }
    return _noDataView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.tableView registerClass:[WYAMineCollectionCell class] forCellReuseIdentifier:WYAMineCollection];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    [self.tableView.mj_header beginRefreshing];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)headRefresh{
    [self loadMineColectionArticleData];
}

- (void)loadMineColectionArticleData{
    [self.dataSource removeAllObjects];
    NSMutableDictionary * params = [NSMutableDictionary new];
    [self.netRequest loadMineCollectionArticleWithParams:params Success:^(id data) {
        [self.tableView.mj_header endRefreshing];
        WYAMineCollectionArticleModel * model = (WYAMineCollectionArticleModel *)data;
        self.dataSource = [model.list mutableCopy];
        [self.tableView reloadData];
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        [self.tableView.mj_header endRefreshing];
    }];
}


- (void)alertWithCollectionID:(NSString *)collectionID Row:(NSInteger)row{

    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"确认取消对该文章的收藏吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteActionWithCollection:collectionID Row:row];
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:sureAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)deleteActionWithCollection:(NSString *)collectionID Row:(NSInteger)row{
    NSMutableDictionary * params = [NSMutableDictionary new];
    [params setObject:collectionID forKey:@"collection_id"];
    [params setValue:[NSNumber numberWithInteger:2] forKey:@"type"];
    //    [params setValue:[NSNumber numberWithInteger:<#(NSInteger)#>] forKey:<#(nonnull NSString *)#>]
    
    [self.netRequest deleteMineCollectionWithParams:params Success:^(id data) {
        [self.dataSource removeObjectAtIndex:row];
        dispatch_async(dispatch_get_main_queue(), ^{
            // UI更新代码
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:row inSection:0];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView reloadData];
        });
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
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
    WYAMineCollectionCell * cell = [tableView dequeueReusableCellWithIdentifier:WYAMineCollection forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    WeakSelf(weakSelf);
    cell.deleteButtonClick = ^(NSString *collectionID) {
        [weakSelf alertWithCollectionID:collectionID Row:indexPath.row];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.hidesBottomBarWhenPushed = YES;
    WYAMineCollectionArticleListModel * model = self.dataSource[indexPath.row];
    
    if ([model.status isEqualToString:@"0"]) {
        [WYAShowMessageView showToastAWithMessage:@"您收藏的文章已下架"];
        return;
    }
    
    WYAArticleDetailsVC * detail = [[WYAArticleDetailsVC alloc]init];
    detail.article_id = model.article_id;
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
