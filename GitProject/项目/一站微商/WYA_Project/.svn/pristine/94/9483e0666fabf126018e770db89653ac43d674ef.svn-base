//
//  WYACardReportContentView.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/20.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYACardReportContentView.h"
#import "UIView+WYALayout.h"

#define spacing 15*Size_ratio

@interface WYACardReportContentView()
@property(nonatomic, strong) UILabel * useTimeLabel;//用时多少的label
@property(nonatomic, strong) UILabel * scoreLabel;//分数
@end
@implementation WYACardReportContentView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _useTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, spacing, ScreenWidth, 20*Size_ratio)];
        _scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,_useTimeLabel.cmam_bottom+spacing,ScreenWidth, 20*Size_ratio)];
        
        [self addSubview:_useTimeLabel];
        [self addSubview:_scoreLabel];
    }
    return self;
}
- (void)setScoreStr:(NSString *)scoreStr
{
    _scoreStr = scoreStr;
    _scoreLabel.textColor = [UIColor WYAJHBasePurpleColor];
    _scoreLabel.text = _scoreStr;
    _scoreLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:17*Size_ratio];
    _scoreLabel.textAlignment = NSTextAlignmentCenter;
}
- (void)setUseTimeStr:(NSString *)useTimeStr
{
    _useTimeStr = useTimeStr;
    _useTimeLabel.textColor = [UIColor WYAJHBlackTextColor];
    _useTimeLabel.text = _useTimeStr;
    _useTimeLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:17*Size_ratio];
    _useTimeLabel.textAlignment = NSTextAlignmentCenter;
}

@end
