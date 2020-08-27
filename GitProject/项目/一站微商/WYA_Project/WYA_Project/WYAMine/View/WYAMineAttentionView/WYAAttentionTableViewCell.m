//
//  WYAAttentionTableViewCell.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/12.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAAttentionTableViewCell.h"
@interface WYAAttentionTableViewCell()
@property(nonatomic, strong) UIView * bgView;
@property(nonatomic, strong) UIImageView * userIconImage;
@property(nonatomic, strong) UILabel * userNameLabel;
@property(nonatomic, strong) UILabel * titleNameLabel;
@property(nonatomic, strong) UIImageView * titleIconImag;
@end
@implementation WYAAttentionTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _bgView = [[UIView alloc]init];
        _userIconImage = [[UIImageView alloc]init];
        _userNameLabel = [[UILabel alloc]init];
        _titleIconImag = [[UIImageView alloc]init];
        _titleNameLabel = [[UILabel alloc]init];
        _attentionBtn = [[UIButton alloc]init];
        
        [_bgView addSubview:_userIconImage];
        [_bgView addSubview:_userNameLabel];
        [_bgView addSubview:_titleIconImag];
        [_bgView addSubview:_titleNameLabel];
        [_bgView addSubview:_attentionBtn];
        [self addSubview:_bgView];
        self.backgroundColor = [UIColor WYAJHLightGreyColor];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10.f*Size_ratio);
        make.right.equalTo(self.mas_right).offset(-10.f*Size_ratio);
        make.top.equalTo(self.mas_top).offset(5.f*Size_ratio);
        make.bottom.equalTo(self.mas_bottom).offset(0);
    }];
    
    [_userIconImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView.mas_left).offset(13.f*Size_ratio);
        make.top.equalTo(_bgView.mas_top).offset(13.f*Size_ratio);
        make.width.mas_equalTo(44*Size_ratio);
        make.height.mas_equalTo(44*Size_ratio);
    }];
    
    [_userNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userIconImage.mas_right).offset(8.f*Size_ratio);
        make.top.equalTo(_bgView.mas_top).offset(18.f*Size_ratio);
        make.width.mas_equalTo(200.f*Size_ratio);
        make.height.mas_equalTo(15.f*Size_ratio);
    }];
    
    [_titleIconImag mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userIconImage.mas_right).offset(8.f*Size_ratio);
        make.top.equalTo(_userNameLabel.mas_bottom).offset(6.f*Size_ratio);
        make.width.mas_equalTo(12.f*Size_ratio);
        make.height.mas_equalTo(12.f*Size_ratio);
    }];
    
    [_titleNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleIconImag.mas_right).offset(2.f*Size_ratio);
        make.top.equalTo(_userNameLabel.mas_bottom).offset(6.f*Size_ratio);
        make.width.mas_equalTo(200.f*Size_ratio);
        make.height.mas_equalTo(15.f*Size_ratio);
    }];
    
    [_attentionBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bgView.mas_right).offset(-10.f*Size_ratio);
        make.top.equalTo(_bgView.mas_top).offset(20.f*Size_ratio);
        make.bottom.equalTo(_bgView.mas_bottom).offset(-20.f*Size_ratio);
        make.width.mas_equalTo(80.f*Size_ratio);
    }];
}
- (void)setModel:(WYAAttentionModel *)model
{
    _model = model;
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = 8.f*Size_ratio;
    _bgView.layer.masksToBounds = YES;
    
    [_userIconImage sd_setImageWithURL:[NSURL URLWithString:_model.head_img] placeholderImage:nil];
    _userIconImage.layer.cornerRadius = 22.f*Size_ratio;
    _userIconImage.layer.masksToBounds = YES;
    
    _userNameLabel.text = _model.teacher_name;
    _userNameLabel.textColor = [UIColor WYAJHBlackTextColor];
    _userNameLabel.font = [UIFont systemFontOfSize:15.f*Size_ratio];
    
    _titleNameLabel.text = _model.category_name;
    _titleNameLabel.textColor = [UIColor WYAJHBlackTextColor];
    _titleNameLabel.font = [UIFont systemFontOfSize:11.f*Size_ratio];
    [_attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
    _attentionBtn.backgroundColor = [UIColor WYAJHBasePurpleColor];
    [_attentionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _attentionBtn.titleLabel.font = [UIFont systemFontOfSize:13.f*Size_ratio];
    _attentionBtn.layer.cornerRadius = 10*Size_ratio;
    _attentionBtn.layer.masksToBounds = YES;
    [_attentionBtn addTarget:self action:@selector(attenTionClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self layoutIfNeeded];
}
#pragma mark ====== event
- (void)attenTionClicked:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(attentionButtonClicked:)]) {
        [self.delegate attentionButtonClicked:self];
    }
}
@end
