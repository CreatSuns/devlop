//
//  WYAMineTableViewCell.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/8.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMineTableViewCell.h"
@interface WYAMineTableViewCell()
@property(nonatomic, strong) UIImageView * mineIconImg;
@property(nonatomic, strong) UILabel * mineTitleLabel;
@property(nonatomic, strong) UIButton * arrowBtn;
@property(nonatomic, strong) UIView * lineView;
@end
@implementation WYAMineTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _mineIconImg = [[UIImageView alloc]init];
        _mineTitleLabel = [[UILabel alloc]init];
        _arrowBtn = [[UIButton alloc]init];
        _lineView = [[UIView alloc]init];
        
        [self addSubview:_mineIconImg];
        [self addSubview:_mineTitleLabel];
        [self addSubview:_arrowBtn];
        [self addSubview:_lineView];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_mineIconImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15.f);
//        make.top.equalTo(self.mas_top).offset(12.f);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(19*Size_ratio);
        make.height.mas_equalTo(19*Size_ratio);
    }];
    
    [_mineTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mineIconImg.mas_right).offset(10.f);
//        make.top.equalTo(self.mas_top).offset(15.f);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(100.f);
        make.height.mas_equalTo(14.f);
    }];
    
    [_arrowBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-9.f);
//        make.top.equalTo(self.mas_top).offset(13.f);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(15*Size_ratio);
        make.height.mas_equalTo(15*Size_ratio);
    }];
    
    [_lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10.f);
        make.bottom.equalTo(self.mas_bottom).offset(-1.f);
        make.right.equalTo(self.mas_right).offset(0.f);
        make.height.mas_equalTo(1.f);
    }];
}
- (void)setCellModel:(WYAMineCellModel *)cellModel{
    _mineIconImg.image = [UIImage imageNamed:cellModel.iconImgNamed];
    _mineTitleLabel.text = cellModel.titleText;
    _mineTitleLabel.font = [UIFont systemFontOfSize:14*Size_ratio];
    [_arrowBtn setImage:[UIImage imageNamed:cellModel.arrowBtnImgNamed] forState:UIControlStateNormal];
    _lineView.backgroundColor = [UIColor WYAJHLightGreyColor];
    if ([cellModel.titleText isEqualToString:@"我的关注"]||[cellModel.titleText isEqualToString:@"意见反馈"]||[cellModel.titleText isEqualToString:@"设置"]) {
        _lineView.hidden = YES;
    }else
    {
        _lineView.hidden = NO;
    }
    [self layoutIfNeeded];
}

@end
