//
//  WYATestVolimeBottomView.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/20.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//错题解析或全部解析底部视图

#import "WYATestVolimeBottomView.h"
@interface WYATestVolimeBottomView()
@property(nonatomic, strong) UILabel * titleLabel;//试题详解
@property(nonatomic, strong) UIView * titleBackGroundView;//分界线
@property(nonatomic, strong) UILabel * standardLabel;//标准答案
@property(nonatomic, strong) UILabel * parsingLabel;//解析
@property(nonatomic, strong) UILabel * parsingContent;//解析内容
@end
@implementation WYATestVolimeBottomView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _titleBackGroundView = [[UIView alloc]init];
        _titleLabel = [[UILabel alloc]init];
        _standardLabel = [[UILabel alloc]init];
        _parsingLabel = [[UILabel alloc]init];
        _parsingContent = [[UILabel alloc]init];
        
        [self addSubview:_titleBackGroundView];
        [self addSubview:_titleLabel];
        [self addSubview:_standardLabel];
        [self addSubview:_parsingLabel];
        [self addSubview:_parsingContent];
        
    }
    return self;
}
- (void)setModel:(WYACardParsingListModel *)model{
    _model = model;
    _titleBackGroundView.backgroundColor = [UIColor WYAJHLightGreyColor];
    
    _titleLabel.text = @"试题详解";
    _titleLabel.backgroundColor = [UIColor whiteColor];
    _titleLabel.textColor = [UIColor WYAJHBlackTextColor];
    _titleLabel.font = [UIFont systemFontOfSize:14*Size_ratio];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _standardLabel.text = [NSString stringWithFormat:@"答案：%@",_model.stabdardAnswer];
    _standardLabel.textColor = [UIColor WYAJHBlackTextColor];
    _standardLabel.font = [UIFont systemFontOfSize:14*Size_ratio];
    
    _parsingLabel.text = @"解析";
    _parsingLabel.textColor = [UIColor WYAJHBlackTextColor];
    _parsingLabel.font = [UIFont systemFontOfSize:14*Size_ratio];
    
    _parsingContent.text = _model.analysis;
    _parsingContent.numberOfLines = 0;
    _parsingContent.font = [UIFont systemFontOfSize:13*Size_ratio];

    _parsingContent.textColor = [UIColor WYAJHSettingGrayTextColor];
    
    [self layoutIfNeeded];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(150*Size_ratio);
        make.width.mas_equalTo(ScreenWidth-300*Size_ratio);
        make.top.mas_equalTo(0*Size_ratio);
        make.height.mas_equalTo(20*Size_ratio);
    }];
   
    [_titleBackGroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8*Size_ratio);
        make.width.mas_equalTo(ScreenWidth-16*Size_ratio);
        make.top.mas_equalTo(10*Size_ratio);
        make.height.mas_equalTo(0.5);
    }];
    
    [_standardLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(8*Size_ratio);
        make.width.mas_equalTo(ScreenWidth - 16*Size_ratio);
        make.top.equalTo(_titleLabel.mas_bottom).offset(10*Size_ratio);
        make.height.mas_equalTo(20*Size_ratio);
    }];
    
    [_parsingLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(8*Size_ratio);
        make.width.mas_equalTo(ScreenWidth - 16*Size_ratio);
        make.top.equalTo(_standardLabel.mas_bottom).offset(10*Size_ratio);
        make.height.mas_equalTo(20*Size_ratio);
    }];
     CGFloat height = [WYAJHTools heightOfConttent:_model.analysis fontSize:13*Size_ratio maxWidth:ScreenWidth-16*Size_ratio];
    [_parsingContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(8*Size_ratio);
        make.width.mas_equalTo(ScreenWidth - 16*Size_ratio);
        make.top.equalTo(_parsingLabel.mas_bottom).offset(10*Size_ratio);
        make.height.mas_equalTo(height);
    }];
    
}
@end
