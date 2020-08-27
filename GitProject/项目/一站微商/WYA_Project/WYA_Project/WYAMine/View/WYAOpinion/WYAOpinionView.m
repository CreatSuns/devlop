//
//  WYAOpinionView.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/9.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAOpinionView.h"

@interface WYAOpinionView ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView * textView;
@property(nonatomic, strong) UILabel * toastLabel;
@property(nonatomic, copy) NSString * textViewOldText;
@end

@implementation WYAOpinionView

-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        self.backgroundColor = [UIColor WYAJHLightGreyColor];
        
        UILabel * title = [[UILabel alloc]init];
        title.text = @"反馈内容";
        title.textColor = [UIColor WYAJHOpinionBlackTextColor];
        title.font = [UIFont systemFontOfSize:14*Size_ratio];
        title.textAlignment = NSTextAlignmentLeft;
        [self addSubview:title];
        
        self.textView = [[UITextView alloc]init];
        self.textView.textContainerInset = UIEdgeInsetsMake(15.f, 15.f, 15.f, 15.f);
        self.textView.text = @"请填写具体内容帮助我们了解你的意见和建议";
        self.textView.textColor = [UIColor WYAJHSegNoSelectColor];
        self.textView.font = [UIFont systemFontOfSize:14*Size_ratio];
        self.textView.delegate = self;
        [self addSubview:self.textView];

        self.toastLabel = [[UILabel alloc]init];
        self.toastLabel.text = @"0/500";
        self.toastLabel.textColor = [UIColor WYAJHOpinionBlackTextColor];
        self.toastLabel.font = [UIFont systemFontOfSize:14*Size_ratio];
        self.toastLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.toastLabel];
        
        UIButton * submitOpinionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [submitOpinionButton setTitle:@"提交意见" forState:UIControlStateNormal];
        [submitOpinionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [submitOpinionButton setBackgroundColor:[UIColor WYAJHBasePurpleColor]];
        [submitOpinionButton addTarget:self action:@selector(submitOpinionClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:submitOpinionButton];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).with.offset(15.f*Size_ratio);
            make.right.mas_equalTo(self.mas_right).with.offset(310.f*Size_ratio);
            make.top.mas_equalTo(self.mas_top).with.offset(10.f*Size_ratio);
        }];
        
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(title.mas_bottom).with.offset(10.f*Size_ratio);
            make.height.mas_equalTo(204.f*Size_ratio);
        }];
        [self.toastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).with.offset(-10.f*Size_ratio);
            make.width.mas_equalTo(100*Size_ratio);
            make.top.mas_equalTo(self.textView.mas_bottom).with.offset(5.f*Size_ratio);
            make.height.mas_equalTo(20.f*Size_ratio);
        }];
        [submitOpinionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).with.offset(37.f*Size_ratio);
            make.right.mas_equalTo(self.mas_right).with.offset(-37.f*Size_ratio);
            make.top.mas_equalTo(self.toastLabel.mas_bottom).with.offset(20.f*Size_ratio);
            make.height.mas_equalTo(@44.f);
        }];
    }
    
    return self;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"请填写具体内容帮助我们了解你的意见和建议"]){
        textView.text=@"";
        textView.textColor=[UIColor blackColor];
    }
}
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length<=500) {
        self.toastLabel.text = [NSString stringWithFormat:@"%lu/500",(unsigned long)textView.text.length];
    }else
    {
        [WYAShowMessageView showToastBWithMessage:@"最多输入500字"];
        self.textView.text = [_textViewOldText substringWithRange:NSMakeRange(0, 500)];
    }
    _textViewOldText = self.textView.text;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length<1) {
        textView.text = @"请填写具体内容帮助我们了解你的意见和建议";
        textView.textColor = [UIColor WYAJHSegNoSelectColor];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
   if ([text isEqualToString:@""]) {
       return YES;
    }
   if (range.location >= 500)
    {
        [WYAShowMessageView showToastBWithMessage:@"最多输入500字"];
        return NO;
    }
    return YES;
}
- (void)submitOpinionClick{
    if (self.submitOpinion) {
        if (self.textView.text.length>=5 && ![self.textView.text isEqualToString:@"请填写具体内容帮助我们了解你的意见和建议"]) {
            self.submitOpinion(self.textView.text);
        }else{
            [WYAShowMessageView showToastBWithMessage:@"内容至少5个字"];
        }

    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
@end
