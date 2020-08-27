//
//  WYAFinishDownloadVC.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/27.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAFinishDownloadVC.h"
#import "WYAFinishDownloadView.h"
#import "WYAFinishDownloadManager.h"
#import "WYACourseDetailVC.h"
#import "SODownloader+WYAVideoDownload.h"
#import "WYALocalDownloadModel.h"
#import "WYAQuickLookFileVC.h"
#import "WYALocalVideoVC.h"
@interface WYAFinishDownloadVC ()

@property (nonatomic, strong) WYAFinishDownloadView * finishDownloadView;
@property (nonatomic, strong) WYAFinishDownloadManager * manager;

@end

@implementation WYAFinishDownloadVC

- (WYAFinishDownloadView *)finishDownloadView{
    if (!_finishDownloadView) {
        _finishDownloadView = [[WYAFinishDownloadView alloc]init];
        _finishDownloadView.title = self.courseTitle;
    }
    return _finishDownloadView;
}

- (WYAFinishDownloadManager *)manager{
    if (!_manager) {
        _manager = [[WYAFinishDownloadManager alloc]init];
    }
    return _manager;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"已完成下载";
    [self addNavRightButtonWithTitle:@"管理" TitleColor:[UIColor WYAJHBaseBlueColor]];
    
    [self.view addSubview:self.finishDownloadView];
    [self.finishDownloadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    WeakSelf(weakSelf);
    
    self.finishDownloadView.deleteAction = ^(NSMutableArray *array) {
        [self.manager deleteNowDownloadFile:array TableName:self.courseTitle];
        
        
    };
    
    self.finishDownloadView.goDetailVC = ^{
        StrongSelf(strongSelf);
        WYACourseDetailVC * vc = [[WYACourseDetailVC alloc]init];
        vc.courseID = strongSelf.courseID;
        vc.course_id = strongSelf.courseID;
        vc.titleColorSelected= [UIColor WYAJHBasePurpleColor];
        vc.titleColorNormal = [UIColor WYAJHBlackTextColor];
        vc.menuHeight = 40.f;
        vc.menuViewStyle = WMMenuViewStyleLine;
        vc.progressColor = [UIColor WYAJHBasePurpleColor];
        vc.automaticallyCalculatesItemWidths = YES;
        [strongSelf.navigationController pushViewController:vc animated:YES];
    };
    
    self.finishDownloadView.goWatch = ^(WYALocalDownloadModel *model) {
        StrongSelf(strongSelf);
        if ([model.fileNumber isEqualToString:@"3"]) {
            //课件
            NSString * fileUrl = [[NSString downloadVideoPath] stringByAppendingPathComponent:model.videoName];
            WYAQuickLookFileVC * quicklook = [[WYAQuickLookFileVC alloc]init];
            quicklook.fileURL = [NSURL fileURLWithPath:fileUrl];
            
            [strongSelf presentViewController:quicklook animated:YES completion:nil];
        }else if ([model.fileNumber isEqualToString:@"2"]) {
            //视频
            WYALocalVideoVC * vc = [[WYALocalVideoVC alloc]init];
            vc.url = model.fileLocalurl;
            
            [strongSelf presentViewController:vc animated:YES completion:nil];
        }
    };
    
    [self loadNowDownloadFileData];
    [self addNotice];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults * us = [NSUserDefaults standardUserDefaults];
    [us setBool:NO forKey:@"finishEdit"];
    [us synchronize];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSUserDefaults * us = [NSUserDefaults standardUserDefaults];
    [us setBool:NO forKey:@"finishEdit"];
    [us synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addNotice{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNowDownloadDeleteFile) name:WYAFINISHDOWNLOADDELETEFILE object:nil];
    
}

- (void)rightBarButtonItemClicked:(UIButton *)sender{
    NSUserDefaults * us = [NSUserDefaults standardUserDefaults];
    if ([sender.titleLabel.text isEqualToString:@"管理"]) {
        [us setBool:YES forKey:@"finishEdit"];
        [us synchronize];
        self.finishDownloadView.canEdit = YES;
        
        
        
        [sender setTitle:@"完成" forState:UIControlStateNormal];
    }else if ([sender.titleLabel.text isEqualToString:@"完成"]) {
        [us setBool:NO forKey:@"finishEdit"];
        [us synchronize];
        self.finishDownloadView.canEdit = NO;
        //        sender.selected = NO;
        [sender setTitle:@"管理" forState:UIControlStateNormal];
        
    }
    
}

- (void)loadNowDownloadFileData{
    NSArray * array = [self.manager getFinishDownloadFileWithTableName:self.courseTitle];
    self.finishDownloadView.datas = [array mutableCopy];
    NSLog(@"array==%@",array);
}

- (void)updateNowDownloadDeleteFile{
    NSArray * array = [self.manager getFinishDownloadFileWithTableName:self.courseTitle];
    self.finishDownloadView.datas = [array mutableCopy];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WYANOWDOWNLOADDELETEFILE object:nil];
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
