//
//  WYATabbarViewController.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/4.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYATabbarViewController.h"
#import "WYANavigationViewController.h"
#import "WYASchoolVC.h"
#import "WYAWeChatBusinessVC.h"
#import "WYAMineViewController.h"

@interface WYATabbarViewController ()

@end

@implementation WYATabbarViewController

+ (void)initialize{
    [[UITabBar appearance] setBackgroundColor:[UIColor WYAJHBackGroundColor]];
    
    NSMutableDictionary * tabDic=[NSMutableDictionary dictionary];
    tabDic[NSForegroundColorAttributeName] = [UIColor WYAJHTabBarNormalColor];
    
    NSMutableDictionary * selectedTabDic=[NSMutableDictionary dictionary];
    selectedTabDic[NSForegroundColorAttributeName] = [UIColor WYAJHTabBarSelectedColor];
    
    UITabBarItem *item=[UITabBarItem appearance];
    [item setTitleTextAttributes:tabDic forState:(UIControlStateNormal)];
    [item setTitleTextAttributes:selectedTabDic forState:(UIControlStateSelected)];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WYASchoolVC * school = [[WYASchoolVC alloc]init];
    school.showOnNavigationBar = YES;
    school.selectIndex = 1;
    school.menuViewStyle = WMMenuViewStyleLine;
    school.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
    school.progressWidth = 29.5;
    school.menuBGColor = [UIColor WYAJHBackGroundColor];
    school.titleColorSelected = [UIColor WYAJHBlackTextColor];
    school.progressColor = [UIColor WYAJHBasePurpleColor];
    school.titleColorNormal = [UIColor WYAJHTabBarNormalColor];
    [self setChildViewController:school Title:@"我的学习" Image:@"learning_Normal" SelectedImage:@"learning_Selected"];
//    [self setChildViewController:[[WYAWeChatBusinessVC alloc]init] Title:@"微商" Image:@"Home_Normal" SelectedImage:@"Home_Selected"];
    [self setChildViewController:[[WYAMineViewController alloc]init] Title:@"我的" Image:@"My_Normal" SelectedImage:@"My_Selected"];
    
}


/**
 *  初始化控制器
 */
- (void)setChildViewController:(UIViewController*)childVC Title:(NSString*)title Image:(NSString *)image SelectedImage:(NSString *)selectedImage
{
    /**
     *  添加 tabBarItem 上的文字和图片
     */
    childVC.title=title;
    childVC.tabBarItem.image=[UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage=[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    WYANavigationViewController *nav = [[WYANavigationViewController alloc]initWithRootViewController:childVC];
    [self addChildViewController:nav];
    
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
