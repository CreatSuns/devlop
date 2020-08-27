//
//  WYASearchView.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/24.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYASearchView.h"
#import "UIView+WYALayout.h"
@interface WYASearchView ()<UITextFieldDelegate>
@property(nonatomic, strong) UIView * searchBar;
@property(nonatomic, strong) UIButton * cancleBtn;
@property(nonatomic, strong) UIView * lineView;
@end
@implementation WYASearchView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        _searchBar.userInteractionEnabled = YES;
        _searchBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
        _searchBar.backgroundColor = [UIColor whiteColor];
        _searchTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(10*Size_ratio,8*Size_ratio,340*Size_ratio, 30*Size_ratio)];
        [_searchBar addSubview:_searchTextFiled];
        _cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(350*Size_ratio, 8*Size_ratio, 60*Size_ratio, 30*Size_ratio)];
        [_searchBar addSubview:_cancleBtn];
        
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor WYAJHLightGreyColor];
        [_searchBar addSubview:_lineView];
        
        _lineView.bottom = _searchBar.cmam_bottom-1;
        _lineView.left = 0;
        _lineView.width = ScreenWidth;
        _lineView.height = 1;
        
        [self addSubview:_searchBar];
        
        self.backgroundColor = [UIColor redColor];
        [self setUI];
    }
    return self;
}
- (void)setUI
{
    _searchTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    _searchTextFiled.backgroundColor = [UIColor WYAJHLightGreyColor];
    _searchTextFiled.textColor = [UIColor WYAJHBlackTextColor];
    _searchTextFiled.textAlignment = NSTextAlignmentLeft;
    _searchTextFiled.font = [UIFont systemFontOfSize:14*Size_ratio];
    _searchTextFiled.placeholder = @"搜索感兴趣的内容";
    _searchTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30*Size_ratio, 20*Size_ratio)];
    imageView.image = [UIImage imageNamed:@"搜索"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    _searchTextFiled.leftView = imageView;
    _searchTextFiled.leftViewMode = UITextFieldViewModeAlways;
    _searchTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
//    _searchTextFiled.clearsOnBeginEditing = YES
    _searchTextFiled.keyboardType = UIKeyboardTypeDefault;
    _searchTextFiled.returnKeyType = UIReturnKeySearch;
    _searchTextFiled.delegate = self;
    
    [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancleBtn setTitleColor:[UIColor WYAJHBlackTextColor] forState:UIControlStateNormal];
    [_cancleBtn setTitleColor:[UIColor WYAJHgrayTextColor] forState:UIControlStateHighlighted];
    [_cancleBtn addTarget:self action:@selector(cancleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:14*Size_ratio];

}
#pragma mark ====== event
- (void)cancleBtnClicked:(UIButton *)sender
{
    [_searchTextFiled resignFirstResponder];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(searchCancleBtnClicked:)]) {
        [self.delegate searchCancleBtnClicked:sender];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_searchTextFiled resignFirstResponder];
}
#pragma mark ======UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    [textField resignFirstResponder];
    
        if (self.delegate && [self.delegate respondsToSelector:@selector(searchBtnClicked:)]) {
            [self.delegate searchBtnClicked:@"NO"];
        
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (![textField.text isEqualToString:@"搜索感兴趣的内容"]&&textField.text.length != 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(searchBtnClicked:)]) {
            [self.delegate searchBtnClicked:textField.text];
        }
    }else
    {
        [WYAShowMessageView showToastBWithMessage:@"请输入内容"];
    }
    return YES;
}
@end
