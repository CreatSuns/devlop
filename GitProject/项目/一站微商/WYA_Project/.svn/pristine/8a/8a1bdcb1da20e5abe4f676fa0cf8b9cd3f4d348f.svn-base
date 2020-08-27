//
//  WYALecturerTableViewCell.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/9.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYALecturerTableViewCell.h"
@interface WYALecturerTableViewCell()
@property(nonatomic,strong) UIImageView * teacherIcon;// 讲师头像
@property(nonatomic,strong) UILabel * teacherName;// 讲师姓名
@property(nonatomic, strong) UILabel * titleName;// 讲师职称
@property(nonatomic, strong) UIImageView * titleIcon;//讲师职称图标
@property(nonatomic, strong) UILabel * goodLabel;// 讲师擅长领域
@property(nonatomic, strong) UILabel * attentionNum;// 关注数
@property(nonatomic, strong) UIImageView * redHeart;//关注图标
@end
@implementation WYALecturerTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _teacherIcon = [[UIImageView alloc]init];
        _teacherName = [[UILabel alloc]init];
        _titleIcon = [[UIImageView alloc]init];
        _titleName = [[UILabel alloc]init];
        _goodLabel = [[UILabel alloc]init];
        _attentionNum = [[UILabel alloc]init];
        _redHeart = [[UIImageView alloc]init];
        
        [self addSubview:_teacherIcon];
        [self addSubview:_teacherName];
        [self addSubview:_titleIcon];
        [self addSubview:_titleName];
        [self addSubview:_goodLabel];
        [self addSubview:_redHeart];
        [self addSubview:_attentionNum];
        self.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);

    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_teacherIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(14.f*Size_ratio);
        make.top.equalTo(self.mas_top).offset(12.f*Size_ratio);
        make.width.mas_equalTo(82.f*Size_ratio);
        make.height.mas_equalTo(92.f*Size_ratio);
    }];
    
    [_teacherName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_teacherIcon.mas_right).offset(11.f*Size_ratio);
        make.top.equalTo(self.mas_top).offset(18.f*Size_ratio);
        make.width.mas_equalTo(200.f*Size_ratio);
        make.height.mas_equalTo(15.f*Size_ratio);
    }];
    
    [_titleIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_teacherIcon.mas_right).offset(11.f*Size_ratio);
        make.top.equalTo(_teacherName.mas_bottom).offset(7.f*Size_ratio);
        make.width.mas_equalTo(15.f*Size_ratio);
        make.height.mas_equalTo(15.f*Size_ratio);
    }];
    
    [_titleName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleIcon.mas_right).offset(3.f*Size_ratio);
        make.top.equalTo(_teacherName.mas_bottom).offset(7.f*Size_ratio);
        make.width.mas_equalTo(200.f*Size_ratio);
        make.height.mas_equalTo(20.f*Size_ratio);
    }];
    
    [_goodLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_teacherIcon.mas_right).offset(11.f*Size_ratio);
        make.top.equalTo(_titleIcon.mas_bottom).offset(7.f*Size_ratio);
        make.width.mas_equalTo(200.f*Size_ratio);
        make.height.mas_equalTo(15.f*Size_ratio);
    }];

    
    [_redHeart mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_teacherIcon.mas_right).offset(11.f*Size_ratio);
        make.top.equalTo(_goodLabel.mas_bottom).offset(7.f*Size_ratio);
        make.width.mas_equalTo(13.f*Size_ratio);
        make.height.mas_equalTo(13.f*Size_ratio);
    }];
    
    [_attentionNum mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_redHeart.mas_right).offset(3.f*Size_ratio);
        make.top.equalTo(_goodLabel.mas_bottom).offset(7.f*Size_ratio);
        make.width.mas_equalTo(200.f*Size_ratio);
        make.height.mas_equalTo(15.f*Size_ratio);
    }];

}
- (void)setCellModel:(WYALecturerModel *)cellModel
{
    _cellModel = cellModel;
    _teacherIcon.layer.cornerRadius = 5.f*Size_ratio;
    _teacherIcon.layer.masksToBounds = YES;
    
    NSString * teacherIconUrl = [_cellModel.head_img
                    stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * titleIconUrl = [_cellModel.category_ico stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    
    
    [_teacherIcon sd_setImageWithURL:[NSURL URLWithString:teacherIconUrl] placeholderImage:[UIImage imageNamed:@"placeHoldImage"]];
    
    _titleIcon.contentMode = UIViewContentModeScaleToFill;
    [_titleIcon sd_setImageWithURL:[NSURL URLWithString:titleIconUrl] placeholderImage:[UIImage imageNamed:@"placeHoldImage"]];
    
    _redHeart.image = [UIImage imageNamed:@"我的关注"];
    
    [self creatLabelStyleWithLabel:_teacherName Text:_cellModel.teacher_name color:[UIColor WYAJHBlackTextColor] font:15.f*Size_ratio];
    [self creatLabelStyleWithLabel:_titleName Text:_cellModel.title_name color:[UIColor WYAJHLightBlackTextColor] font:11.f*Size_ratio];
    [self creatLabelStyleWithLabel:_goodLabel Text:_cellModel.good color:[UIColor WYAJHgrayTextColor] font:11.f*Size_ratio];
    
    [self creatLabelStyleWithLabel:_attentionNum Text:[NSString stringWithFormat:@"%@ 人关注",_cellModel.teacher_attention] color:[UIColor WYAJHBaseRedColor] font:11.f*Size_ratio];
    [self layoutIfNeeded];
    
}
- (void)creatLabelStyleWithLabel:(UILabel *)label Text:(NSString *)text color:(UIColor *)textColor font:(CGFloat)font{
    label.text = text;
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:font];
}
@end
