//
//  WYAViewController.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/4.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAViewController.h"

@interface WYAViewController ()<UIGestureRecognizerDelegate>

@end

@implementation WYAViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
//
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
//    [pan addTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")];
//    pan.delegate = self;
//
//    [self.navigationController.view addGestureRecognizer:pan];
//
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
#pragma mark - 滑动开始触发事件
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    if (self.navigationController.viewControllers.count <= 1) {
//        return NO;
//    }
//    return YES;
//}
- (void)addNavRightButtonWithImageNamed:(NSString *)named
{
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame =CGRectMake(0,0, 60*Size_ratio, 44);
    [but setImage:[UIImage imageNamed:named] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(rightBarButtonItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem  *barBut = [[UIBarButtonItem alloc]initWithCustomView:but];
    self.navigationItem.rightBarButtonItem = barBut;
}
- (void)addNavRightButtonWithTitle:(NSString *)title TitleColor:(UIColor *)titleColor
{
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame =CGRectMake(0,0, 60*Size_ratio, 44);
    [but setTitle:title forState:UIControlStateNormal];
    but.titleLabel.font = [UIFont systemFontOfSize:14*Size_ratio];
    [but setTitleColor:titleColor ? titleColor:[UIColor WYAJHBaseBlueColor] forState:UIControlStateNormal];
    [but setTitleColor:[UIColor WYAJHLightGreyColor] forState:UIControlStateHighlighted];
    [but addTarget:self action:@selector(rightBarButtonItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem  *barBut = [[UIBarButtonItem alloc]initWithCustomView:but];
    self.navigationItem.rightBarButtonItem = barBut;
}
- (void)addCustomNavLeftButton
{
    UIButton * backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44*Size_ratio, 44)];
    [backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    
    self.navigationItem.leftBarButtonItem = leftButton;
}
- (void)rightBarButtonItemClicked:(UIButton *)sender
{
    
}
- (void)goBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 重写push方法

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // 内存溢出时清楚SD的缓存
    [[SDWebImageManager sharedManager] cancelAll];
    
    [[SDImageCache sharedImageCache] clearDisk];
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
