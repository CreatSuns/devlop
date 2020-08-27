//
//  WYATestScoresVC.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/18.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYATestScoresVC.h"
#import "WYAMineTestScoresVC.h"
#import "WYALowerLeverTestScoresVC.h"
#import "UIView+WYALayout.h"
@interface WYATestScoresVC ()<VTMagicViewDelegate, VTMagicViewDataSource>
@property (nonatomic, strong) VTMagicController * magicController;

@end

@implementation WYATestScoresVC

- (VTMagicController *)magicController {
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.magicView.layoutStyle = VTLayoutStyleCenter;
        _magicController.magicView.sliderStyle = VTSliderStyleDefault;
        _magicController.magicView.navigationHeight = 57.f;
        _magicController.magicView.navigationColor = [UIColor WYAJHLightGreyColor];
        _magicController.magicView.previewItems = 2;
        _magicController.magicView.itemWidth = 155*Size_ratio;
        _magicController.magicView.bubbleInset = UIEdgeInsetsMake(2, 7, 2, 7);
        _magicController.magicView.bubbleRadius = 10;
        _magicController.magicView.separatorHidden = YES;
        _magicController.magicView.sliderHeight = 0;
//        _magicController.magicView.separatorColor = [UIColor WYAJHLightGreyColor];
        _magicController.magicView.navigationInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
    }
    return _magicController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"测试成绩";
    self.view.backgroundColor = [UIColor WYAJHLightGreyColor];
    [self addChildViewController:self.magicController];
    [self.view addSubview:self.magicController.view];
    self.magicController.magicView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-WYATopHeight-WYABottomHeight);
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * roleID = [userDefaults objectForKey:@"role_id"];
    if (![roleID isEqualToString:@"1"]) {
        self.magicController.magicView.navigationHeight = 0;
    }
    
//    self.menuView.backgroundColor = [UIColor WYAJHLightGreyColor];
    
    [self.magicController.magicView reloadData];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma make 第三方需要实现的方法  WMPageController
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return 2;
}
#pragma make 第三方需要实现的方法  WMPageController
- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    if (index == 0) {
        WYAMineTestScoresVC * mine = [[WYAMineTestScoresVC alloc]init];
        return mine;
    }else{
        WYALowerLeverTestScoresVC * lowLever = [[WYALowerLeverTestScoresVC alloc]init];
        return lowLever;
    }
    return [[UIViewController alloc]init];
    
}
#pragma make 第三方需要实现的方法  WMPageController
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    if (index == 0) {
        return @"我的";
    }else{
        return @"下级";
    }
}
*/
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * roleID = [userDefaults objectForKey:@"role_id"];
    if (![roleID isEqualToString:@"1"]) {
        return @[@"我的"];
    }
    return @[@"我的",@"下级"];
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * roleID = [userDefaults objectForKey:@"role_id"];
    if (![roleID isEqualToString:@"1"]) {
        return nil;
    }
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:[UIColor WYAJHLightBlackTextColor] forState:UIControlStateNormal];
        [menuItem setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [menuItem setBackgroundImage:[UIImage imageNamed:@"白色"] forState:UIControlStateNormal];
        [menuItem setBackgroundImage:[UIImage imageNamed:@"渐变色"] forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.f];
    }
    if (itemIndex == 0) {
        [menuItem addRoundedCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft withRadii:CGSizeMake(5, 5) viewRect:CGRectMake(0, 0, 155*Size_ratio, 37)];
    }else{
        [menuItem addRoundedCorners:UIRectCornerTopRight | UIRectCornerBottomRight withRadii:CGSizeMake(5, 5) viewRect:CGRectMake(0, 0, 155*Size_ratio, 37)];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    if (pageIndex == 0) {
        static NSString *recomId = @"mine.identifier";
        WYAMineTestScoresVC * vc = [magicView dequeueReusablePageWithIdentifier:recomId];
        if (!vc) {
            vc = [[WYAMineTestScoresVC alloc] init];
        }
        return vc;
    }else{
        static NSString *recomId = @"low.identifier";
        WYALowerLeverTestScoresVC * vc = [magicView dequeueReusablePageWithIdentifier:recomId];
        if (!vc) {
            vc = [[WYALowerLeverTestScoresVC alloc] init];
        }
        
        return vc;
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
