//
//  WYACardReportBottomView.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/23.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
// 详细答题报告底部错题分析，全部分析的按钮

#import "WYACardReportBottomView.h"
@interface WYACardReportBottomView()
@property(nonatomic, strong) UIButton * wrongTopicBtn;
@property(nonatomic, strong) UIButton * allTopicBtn;
@end
@implementation WYACardReportBottomView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _wrongTopicBtn = [[UIButton alloc]init];
        [_wrongTopicBtn setTitle:@"错题解析" forState:UIControlStateNormal];
        _wrongTopicBtn.titleLabel.font = [UIFont systemFontOfSize:15*Size_ratio];
        [_wrongTopicBtn setTitleColor:[UIColor WYAJHBlackTextColor] forState:UIControlStateNormal];
        _wrongTopicBtn.backgroundColor = [UIColor WYAJHLightGreyColor];
        [_wrongTopicBtn addTarget:self action:@selector(wrongTopicBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        _allTopicBtn = [[UIButton alloc]init];
        [_allTopicBtn setTitle:@"全部解析" forState:UIControlStateNormal];
        _allTopicBtn.titleLabel.font = [UIFont systemFontOfSize:15*Size_ratio];
        [_allTopicBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _allTopicBtn.backgroundColor = [UIColor WYAJHBasePurpleColor];
        [_allTopicBtn addTarget:self action:@selector(allTopicBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_wrongTopicBtn];
        [self addSubview:_allTopicBtn];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_isShowWrongTopicBtn) {
        _wrongTopicBtn.frame = CGRectMake(0, 0, ScreenWidth*0.5, WYATabBarHeight);
        _allTopicBtn.frame = CGRectMake(ScreenWidth*0.5, 0, ScreenWidth*0.5, WYATabBarHeight);
    }
    else{
        _allTopicBtn.frame = CGRectMake(0, 0, ScreenWidth, WYATabBarHeight);
    }

}
- (void)setIsShowWrongTopicBtn:(BOOL)isShowWrongTopicBtn
{
    _isShowWrongTopicBtn = isShowWrongTopicBtn;
    [self layoutIfNeeded];
}
#pragma mark ====== event
- (void)wrongTopicBtnClicked:(UIButton *)sender
{
    [_allTopicBtn setTitleColor:[UIColor WYAJHBlackTextColor] forState:UIControlStateNormal];
    _allTopicBtn.backgroundColor = [UIColor WYAJHLightGreyColor];
    [_wrongTopicBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _wrongTopicBtn.backgroundColor = [UIColor WYAJHBasePurpleColor];
    if (self.delegate && [self.delegate respondsToSelector:@selector(lookWrongTopicPadsing:)]) {
        [self .delegate lookWrongTopicPadsing:sender];
    }
}
- (void)allTopicBtnClicked:(UIButton *)sender
{
    [_wrongTopicBtn setTitleColor:[UIColor WYAJHBlackTextColor] forState:UIControlStateNormal];
    _wrongTopicBtn.backgroundColor = [UIColor WYAJHLightGreyColor];
    [_allTopicBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _allTopicBtn.backgroundColor = [UIColor WYAJHBasePurpleColor];
    if (self.delegate && [self.delegate respondsToSelector:@selector(lookAllTopicPadsing:)]) {
        [self .delegate lookAllTopicPadsing:sender];
    }
}
@end
