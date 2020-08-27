//
//  WYAQuickLookFileVC.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/14.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAQuickLookFileVC.h"
#import "WYACourseDownloadNavView.h"

@interface WYAQuickLookFileVC ()

@property (nonatomic, strong) WYACourseDownloadNavView * navView;

@end

@implementation WYAQuickLookFileVC

- (QLPreviewController *)previewController{
    if (!_previewController) {
        _previewController = [[QLPreviewController alloc] init];
        _previewController.dataSource = self;
        _previewController.delegate = self;
        _previewController.currentPreviewItemIndex = 0;
    }
    return _previewController;
}

-(WYACourseDownloadNavView *)navView{
    if (!_navView) {
        _navView = [[WYACourseDownloadNavView alloc]init];
    }
    return _navView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top);
        make.height.mas_equalTo(WYATopHeight);
    }];
    
    self.navView.title = @"附件预览";
    WeakSelf(weakSelf);
    self.navView.buttonAction = ^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    
    [self.view addSubview:self.previewController.view];
    [self.previewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.top.mas_equalTo(self.navView.mas_bottom);
    }];
    
    [self.previewController reloadData];
    
}


- (id)previewController: (QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    return self.fileURL;
}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}

//-(CGRect)previewController:(QLPreviewController *)controller frameForPreviewItem:(id <QLPreviewItem>)item inSourceView:(UIView * _Nullable * __nonnull)view
//{
//    
//    //提供变焦的开始rect，扩展到全屏
//    
//    return  CGRectMake(110, 190, 100, 100);
//    
//}

//-(UIImage *)previewController:(QLPreviewController*)controller transitionImageForPreviewItem:(id<QLPreviewItem>)itemcontentRect:(CGRect *)contentRect
//
//{
//
//    //返回控制器在出现和消失时显示的图像
//
//    return [UIImageimageNamed:@"gerenziliao_morentouxiang.png"];
//
//}

-(void)previewControllerDidDismiss:(QLPreviewController*)controller

{
    
    //控制器消失后调用
    
}

-(void)previewControllerWillDismiss:(QLPreviewController*)controller

{
    
    //控制器在即将消失后调用
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
