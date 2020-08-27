//
//  WYALecturer.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/6.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYALecturerVC.h"
#import "WYALecturerListVC.h"
@interface WYALecturerVC ()

@end

@implementation WYALecturerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.menuHeight = 0;
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma make 第三方需要实现的方法  WMPageController
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return 1;
}

#pragma make 第三方需要实现的方法  WMPageController
- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    
    return [[WYALecturerListVC alloc] init];
}

#pragma make 第三方需要实现的方法  WMPageController
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    switch (index % 3) {
        case 0: return @"";
        case 1: return @"程";
        case 2: return @"师";
    }
    return @"NONE";
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
