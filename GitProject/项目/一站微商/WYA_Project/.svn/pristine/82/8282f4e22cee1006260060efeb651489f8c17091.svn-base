//
//  WYASchoolVC.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/4.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYASchoolVC.h"
#import "WYAArticleVC.h"
#import "WYACouresVC.h"
#import "WYALecturerVC.h"
#import "WYASearchViewController.h"

@interface WYASchoolVC ()

@end

@implementation WYASchoolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44*Size_ratio, 44);
    [button setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    button.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[UIButton new]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma make 第三方需要实现的方法  WMPageController
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return 3;
}

#pragma make 第三方需要实现的方法  WMPageController
- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{

    if (index == 0) {
        WYAArticleVC * article = [[WYAArticleVC alloc] init];
        return article;
    }else if (index == 1) {
        WYACouresVC * coures = [[WYACouresVC alloc] init];
        return coures;
    }else {
        WYALecturerVC * lecturer = [[WYALecturerVC alloc] init];
        return lecturer;
    }
}

#pragma make 第三方需要实现的方法  WMPageController
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    switch (index % 3) {
        case 0: return @"文章";
        case 1: return @"课程";
        case 2: return @"讲师";
    }
    return @"NONE";
}
- (void)searchClick{
    
    WYASearchViewController * vc = [[WYASearchViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:NO];
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
