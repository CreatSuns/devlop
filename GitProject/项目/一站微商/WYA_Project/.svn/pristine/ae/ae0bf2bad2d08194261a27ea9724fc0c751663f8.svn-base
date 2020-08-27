//
//  WYANavigationViewController.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/4.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYANavigationViewController.h"

@interface WYANavigationViewController ()

@end

@implementation WYANavigationViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationBar.barTintColor = [UIColor WYAJHBackGroundColor];
    self.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

#pragma mark 重写push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:YES];
    
    //如果导航栏左按钮不存在，则对其进行设置
    if (viewController.navigationItem.leftBarButtonItem == nil) {
        
        UIButton * backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44*Size_ratio, 44)];
        [backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        
        
        viewController.navigationItem.leftBarButtonItem = leftButton;
    }
}

#pragma mark 设置按钮动作
- (void)backAction:(UIBarButtonItem *)sender
{
    [self popViewControllerAnimated:YES];
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
