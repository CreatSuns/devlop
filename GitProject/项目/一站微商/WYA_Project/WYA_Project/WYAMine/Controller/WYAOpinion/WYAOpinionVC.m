//
//  WYAOpinionVC.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/9.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAOpinionVC.h"
#import "WYAOpinionView.h"
#import "WYAOpinionNetRequest.h"

@interface WYAOpinionVC ()

@property (nonatomic, strong) WYAOpinionView * opinionView;

@property (nonatomic, strong) WYAOpinionNetRequest * netRequest;
@end

@implementation WYAOpinionVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    self.title = @"意见反馈";
    [self.view addSubview:self.opinionView];
    
    WeakSelf(weakSelf);
    self.opinionView.submitOpinion = ^(NSString *text) {
        
        NSMutableDictionary * params = [NSMutableDictionary dictionaryWithCapacity:0];
        [params setObject:text forKey:@"content"];
        
        StrongSelf(strongSelf);
        
        [strongSelf.netRequest submitOpinionWithParams:params Success:^(id data) {
            
            [WYAShowMessageView showToastBWithMessage:@"提交成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [strongSelf.navigationController popViewControllerAnimated:YES];
            });
            
        } Fail:^(NetRequestCode netCode, NSString *errorDes) {
            
            [WYAShowMessageView showToastAWithMessage:@"请检查您的网络连接，或稍后重试"];
            
        }];
        
    };
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(WYAOpinionView *)opinionView{
    if (!_opinionView) {
        _opinionView = [[WYAOpinionView alloc]init];
        [self.view addSubview:_opinionView];
        [_opinionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _opinionView;
}

-(WYAOpinionNetRequest *)netRequest{
    if (!_netRequest) {
        _netRequest = [[WYAOpinionNetRequest alloc]init];
    }
    return _netRequest;
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
