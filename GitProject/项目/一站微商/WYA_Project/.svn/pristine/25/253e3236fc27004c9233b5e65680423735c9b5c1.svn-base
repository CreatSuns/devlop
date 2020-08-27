//
//  WYAAnswerCardHeaderView.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/17.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
// 答题卡的分组显示

#import "WYAAnswerCardHeaderView.h"

@implementation WYAAnswerCardHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 36*Size_ratio)];
        [self addSubview:_headerLabel];
        [self setUI];
    }
    return self;
}
- (void)setUI{
    _headerLabel.textColor = [UIColor WYAJHBlackTextColor];
    _headerLabel.backgroundColor = [UIColor WYAJHLightGreyColor];
    _headerLabel.font = [UIFont systemFontOfSize:14*Size_ratio];
    
}

@end
