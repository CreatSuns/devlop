//
//  WYAMineDownloadVC.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/20.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMineDownloadVC.h"
#import "WYAMineDownloadView.h"
#import "WYAMineDownloadNetRequest.h"
#import "WYAMineDownloadModel.h"
#import "WYANowDowmloadVC.h"
#import "WYAFinishDownloadVC.h"
#import "SODownloader+WYAVideoDownload.h"

static void * kDownloaderKVOContext = &kDownloaderKVOContext;

@interface WYAMineDownloadVC ()

@property (nonatomic, strong) WYAMineDownloadView * downloadView;

@property (nonatomic, strong) WYAMineDownloadNetRequest * netRequest;

@property (nonatomic, strong) SODownloader * downloader;

@end

@implementation WYAMineDownloadVC

- (WYAMineDownloadNetRequest *)netRequest{
    if (!_netRequest) {
        _netRequest = [[WYAMineDownloadNetRequest alloc]init];
    }
    return _netRequest;
}

- (SODownloader *)downloader{
    if (!_downloader) {
        _downloader = [SODownloader videoDownloader];
    }
    return _downloader;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self loadMineDownloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的下载";
    self.downloadView = [[WYAMineDownloadView alloc]init];
    [self.view addSubview:self.downloadView];
    [self.downloadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    self.downloadView.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    WeakSelf(weakSelf);
    self.downloadView.selectRow = ^(NSIndexPath *indexPath, NSString * title, NSString * courseID) {
        if (indexPath.section == 0) {
            //正在下载页面
            WYANowDowmloadVC * vc = [[WYANowDowmloadVC alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else{
            //已完成下载页面
            WYAFinishDownloadVC * vc = [[WYAFinishDownloadVC alloc]init];
            vc.courseTitle = title;
            vc.courseID = courseID;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    };
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    [self.downloader addObserver:self forKeyPath:SODownloaderCompleteArrayObserveKeyPath options:NSKeyValueObservingOptionNew context:kDownloaderKVOContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)headRefresh{
    [self loadMineDownloadData];
    [self.downloadView.table.mj_header endRefreshing];
}

- (void)loadMineDownloadData{
    if ([NSThread isMainThread]) {
        NSArray * array = [self.netRequest getFinishDownloadFileArray];
        
        self.downloadView.finishDownloadArray = array;
        
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSArray * array = [self.netRequest getFinishDownloadFileArray];
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.downloadView.finishDownloadArray = array;
            
        });
    });
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (context == kDownloaderKVOContext) {
        [WYAJHTools fileSizeWithFilePath:[NSString downloadVideoPath]];

        [self loadMineDownloadData];
    }
}

-(void)dealloc{
    [self.downloader removeObserver:self forKeyPath:SODownloaderCompleteArrayObserveKeyPath];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
