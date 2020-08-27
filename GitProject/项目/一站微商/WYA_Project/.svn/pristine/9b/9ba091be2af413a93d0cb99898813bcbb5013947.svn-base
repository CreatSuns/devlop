//
//  WYAAnswerCardCollectionViewCell.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/17.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
// 答题卡 的题号显示

#import "WYAAnswerCardCollectionViewCell.h"

@interface WYAAnswerCardCollectionViewCell()
@end
@implementation WYAAnswerCardCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _cardLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 44.5*Size_ratio, 44.5*Size_ratio)];
        [self addSubview:_cardLabel];
        [self setUI];
    }
    return self;
}
- (void)setUI{
    _cardLabel.layer.cornerRadius = 22.25*Size_ratio;
    _cardLabel.layer.masksToBounds = YES;
    _cardLabel.textAlignment = NSTextAlignmentCenter;
    _cardLabel.font = [UIFont systemFontOfSize:15*Size_ratio];
    _cardLabel.layer.borderColor = [UIColor WYAJHDarkgGreyColor].CGColor;
    _cardLabel.layer.borderWidth = 0.5;
}
@end
