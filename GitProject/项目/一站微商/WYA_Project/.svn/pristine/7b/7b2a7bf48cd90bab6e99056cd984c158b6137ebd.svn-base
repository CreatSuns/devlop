//
//  WYALoginVC.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/4.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYALoginVC.h"
#import "WYALoginView.h"
#import "WYALoginNetRequest.h"
#import "WYATabbarViewController.h"
@interface WYALoginVC ()<UIScrollViewDelegate>
{
    // 创建页码控制器
    UIPageControl *pageControl;
    // 判断是否是第一次进入应用
    BOOL flag;
}
@property (nonatomic, strong)WYALoginNetRequest * loginNet;

@property (nonatomic, strong) WYAJHTools * tool;
@end

@implementation WYALoginVC

-(WYALoginNetRequest *)loginNet{
    if (!_loginNet) {
        _loginNet = [[WYALoginNetRequest alloc]init];
    }
    return _loginNet;
}

- (WYAJHTools *)tool{
    if (!_tool) {
        _tool = [[WYAJHTools alloc]init];
    }
    return _tool;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    NSUserDefaults *useDef = [NSUserDefaults standardUserDefaults];
    if (![useDef boolForKey:@"notFirst"]) {
        // 如果是第一次进入引导页
        [self addScrollView];
    }
    else{
        // 否则直接进入应用
        [self addLoginView];
    }
    
    // Do any additional setup after loading the view.
    
    
}
#pragma mark ====== 添加登录页
- (void)addLoginView{
    WYALoginView * loginView = [[WYALoginView alloc]init];
    [self.view addSubview:loginView];
    
    [loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    loginView.BtnClick = ^(NSString *account, NSString *password) {
        if (account && account.length > 0 && password && password.length > 0) {
            [MBProgressHUD showMessage:@"正在登陆..." ToView:self.view];
            NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
            [user setObject:account forKey:@"wya_user_name"];
            [user synchronize];
            [self.loginNet loginWithParams:[NSMutableDictionary dictionaryWithDictionary:@{@"user_name":account,@"password":password}] Success:^(id data) {
                NSDictionary * dic = (NSDictionary *)data;
                NSNumber * number = dic[@"status"];
                if ([number floatValue] == 1) {
                    WYATabbarViewController * tabbar = [[WYATabbarViewController alloc]init];
                    Window.rootViewController = tabbar;
                }else{
                    [WYAShowMessageView showToastAWithMessage:data[@"msg"]];
                }
                [MBProgressHUD hideHUDForView:self.view];
            } Fail:^(NetRequestCode netCode, NSString *errorDes) {
                [WYAShowMessageView showToastAWithMessage:@"请检查您的网络连接或稍后再试"];
                [MBProgressHUD hideHUDForView:self.view];
            }];
        }else{
            [WYAShowMessageView showToastBWithMessage:@"请输入账号或密码"];
        }
        
    };
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ====== 添加引导页
- (void)addScrollView
{
    NSArray * array = @[@"home1",@"home2",@"home3",@"home4",@"home5"];
    NSUInteger count = array.count;
    UIScrollView *myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    for (int i=0; i<array.count; i++) {
        UIImage *image = [UIImage imageNamed:array[i]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth * i, 0, ScreenWidth, ScreenHeight)];
        if (i == 4) {
            imageView.userInteractionEnabled = YES;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            [imageView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(imageView.mas_right).offset(-15*Size_ratio);
                make.top.equalTo(imageView.mas_top).offset(WYAStatusBarHeight+20*Size_ratio);
                make.width.mas_equalTo(85*Size_ratio);
                make.height.mas_equalTo(40*Size_ratio);
            }];
            [button setTitle:@"点击进入" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.layer.borderWidth = 2;
            button.layer.cornerRadius = 5;
            button.clipsToBounds = YES;
            button.layer.borderColor = [UIColor whiteColor].CGColor;
            [button addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
        }
        imageView.image = image;
        [myScrollView addSubview:imageView];
    }
    myScrollView.bounces = NO;
    myScrollView.pagingEnabled = YES;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.contentSize = CGSizeMake(ScreenWidth * count, ScreenHeight);
    myScrollView.delegate = self;
    [self.view addSubview:myScrollView];
    
    pageControl = [[UIPageControl alloc] init];
    [self.view addSubview:pageControl];
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-WYABottomHeight);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(20*Size_ratio);
        make.width.mas_equalTo(ScreenWidth/count);
    }];
    pageControl.numberOfPages = count;
    pageControl.pageIndicatorTintColor = [UIColor WYAJHBasePurpleColor];
    pageControl.currentPageIndicatorTintColor = [UIColor WYAJHBaseRedColor];
    
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width);
}

- (void) go:(UIButton *)sender{
    flag = YES;
    NSUserDefaults *useDef = [NSUserDefaults standardUserDefaults];
    [useDef setBool:flag forKey:@"notFirst"];
    [useDef synchronize];
    [self addLoginView];
}


@end
