//
//  WYACourseDownloadTableVC.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/14.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYACourseDownloadTableVC.h"

#import "WYACourseDownloadNetRequest.h"
#import "WYACourseDownloadCell.h"
#import "WYACourseDownloadModel.h"

#import "WYAQuickLookFileVC.h"


static NSString * DownloadCell = @"downloadCell";

@interface WYACourseDownloadTableVC ()

@property (nonatomic, strong) NSMutableArray * dataSource;

@property (nonatomic, strong) WYACourseDownloadNetRequest * netRequest;

@end

@implementation WYACourseDownloadTableVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.tableView registerClass:[WYACourseDownloadCell class] forCellReuseIdentifier:DownloadCell];
    [self loadCourseDownloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- Lazy
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

- (WYACourseDownloadNetRequest *)netRequest{
    if (!_netRequest) {
        _netRequest = [[WYACourseDownloadNetRequest alloc]init];
    }
    return _netRequest;
}

#pragma mark --- Private method
- (void)loadCourseDownloadData{
    
    NSMutableDictionary * params = [NSMutableDictionary new];
    [params setValue:[NSNumber numberWithInteger:self.model.course_id] forKey:@"course_id"];
    
    [self.netRequest loadCourseDownloadWithParams:params Success:^(id data) {
        self.dataSource = (NSMutableArray *)data;
        [self.tableView reloadData];
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        [WYAShowMessageView showToastAWithMessage:@"请检查您的网络连接，或稍后再试"];
    }];
}

#pragma mark --- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WYACourseDownloadCell *cell = [tableView dequeueReusableCellWithIdentifier:DownloadCell forIndexPath:indexPath];
    cell.name = self.course_name;
    cell.model = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark --- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WYACourseDownloadCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    AFNetworkReachabilityManager * manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown) {
            
        }else if (status == AFNetworkReachabilityStatusNotReachable) {
            [WYAShowMessageView showToastAWithMessage:@"暂无网络连接，请稍后再试"];
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
            NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
            
            if ([ud boolForKey:AllowDataConnectionAndPlay]) {
                [self downloadAndPush:cell Model:cell.model];
            }else{
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"你在当前在3G/4G网络下，下载或观看视频会消耗较多流量，系统已自动暂停，你可在设置界面开启。" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * knowAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:knowAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }else if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
            [self downloadAndPush:cell Model:cell.model];
        }
    }];
    // 开始监控
    [manager startMonitoring];

}

- (void)downloadAndPush:(WYACourseDownloadCell *)cell Model:(WYACourseDownloadModel *)model{
    if (model.flag == NO) {
        
        //下载文件
        NSURLSessionDownloadTask * task = [self.netRequest downLoadCourseFileWithUrl:model.courseware_url
                                                                              Params:[@{@"course_id":[NSNumber numberWithInteger:self.model.course_id],@"iid":[NSNumber numberWithInteger:[model.chapter_id integerValue]]} mutableCopy] FileName:model.courseware_title progress:^(float progress) {
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.downloadIcon.image = [UIImage imageNamed:@"download"];
            });
            
        } Success:^(id data) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // UI更新代码
                cell.downloadIcon.image = [UIImage imageNamed:@"完成"];
                model.flag = YES;
                
            });
            [self.netRequest storageFileWithModel:model TableName:self.course_name CourseID:self.courseID];
        } Fail:^(NetRequestCode netCode, NSString *errorDes) {
            [WYAShowMessageView showToastAWithMessage:@"请检查您的网络连接或稍后再试"];
        }];
        if (cell.isturn == NO) {
            //开始
            [task resume];
            cell.isturn = YES;
        }else{
            //暂停
            [task suspend];
            cell.isturn = NO;
        }
    }else{
        
        NSString * fileUrl = [[NSString downloadVideoPath] stringByAppendingPathComponent:model.courseware_title];
        WYAQuickLookFileVC * quicklook = [[WYAQuickLookFileVC alloc]init];
        quicklook.fileURL = [NSURL fileURLWithPath:fileUrl];
        
        [self presentViewController:quicklook animated:YES completion:nil];
    }
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
