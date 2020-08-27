//
//  WYASettingTableVC.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/9.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYASettingTableVC.h"
#import "WYASettingViewModel.h"
#import "WYASettingCellModel.h"

#import "WYALoginVC.h"
#import "SODownloader+WYAVideoDownload.h"
@interface WYASettingTableVC ()

@property (nonatomic, strong) NSArray * dataSource;

@property (nonatomic, strong) UIButton * exitButton;

@property (nonatomic, strong) UILabel * clearCacheLabel;

@property (nonatomic, strong) UIButton * versionButton;
@end

@implementation WYASettingTableVC

-(NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [WYASettingViewModel settingCellModels];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"设置";
    
//    self.tableView.tableFooterView = self.exitButton;
    self.tableView.backgroundColor = [UIColor WYAJHLightGreyColor];
    UIView * buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 54*Size_ratio)];
    [buttonView setBackgroundColor:[UIColor WYAJHLightGreyColor]];
    [buttonView addSubview:self.exitButton];
    [self.tableView setTableFooterView:buttonView];
    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"system"];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"system" forIndexPath:indexPath];
    
    WYASettingCellModel * model = self.dataSource[indexPath.row];
    cell.textLabel.text = model.title;
    cell.textLabel.font = [UIFont systemFontOfSize:14*Size_ratio];
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        UISwitch * sw = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        sw.tag = indexPath.row;
        sw.onTintColor = [UIColor WYAJHBasePurpleColor];
        cell.accessoryView = sw;
        [sw addTarget:self action:@selector(valueChangeClick:) forControlEvents:UIControlEventValueChanged];
        
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        if (indexPath.row == 0) {
            if ([userDefaults boolForKey:AllowDataConnectionAndPlay]) {
                [sw setOn:YES];
            }else{
                [sw setOn:NO];
            }
        }else{
            if ([userDefaults boolForKey:AllowDataConnectionAndDownload]) {
                [sw setOn:YES];
            }else{
                [sw setOn:NO];
            }
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if (indexPath.row == 2) {
        cell.accessoryView = self.clearCacheLabel;
    }else{
        cell.accessoryView = self.versionButton;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10*Size_ratio;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10*Size_ratio)];
    view.backgroundColor = [UIColor WYAJHBackGroundColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"确定清除缓存?"
                                                                                  message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确定"
                                                              style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                                                                  [[SDImageCache sharedImageCache] clearDisk];
                                                                  self.clearCacheLabel.text = @"0M";
                                                                  [WYAShowMessageView showToastAWithMessage:@"清除缓存成功"];
                                                              }];
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                                style:UIAlertActionStyleCancel
                                                              handler:nil];
        [alertController addAction:sureAction];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

-(UIButton *)exitButton{
    if (!_exitButton) {
        _exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _exitButton.frame = CGRectMake(0, 10*Size_ratio, ScreenWidth, 44);
        [_exitButton setBackgroundColor:[UIColor whiteColor]];
        [_exitButton setTitleColor:[UIColor WYAJHBlackTextColor] forState:UIControlStateNormal];
        [_exitButton setTitle:@"退出当前账号" forState:UIControlStateNormal];
        _exitButton.titleLabel.font = [UIFont systemFontOfSize:14*Size_ratio];
        [_exitButton addTarget:self action:@selector(exitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitButton;
}

#warning 缓存计算并显示 Memory cache
-(UILabel *)clearCacheLabel{
    if (!_clearCacheLabel) {
        _clearCacheLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100*Size_ratio, 30*Size_ratio)];
        _clearCacheLabel.textColor = [UIColor WYAJHSettingGrayTextColor];
        _clearCacheLabel.font = [UIFont systemFontOfSize:12*Size_ratio];
        _clearCacheLabel.textAlignment = NSTextAlignmentRight;
        NSUInteger size = [SDImageCache sharedImageCache].getSize;
        double displaySize = size/ 1000.0 /1000.0;
        _clearCacheLabel.text = [NSString stringWithFormat:@"%.2fM",displaySize];
    }
    return _clearCacheLabel;
}

-(UIButton *)versionButton{
    if (!_versionButton) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        _versionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _versionButton.frame = CGRectMake(0, 0, 50*Size_ratio, 30*Size_ratio);
        [_versionButton setTitle:[NSString stringWithFormat:@"V%@",app_Version] forState:UIControlStateNormal];
        [_versionButton setTitleColor:[UIColor WYAJHSettingGrayTextColor] forState:UIControlStateNormal];
        _versionButton.titleLabel.font = [UIFont systemFontOfSize:12*Size_ratio];
        _versionButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_versionButton setImage:[UIImage imageNamed:@"Right arrow"] forState:UIControlStateNormal];
        _versionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _versionButton.titleEdgeInsets = UIEdgeInsetsMake(0, -_versionButton.imageView.image.size.width, 0, _versionButton.imageView.image.size.width);
        _versionButton.imageEdgeInsets = UIEdgeInsetsMake(0, _versionButton.titleLabel.width , 0, -_versionButton.titleLabel.width);
    }
    return _versionButton;
}

- (void)exitClick{
    NSLog(@"11");
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"确定退出登录?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确定"
                                                          style:UIAlertActionStyleDestructive
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"access_token"];
//                                                            [[SODownloader videoDownloader]pauseAll];

                                                            JQFMDB * fmdb = [JQFMDB shareDatabase:FileDownload_DataBase path:[NSString downloadFilePath]];
                                                            fmdb = nil;
                                                            WYALoginVC * login = [[WYALoginVC alloc]init];
                                                            Window.rootViewController = login;
                                                        }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                            style:UIAlertActionStyleCancel
                                                          handler:nil];
    [alertController addAction:sureAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)valueChangeClick:(UISwitch *)sw{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    if (sw.tag == 0) {
        if (sw.on) {
            //打开
            [userDefaults setBool:YES forKey:AllowDataConnectionAndPlay];
        }else{
            //关闭
            [userDefaults setBool:NO forKey:AllowDataConnectionAndPlay];
        }
    }else{
        if (sw.on) {
            //打开
            [userDefaults setBool:YES forKey:AllowDataConnectionAndDownload];
        }else{
            //关闭
            [userDefaults setBool:NO forKey:AllowDataConnectionAndDownload];
        }
    }
    [userDefaults synchronize];
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
