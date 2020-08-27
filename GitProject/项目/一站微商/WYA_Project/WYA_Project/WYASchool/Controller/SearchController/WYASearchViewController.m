//
//  WYASearchViewController.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/24.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYASearchViewController.h"
#import "WYASearchModel.h"
#import "WYASearchView.h"
#import "WYASearchNetRequest.h"
#import "WYASearchAllViewController.h"
#import "WYASearchArticleViewController.h"
#import "WYASearchCourseViewController.h"
#import "WYASearchTeacherViewController.h"
@interface WYASearchViewController ()<WYASearchBarDelegate>
@property(nonatomic, strong) WYASearchView * wyaSearchBar;
@property(nonatomic, strong) WYASearchNetRequest * searchNetRequest;
@property(nonatomic, strong) NSMutableArray * allDataArray;
@property(nonatomic, copy) NSString * searchText;
@property(nonatomic, strong) UIView * searchBackGroundView;
@end

@implementation WYASearchViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.translucent = YES;

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.hidden = NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    _allDataArray = [NSMutableArray array];
    [self.view addSubview:self.wyaSearchBar];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(menuItemsSelected:) name:@"SearchSelectedIndex" object:nil];

    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark ====== Notification
- (void)menuItemsSelected:(NSNotification*)notfication
{
    self.selectIndex = [notfication.userInfo[@"selectedIndex"] intValue];
    [self reloadData];
}
#pragma mark ====== creatUI
- (UIView *)searchBackGroundView
{
    if (_searchBackGroundView == nil) {
        _searchBackGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, WYAStatusBarHeight+44, ScreenWidth, ScreenHeight)];
        _searchBackGroundView.backgroundColor = [UIColor whiteColor];
    }
    return _searchBackGroundView;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.wyaSearchBar.searchTextFiled resignFirstResponder];
}
- (WYASearchView *)wyaSearchBar
{
    if (_wyaSearchBar == nil) {
        _wyaSearchBar = [[WYASearchView alloc]initWithFrame:CGRectMake(0, WYAStatusBarHeight, ScreenWidth, 44)];
        _wyaSearchBar.delegate = self;
    }
    return _wyaSearchBar;
}
#pragma mark ====== search
- (WYASearchNetRequest *)searchNetRequest
{
    if(_searchNetRequest == nil){
        _searchNetRequest = [[WYASearchNetRequest alloc]init];
    }
    return _searchNetRequest;
}
- (void)searchNetRequestWithText:(NSString *)searchString
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"search"] = searchString;
    [self.searchNetRequest searchRequestWithParams:dict Success:^(id data) {
        NSLog(@"%@",data);
        self.selectIndex = 0;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuViewLayoutMode = WMMenuViewLayoutModeScatter;
        self.progressWidth = 30*Size_ratio;
        self.menuBGColor = [UIColor WYAJHBackGroundColor];
        self.titleColorSelected = [UIColor WYAJHBasePurpleColor];
        self.titleColorNormal = [UIColor WYAJHTabBarNormalColor];
        _allDataArray = data;
        [self reloadData];
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}

- (void)searchBtnClicked:(NSString *)searceContent
{
    _searchText = searceContent;
    if (![searceContent isEqualToString:@"NO"]) {
        [self searchNetRequestWithText:searceContent];
        [self.searchBackGroundView removeFromSuperview];
    }else
    {
        [self.view addSubview:self.searchBackGroundView];
    }
}
- (void)searchCancleBtnClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark ====== 第三方代理实现
#pragma make 第三方需要实现的方法  WMPageController
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.allDataArray.count;
}

#pragma make 第三方需要实现的方法  WMPageController
- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    
    if (index == 0) {
        WYASearchAllViewController * allVc = [[WYASearchAllViewController alloc]init];
        allVc.allDataSources = self.allDataArray[0];
        allVc.searchVC = self;
        return allVc;
    }else if (index == 1) {
        WYASearchCourseViewController * courseVc = [[WYASearchCourseViewController alloc]init];
        courseVc.searchText = _searchText;
        return courseVc;
    }else if (index == 2){
        WYASearchArticleViewController * articleVc = [[WYASearchArticleViewController alloc]init];
        articleVc.searchText = _searchText;
        return articleVc;
  
    }else if (index == 3){
        WYASearchTeacherViewController * teacherVc = [[WYASearchTeacherViewController alloc]init];
        teacherVc.searchText = _searchText;
        return teacherVc;
    }
    return [UIViewController new];
}

#pragma make 第三方需要实现的方法  WMPageController
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    switch (index % 4) {
        case 0: return @"全部";
        case 1: return @"课程";
        case 2: return @"文章";
        case 3: return @"讲师";
    }
    return @"NONE";
}
@end
