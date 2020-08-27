//
//  WYATestCaseHeaderView.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/19.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
// 案例分析题的header

#import "WYATestCaseHeaderView.h"
#import "UIView+WYALayout.h"
@interface WYATestCaseHeaderView()
@property(nonatomic, strong) UILabel * contentLabel;
@end
@implementation WYATestCaseHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(5*Size_ratio, 5*Size_ratio, ScreenWidth-10*Size_ratio, self.cmam_height-10*Size_ratio)];
        _contentLabel.textColor = [UIColor WYAJHBlackTextColor];
        _contentLabel.font = [UIFont systemFontOfSize:14.f*Size_ratio];
        _contentLabel.numberOfLines = 0;


        [self addSubview:_contentLabel];
    }
    return self;
}
- (void)setContent:(NSString *)content{
    _content = content;
    _contentLabel.attributedText = [WYAJHTools AttribytedStringWithstr:content changeStr:@"【案例分析题】"];
    _contentLabel.attributedText = [WYAJHTools AttribytedStringWithstr:content changeStr:@"【案例分析题】"];

}
@end
