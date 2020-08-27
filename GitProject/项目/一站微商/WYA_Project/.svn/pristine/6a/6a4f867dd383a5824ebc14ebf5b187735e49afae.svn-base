//
//  WYAShowMessageView.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/8.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAShowMessageView.h"

@implementation WYAShowMessageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (void)showToastAWithMessage:(NSString *)message{
    UILabel * label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:15*Size_ratio];
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 20*Size_ratio;
    label.layer.masksToBounds = YES;
//    label.adjustsFontSizeToFitWidth = YES;
    [Window addSubview:label];
    CGFloat width = [UILabel getWidthWithTitle:message font:label.font];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(Window.mas_centerX);
        make.bottom.mas_equalTo(Window.mas_bottom).with.offset(-50*Size_ratio);
        make.width.mas_equalTo(width+30*Size_ratio);
        make.height.mas_equalTo(50*Size_ratio);
    }];
    
    [UIView animateWithDuration:1.5 animations:^{
        label.alpha = 0;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
}

+ (void)showToastBWithMessage:(NSString *)message{
    UILabel * label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:15*Size_ratio];
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 20*Size_ratio;
    label.layer.masksToBounds = YES;
//    label.adjustsFontSizeToFitWidth = YES;
    [Window addSubview:label];
    CGFloat width = [UILabel getWidthWithTitle:message font:label.font];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(Window.mas_centerX);
        make.centerY.mas_equalTo(Window.mas_centerY);
        make.width.mas_equalTo(width+30);
        make.height.mas_equalTo(50*Size_ratio);
    }];
    
    [UIView animateWithDuration:1.5 animations:^{
        label.alpha = 0;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
}

@end
