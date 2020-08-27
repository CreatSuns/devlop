


//
//  WYAChangerPasswordVC.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/23.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAChangerPasswordVC.h"
#import "WYAMineInfoNetRequest.h"
@interface WYAChangerPasswordVC ()

@property (nonatomic, strong) UITextField * userNameTF;

@property (nonatomic, strong) UITextField * oldpasswordTF;

@property (nonatomic, strong) UITextField * newpasswordTF;

@property (nonatomic, strong) UILabel * promptLabel;

@property (nonatomic, strong) WYAMineInfoNetRequest * netRequest;

@end

@implementation WYAChangerPasswordVC

- (WYAMineInfoNetRequest *)netRequest{
    if (!_netRequest) {
        _netRequest = [[WYAMineInfoNetRequest alloc] init];
    }
    return _netRequest;
}

- (UITextField *)userNameTF{
    if (!_userNameTF) {
        _userNameTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth, 44)];
        _userNameTF.text = self.userName;
        _userNameTF.clearButtonMode = UITextFieldViewModeAlways;
        _userNameTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 44)];
        _userNameTF.leftViewMode = UITextFieldViewModeAlways;
        _userNameTF.backgroundColor = [UIColor whiteColor];
        _userNameTF.font = [UIFont systemFontOfSize:14];
    }
    return _userNameTF;
}

- (UITextField *)oldpasswordTF{
    if (!_oldpasswordTF) {
        _oldpasswordTF = [[UITextField alloc]initWithFrame:CGRectMake(0, self.userNameTF.bottom + 10, ScreenWidth, 44)];
        _oldpasswordTF.placeholder = @"请输入旧密码";
        _oldpasswordTF.clearButtonMode = UITextFieldViewModeAlways;
        _oldpasswordTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 44)];
        _oldpasswordTF.leftViewMode = UITextFieldViewModeAlways;
        _oldpasswordTF.backgroundColor = [UIColor whiteColor];
        _oldpasswordTF.font = [UIFont systemFontOfSize:14];
        _oldpasswordTF.secureTextEntry = YES;
    }
    return _oldpasswordTF;
}

- (UITextField *)newpasswordTF{
    if (!_newpasswordTF) {
        _newpasswordTF = [[UITextField alloc]initWithFrame:CGRectMake(0, self.oldpasswordTF.bottom, ScreenWidth, 44)];
        _newpasswordTF.placeholder = @"请输入新密码";
        _newpasswordTF.clearButtonMode = UITextFieldViewModeAlways;
        _newpasswordTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 44)];
        _newpasswordTF.leftViewMode = UITextFieldViewModeAlways;
        _newpasswordTF.backgroundColor = [UIColor whiteColor];
        _newpasswordTF.font = [UIFont systemFontOfSize:14];
        _newpasswordTF.secureTextEntry = YES;
    }
    return _newpasswordTF;
}

- (UILabel *)promptLabel{
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, self.newpasswordTF.bottom+5, ScreenWidth-20, 20)];
        NSAttributedString * string = [WYAJHTools AttribytedStringWithstr:@"提示：密码修改时将同步修改微商管理系统登录密码" changeStr:@[@"提示："] NSAttributedStringKeys:@[NSForegroundColorAttributeName,NSFontAttributeName] NSAttributedValue:@[[UIColor redColor],[UIFont systemFontOfSize:14]]];
        _promptLabel.font = [UIFont systemFontOfSize:14];
        _promptLabel.attributedText = string;
        _promptLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _promptLabel;
    return _promptLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改密码";
    self.view.backgroundColor = [UIColor WYAJHLightGreyColor];
    [self.view addSubview:self.userNameTF];
    [self.view addSubview:self.oldpasswordTF];
    [self.view addSubview:self.newpasswordTF];
    [self.view addSubview:self.promptLabel];
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(20, self.oldpasswordTF.bottom -1, ScreenWidth-20, 1)];
    line.backgroundColor = [UIColor WYAJHLightGreyColor];
    [self.view addSubview:line];
    
    [self addNavRightButtonWithTitle:@"保存" TitleColor:[UIColor WYAJHBasePurpleColor]];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)rightBarButtonItemClicked:(UIButton *)sender{
    [self.view endEditing:YES];
    if (!self.userNameTF.text) {
        [WYAShowMessageView showToastAWithMessage:@"请输入用户名"];
        return;
    }
    
    if (!self.oldpasswordTF.text) {
        [WYAShowMessageView showToastAWithMessage:@"请输入旧密码"];
        return;
    }
    
    if (!self.newpasswordTF.text) {
        [WYAShowMessageView showToastAWithMessage:@"请输入新密码"];
        return;
    }
    
    NSMutableDictionary * params = [NSMutableDictionary new];
    [params setObject:self.userNameTF.text forKey:@"account"];
    [params setObject:self.oldpasswordTF.text forKey:@"old_pwd"];
    [params setObject:self.newpasswordTF.text forKey:@"new_pwd"];
    
    [self.netRequest changerPasswordWithParams:params Success:^(id data) {
        [WYAShowMessageView showToastAWithMessage:data[@"msg"]];
        if ([data[@"status"] intValue]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
        self.oldpasswordTF.text = nil;
        self.newpasswordTF.text = nil;
        }
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
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
