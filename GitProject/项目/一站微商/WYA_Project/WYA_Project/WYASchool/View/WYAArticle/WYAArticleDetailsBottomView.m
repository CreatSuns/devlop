//
//  WYAArticleDetailsBottomView.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/26.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAArticleDetailsBottomView.h"
@interface WYAArticleDetailsBottomView()
@property(nonatomic, strong) UIImageView * thumImg;
@property(nonatomic, strong) UILabel * thumLabel;
@property(nonatomic, strong) UIButton * thumbBtn;// 点赞

@property(nonatomic, strong) UIImageView * collectionImg;
@property(nonatomic, strong) UILabel * collectionLabel;
@property(nonatomic, strong) UIButton * collectionBtn;//收藏

@property(nonatomic, strong) UIImageView * focusImg;
@property(nonatomic, strong) UILabel * focusLabel;
@property(nonatomic, strong) UIButton * focusBtn;// 关注

@property(nonatomic, strong) UIView * marginLineView;
@property(nonatomic, strong) UIView * lineView;
@end
@implementation WYAArticleDetailsBottomView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _focusImg = [[UIImageView alloc]init];
        _focusLabel = [[UILabel alloc]init];
        _focusBtn = [[UIButton alloc]init];
        [_focusBtn addSubview:_focusImg];
        [_focusBtn addSubview:_focusLabel];
        [self addSubview:_focusBtn];
        
        _marginLineView = [[UIView alloc]init];
        [self addSubview:_marginLineView];
        
        
        _thumImg = [[UIImageView alloc]init];
        _thumLabel = [[UILabel alloc]init];
        _thumbBtn = [[UIButton alloc]init];
        [_thumbBtn addSubview:_thumImg];
        [_thumbBtn addSubview:_thumLabel];
        [self addSubview:_thumbBtn];
        
        _lineView = [[UIView alloc]init];
        [self addSubview:_lineView];
        
        _collectionImg = [[UIImageView alloc]init];
        _collectionLabel = [[UILabel alloc]init];
        _collectionBtn = [[UIButton alloc]init];
        [_collectionBtn addSubview:_collectionImg];
        [_collectionBtn addSubview:_collectionLabel];
        [self addSubview:_collectionBtn];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_focusBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo((ScreenWidth-2)/3);
        make.height.mas_equalTo(WYATabBarHeight);
    }];
    [_focusImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_focusBtn.mas_centerX);
        make.top.equalTo(_focusBtn.mas_top).offset(10*Size_ratio);
        make.height.mas_equalTo(29*Size_ratio);
        make.width.mas_equalTo(29*Size_ratio);
    }];
    [_focusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_focusImg.mas_right).offset(3*Size_ratio);
        make.top.equalTo(_focusBtn.mas_top).offset(10*Size_ratio);
        make.height.mas_equalTo(29*Size_ratio);
        make.width.mas_equalTo(100*Size_ratio);
    }];
    
    [_marginLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10*Size_ratio);
        make.left.mas_equalTo(_focusBtn.mas_right);
        make.height.mas_equalTo(29*Size_ratio);
        make.width.mas_equalTo(1);
    }];
    
    [_thumbBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_focusBtn.mas_right).offset(1);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo((ScreenWidth-2)/3);
        make.height.mas_equalTo(WYATabBarHeight);
    }];
    [_thumImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_thumbBtn.mas_centerX);
        make.top.equalTo(_thumbBtn.mas_top).offset(10*Size_ratio);
        make.height.mas_equalTo(29*Size_ratio);
        make.width.mas_equalTo(29*Size_ratio);
    }];
    [_thumLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_thumImg.mas_right).offset(3*Size_ratio);
        make.top.equalTo(_thumbBtn.mas_top).offset(10*Size_ratio);
        make.height.mas_equalTo(29*Size_ratio);
        make.width.mas_equalTo(100*Size_ratio);
    }];
    
    [_lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10*Size_ratio);
        make.left.mas_equalTo(_thumbBtn.mas_right);
        make.height.mas_equalTo(29*Size_ratio);
        make.width.mas_equalTo(1);
    }];
    [_collectionBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_thumbBtn.mas_right).offset(1);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo((ScreenWidth-2)/3);
        make.height.mas_equalTo(WYATabBarHeight);
    }];
    [_collectionImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_collectionBtn.mas_centerX);
        make.top.equalTo(_collectionBtn.mas_top).offset(10*Size_ratio);
        make.height.mas_equalTo(29*Size_ratio);
        make.width.mas_equalTo(29*Size_ratio);
    }];
    [_collectionLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_collectionImg.mas_right).offset(3*Size_ratio);
        make.top.equalTo(_collectionBtn.mas_top).offset(10*Size_ratio);
        make.height.mas_equalTo(29*Size_ratio);
        make.width.mas_equalTo(100*Size_ratio);
    }];
}
#pragma mark ====== createUI
- (void)setModel:(WYAArticleDetailModel *)model
{
    _model = model;
    if ([_model.is_attention intValue] == 0) {
        _focusImg.image = [UIImage imageNamed:@"我的关注-1"];
    }else
    {
        _focusImg.image = [UIImage imageNamed:@"文章详情关注"];
    }
    if ([_model.is_thumb intValue] == 0) {
        _thumImg.image = [UIImage imageNamed:@"文章详情点赞"];
    }else
    {
        _thumImg.image = [UIImage imageNamed:@"点赞已选"];
    }
    if ([_model.is_collection intValue] == 0) {
        _collectionImg.image = [UIImage imageNamed:@"文章详情收藏"];
    }else
    {
        _collectionImg.image = [UIImage imageNamed:@"文章详情已收藏"];
    }
    
    _focusLabel.text = @"关注";
    _focusLabel.textColor = [UIColor WYAJHBlackTextColor];
    _focusLabel.font = [UIFont systemFontOfSize:14*Size_ratio];
    [_focusBtn addTarget:self action:@selector(focusBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _marginLineView.backgroundColor = [UIColor WYAJHLightGreyColor];
    
//    _thumImg.image = [UIImage imageNamed:@"点赞"];
    _thumLabel.text = @"点赞";
    _thumLabel.textColor = [UIColor WYAJHBlackTextColor];
    _thumLabel.font = [UIFont systemFontOfSize:14*Size_ratio];
    [_thumbBtn addTarget:self action:@selector(thumBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    _lineView.backgroundColor = [UIColor WYAJHLightGreyColor];
    
//    _collectionImg.image = [UIImage imageNamed:@"收藏"];
    _collectionLabel.text = @"收藏";
    _collectionLabel.textColor = [UIColor WYAJHBlackTextColor];
    _collectionLabel.font = [UIFont systemFontOfSize:14*Size_ratio];
    [_collectionBtn addTarget:self action:@selector(collectionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    [self layoutIfNeeded];
}
#pragma mark ====== event
- (void)focusBtnClicked:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(bottomViewFocusSelected:)]) {
        [self.delegate bottomViewFocusSelected:_focusImg];
    }
}
- (void)thumBtnClicked:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(bottomViewThumSelected:)]) {
        [self.delegate bottomViewThumSelected:_thumImg];
    }
}
- (void)collectionBtnClicked:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(bottomViewCollectionSelected:)]) {
        [self.delegate bottomViewCollectionSelected:_collectionImg];
    }
}
@end
