//
//  WYAMineCollectionVC.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/16.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMineCollectionVC.h"

#import "WYAMineCollectionNetRequest.h"
#import "WYAMineCollectionCourseModel.h"
#import "WYAMineCollectionArticleModel.h"

#import "WYAMineCollectionCourseVC.h"
#import "WYAMineCollectionArticleVC.h"
#import "UIView+WYALayout.h"
@interface WYAMineCollectionVC ()<VTMagicViewDelegate, VTMagicViewDataSource>
@property (nonatomic, strong) VTMagicController * magicController;
@property (nonatomic, strong) WYAMineCollectionNetRequest * netRequest;

@end

@implementation WYAMineCollectionVC

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

- (WYAMineCollectionNetRequest *)netRequest{
    if (!_netRequest) {
        _netRequest = [[WYAMineCollectionNetRequest alloc]init];
    }
    return _netRequest;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的收藏";
    
    self.view.backgroundColor = [UIColor WYAJHLightGreyColor];
    [self addChildViewController:self.magicController];
    [self.view addSubview:self.magicController.view];
    [self.magicController.magicView reloadData];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;

}

- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * roleID = [userDefaults objectForKey:@"role_id"];
    if (![roleID isEqualToString:@"1"]) {
        return @[@"课程"];
    }
    return @[@"课程",@"文章"];
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
        WYAMineCollectionCourseVC * vc = [magicView dequeueReusablePageWithIdentifier:recomId];
        if (!vc) {
            vc = [[WYAMineCollectionCourseVC alloc] init];
        }
        return vc;
    }else{
        static NSString *recomId = @"low.identifier";
        WYAMineCollectionArticleVC * vc = [magicView dequeueReusablePageWithIdentifier:recomId];
        if (!vc) {
            vc = [[WYAMineCollectionArticleVC alloc] init];
        }
        
        return vc;
    }
    
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
