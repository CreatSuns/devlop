//
//  WYAMineInfoVC.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/20.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMineInfoVC.h"
#import "WYAMineInfoNetRequest.h"
#import "WYAMineInfoCell.h"
#import "WYANickNameVC.h"
#import "WYAChangerPasswordVC.h"
#import "WYALoginVC.h"
static NSString * customCell = @"CustomCell";

@interface WYAMineInfoVC ()

@property (nonatomic, strong) WYAMineInfoNetRequest * netRequest;

@property (nonatomic, strong) NSArray * dataSource;

@end

@implementation WYAMineInfoVC

- (WYAMineInfoNetRequest *)netRequest{
    if (!_netRequest) {
        _netRequest = [[WYAMineInfoNetRequest alloc] init];
    }
    return _netRequest;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"个人资料";
    UIView * buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 54)];
    [buttonView setBackgroundColor:[UIColor WYAJHLightGreyColor]];
    
//    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setBackgroundColor:[UIColor whiteColor]];
//    [button setTitle:@"退出当前账号" forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:14];
//    [button setTitleColor:[UIColor WYAJHBlackTextColor] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(exitAccountAction) forControlEvents:UIControlEventTouchUpInside];
//    button.frame = CGRectMake(0, 10, ScreenWidth, 44);
//    [buttonView addSubview:button];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.backgroundColor = [UIColor WYAJHLightGreyColor];
    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[WYAMineInfoCell class] forCellReuseIdentifier:customCell];
    self.dataSource = [self.netRequest loadMineInfoWithAdminInfo:self.model];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return section == 0 ? 1 : 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WYAMineInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:customCell forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.section][indexPath.row];
    if (indexPath.section == 1) {
        BOOL isHidden = indexPath.row == 2? NO:YES;
        cell.rightArrowImageView.hidden = isHidden;
    }
    return cell;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5.f*Size_ratio)];
    view.backgroundColor = [UIColor WYAJHLightGreyColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WYAMineInfoCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        WeakSelf(weakSelf);
        [self showCanEdit:YES photo:^(UIImage *photo) {
            cell.imgView.image = photo;
            [weakSelf.netRequest uploadHeadImage:photo Success:^(id data) {

            } Fail:^(NetRequestCode netCode, NSString *errorDes) {

            }];
        }];
    }else{
        if (indexPath.row == 1) {
//            WYANickNameVC * nickName = [[WYANickNameVC alloc]init];
//            [self.navigationController pushViewController:nickName animated:YES];
        }else if (indexPath.row == 2) {
            WYAChangerPasswordVC * vc = [[WYAChangerPasswordVC alloc]init];
            vc.userName = self.model.user_name;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

//- (void)exitAccountAction{
//    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定退出登录？" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        WYALoginVC * login = [[WYALoginVC alloc]init];
//        Window.rootViewController = login;
//    }];
//    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    [alert addAction:sureAction];
//    [alert addAction:cancelAction];
//    [self presentViewController:alert animated:YES completion:nil];
//}

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
