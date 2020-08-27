//
//  WYALoginView.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/4.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYALoginView.h"

@interface WYALoginView ()

/**
 账号输入框
 */
@property (nonatomic, strong)UITextField * accountTF;

/**
 密码输入框
 */
@property (nonatomic, strong)UITextField * passwordTF;

/**
 登录按钮
 */
@property (nonatomic, strong)UIButton * loginButton;

@end

@implementation WYALoginView


-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        UIImageView * bgView = [[UIImageView alloc]init];
        bgView.contentMode = UIViewContentModeScaleToFill;
        bgView.image = [UIImage imageNamed:@"启动页"];
        [self addSubview:bgView];
        
        UIImageView * iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
        [self addSubview:iconView];
        
        UIView * userView = [[UIView alloc]init];
        userView.backgroundColor = [UIColor whiteColor];
        [self addSubview:userView];
        userView.layer.cornerRadius = 10;
        userView.layer.masksToBounds = YES;
        
        UIView * account_leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        account_leftView.backgroundColor = [UIColor colorWithHexString:@"#EDE5D5"];
        
        UIImageView * account_left_imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine"]];
        account_left_imageView.frame = CGRectMake(16, 12, 16, 16);
        [account_leftView addSubview:account_left_imageView];
        
        self.accountTF = [[UITextField alloc]init];
        self.accountTF.placeholder = @"用户名";
        self.accountTF.leftView = account_leftView;
        self.accountTF.leftViewMode = UITextFieldViewModeAlways;
        self.accountTF.backgroundColor = [UIColor colorWithHexString:@"#EDE5D5"];
        [self.accountTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [userView addSubview:self.accountTF];
        
        UIView * password_leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        password_leftView.backgroundColor = [UIColor colorWithHexString:@"#EDE5D5"];
        
        UIImageView * password_left_imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Lock"]];
        password_left_imageView.frame = CGRectMake(16, 12, 16, 16);
        [password_leftView addSubview:password_left_imageView];
        
        self.passwordTF = [[UITextField alloc]init];
        self.passwordTF.placeholder = @"密码";
        self.passwordTF.leftView = password_leftView;
        self.passwordTF.leftViewMode = UITextFieldViewModeAlways;
        self.passwordTF.backgroundColor = [UIColor colorWithHexString:@"#EDE5D5"];
        self.passwordTF.secureTextEntry = YES;
        [self.passwordTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [self.passwordTF addTarget:self action:@selector(textChangeClick) forControlEvents:UIControlEventValueChanged];
        [userView addSubview:self.passwordTF];
        
        self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.loginButton setTitle:@"进入课堂" forState:UIControlStateNormal];
        
        [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.loginButton setBackgroundColor:[UIColor WYAJHBasePurpleColor]];
        [self.loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.loginButton];
        self.loginButton.layer.cornerRadius = 10;
        self.loginButton.layer.masksToBounds = YES;
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bgView);
            make.top.mas_equalTo(bgView.mas_top).with.offset(100);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
        
        [userView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(bgView.mas_centerY);
            make.left.mas_equalTo(bgView.mas_left).with.offset(50*Size_ratio);
            make.right.mas_equalTo(bgView.mas_right).with.offset(-50*Size_ratio);
            make.height.mas_equalTo(@100);
        }];
        
        [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(userView.mas_top);
            make.left.mas_equalTo(userView.mas_left);
            make.right.mas_equalTo(userView.mas_right);
            make.height.mas_equalTo(@49.5);
        }];
        
        [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(userView.mas_bottom);
            make.left.mas_equalTo(userView.mas_left);
            make.right.mas_equalTo(userView.mas_right);
            make.height.mas_equalTo(@49.5);
        }];
        
        [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(userView.mas_bottom).with.offset(20);
            make.left.mas_equalTo(bgView.mas_left).with.offset(50);
            make.right.mas_equalTo(bgView.mas_right).with.offset(-50);
            make.height.mas_equalTo(@50);
        }];
        
    }
    
    return self;
}

#pragma mark Action
-(void)loginButtonClick{
    [self endEditing:YES];
    if (self.accountTF.text.length<1 || self.passwordTF.text.length<1) {
        [WYAShowMessageView showToastAWithMessage:@"请填写用户名和密码"];
        return;
    }
    if (self.BtnClick) {
        self.BtnClick(self.accountTF.text, self.passwordTF.text);
    }
}

-(void)textChangeClick{
    [self.loginButton setBackgroundColor:[UIColor colorWithHexString:@"#585BD1"]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
