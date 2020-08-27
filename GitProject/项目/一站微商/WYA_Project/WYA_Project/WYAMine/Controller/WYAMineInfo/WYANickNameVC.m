//
//  WYANickNameVC.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/23.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYANickNameVC.h"
#import "WYAMineInfoNetRequest.h"

@interface WYANickNameVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField * nickNameTF;

@property (nonatomic, strong) UIView * rightView;

@property (nonatomic, strong) UIButton * button;

@property (nonatomic, strong) UILabel * promptLabel;

@property (nonatomic, strong) WYAMineInfoNetRequest * netRequest;



@end

@implementation WYANickNameVC

- (WYAMineInfoNetRequest *)netRequest{
    if (!_netRequest) {
        _netRequest = [[WYAMineInfoNetRequest alloc] init];
    }
    return _netRequest;
}

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setImage:[UIImage imageNamed:@"delete_icon"] forState:UIControlStateNormal];
        _button.frame = CGRectMake(13, 11, 16, 16);
        [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (UIView *)rightView{
    if (!_rightView) {
        _rightView = [[UIView alloc]init];
        _rightView.frame = CGRectMake(0, 0, 38, 45);
        _rightView.backgroundColor = [UIColor whiteColor];
        [_rightView addSubview:self.button];
    }
    return _rightView;
}

- (UITextField *)nickNameTF{
    if (!_nickNameTF) {
        _nickNameTF = [[UITextField alloc] init];
        _nickNameTF.delegate = self;
        _nickNameTF.backgroundColor = [UIColor whiteColor];
        _nickNameTF.textColor = [UIColor WYAJHLightBlackTextColor];
        _nickNameTF.rightView = self.rightView;
        _nickNameTF.rightViewMode = UITextFieldViewModeAlways;
        _nickNameTF.frame = CGRectMake(0, 10, ScreenWidth, 45);
        _nickNameTF.placeholder = @"请输入您要更改的昵称";
        _nickNameTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 45)];
        _nickNameTF.leftViewMode = UITextFieldViewModeAlways;
    }
    return _nickNameTF;
}

- (UILabel *)promptLabel{
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc]init];
        _promptLabel.text = @"2-20个字符组成，可有中英文、数字组成";
        _promptLabel.font = [UIFont systemFontOfSize:12];
        _promptLabel.textColor = [UIColor WYAJHgrayTextColor];
        _promptLabel.frame = CGRectMake(20, self.nickNameTF.bottom+2, ScreenWidth-10, 20);
    }
    return _promptLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"昵称";
    self.view.backgroundColor = [UIColor WYAJHLightGreyColor];
    [self.view addSubview:self.nickNameTF];
    [self.view addSubview:self.promptLabel];
    [self addNavRightButtonWithTitle:@"保存" TitleColor:[UIColor WYAJHBasePurpleColor]];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)rightBarButtonItemClicked:(UIButton *)sender{
    [self.view endEditing:YES];
    if (!self.nickNameTF.text) {
        [WYAShowMessageView showToastAWithMessage:@"请输入昵称"];
        return;
    }
    
    if ([self checkUserNickName:self.nickNameTF.text]) {
        [self.netRequest updateUserNickName:self.nickNameTF.text Success:^(id data) {
            
        } Fail:^(NetRequestCode netCode, NSString *errorDes) {
            
        }];
    }else{
        [WYAShowMessageView showToastAWithMessage:@"输入昵称不符合规范"];
        return;
    }
    
    
}

- (void)buttonClick{
    self.nickNameTF.text = nil;
}

- (BOOL)checkUserNickName:(NSString *)nickName
{
    NSString *pattern = @"^[[a-zA-Z0-9]]{2,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:nickName];
    return isMatch;
    
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
