//
//  WYANowDowmloadVC.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/25.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYANowDowmloadVC.h"
#import "WYANowDownloadView.h"
#import "WYANowDownloadManager.h"
#import "SODownloader+WYAVideoDownload.h"

@interface WYANowDowmloadVC ()

@property (nonatomic, strong) WYANowDownloadView * nowDownloadView;

@property (nonatomic, strong) WYANowDownloadManager * manager;

@end

@implementation WYANowDowmloadVC

- (WYANowDownloadView *)nowDownloadView{
    if (!_nowDownloadView) {
        _nowDownloadView = [[WYANowDownloadView alloc]init];
    }
    return _nowDownloadView;
}

- (WYANowDownloadManager *)manager{
    if (!_manager) {
        _manager = [[WYANowDownloadManager alloc]init];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"正在下载";
    [self addNavRightButtonWithTitle:@"管理" TitleColor:[UIColor WYAJHBaseBlueColor]];
    
    [self.view addSubview:self.nowDownloadView];
    [self.nowDownloadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    WeakSelf(weakSelf);
    self.nowDownloadView.deleteAction = ^(NSMutableArray *array) {
        [[SODownloader videoDownloader] cancelItems:array];
        
    };
    
    NSArray * array = [self.manager getDownloadingArray];
    self.nowDownloadView.datas = array;
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.nowDownloadView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)rightBarButtonItemClicked:(UIButton *)sender{
    if ([sender.titleLabel.text isEqualToString:@"管理"]) {
        self.nowDownloadView.canEdit = YES;
        [sender setTitle:@"完成" forState:UIControlStateNormal];
    }else if ([sender.titleLabel.text isEqualToString:@"完成"]) {
        self.nowDownloadView.canEdit = NO;
        [sender setTitle:@"管理" forState:UIControlStateNormal];
    }
    
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
