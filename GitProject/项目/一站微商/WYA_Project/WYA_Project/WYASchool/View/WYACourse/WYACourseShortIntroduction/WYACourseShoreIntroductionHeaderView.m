//
//  WYACourseShoreIntroductionHeaderView.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/6/6.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYACourseShoreIntroductionHeaderView.h"

@interface WYACourseShoreIntroductionHeaderView ()
@property (nonatomic, strong) UILabel * titleLabel;// 标题
@property (nonatomic, strong) UILabel * learnPeopleLabel;//学习人数
@property (nonatomic, strong) UIView * lineSectionView;// 高度不为1的View
@property (nonatomic, strong) UILabel * lecturerTitleLabel;// 讲师固定文字
@property (nonatomic, strong) UILabel * lecturerNameLabel;// 讲师名字
@property (nonatomic, strong) UIImageView * lecturerImageView;// 讲师头像
@property (nonatomic, strong) UILabel * lecturerShortIntroductionLabel;//讲师介绍
@property (nonatomic, strong) UIView * lineRowView;//高度为1的View;
@property (nonatomic, strong) UILabel * courseTitleLabel;// 课程介绍Label固定文字

@end
@implementation WYACourseShoreIntroductionHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _titleLabel = [[UILabel alloc]init];
        _learnPeopleLabel = [[UILabel alloc]init];
        _lineSectionView = [[UIView alloc]init];
        _lecturerTitleLabel = [[UILabel alloc]init];
        _lecturerNameLabel = [[UILabel alloc]init];
        _lecturerImageView = [[UIImageView alloc]init];
        _lecturerShortIntroductionLabel = [[UILabel alloc]init];
        _lineRowView = [[UIView alloc]init];
        _courseTitleLabel = [[UILabel alloc]init];

        
        [self addSubview:_titleLabel];
        [self addSubview:_learnPeopleLabel];
        [self addSubview:_lineSectionView];
        [self addSubview:_lecturerTitleLabel];
        [self addSubview:_lecturerNameLabel];
        [self addSubview:_lecturerImageView];
        [self addSubview:_lecturerShortIntroductionLabel];
        [self addSubview:_lineRowView];
        [self addSubview:_courseTitleLabel];

        
    }
    return self;
}
- (void)layoutSubviews
{
    CGFloat X = 8*Size_ratio;
    CGFloat Y = 8*Size_ratio;
    CGFloat margin = 5*Size_ratio;
    CGFloat norWidth = ScreenWidth-2*X;
    CGFloat titleHeight = [WYAJHTools heightOfConttent:checkString(_model.course_title) fontSize:16*Size_ratio maxWidth:norWidth];
    [super layoutSubviews];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(X);
        make.top.equalTo(self.mas_top).offset(Y);
        make.width.mas_equalTo(norWidth);
        make.height.mas_equalTo(titleHeight);
    }];
    
    [_learnPeopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_left);
        make.top.equalTo(_titleLabel.mas_bottom).offset(margin);
        make.width.mas_equalTo(norWidth);
        make.height.mas_equalTo(15*Size_ratio);
    }];
    
    [_lineSectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_left);
        make.top.equalTo(_learnPeopleLabel.mas_bottom).offset(margin);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(3*Size_ratio);
    }];
    
    [_lecturerTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_left);
        make.top.equalTo(_lineSectionView.mas_bottom).offset(margin);
        make.width.mas_equalTo(norWidth);
        make.height.mas_equalTo(15*Size_ratio);
    }];
    
    [_lecturerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_left);
        make.top.equalTo(_lecturerTitleLabel.mas_bottom).offset(10*Size_ratio);
        make.width.mas_equalTo(44*Size_ratio);
        make.height.mas_equalTo(44*Size_ratio);
    }];
    
    [_lecturerNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lecturerImageView.mas_right).offset(10*Size_ratio);
        make.centerY.mas_equalTo(_lecturerImageView.mas_centerY);
        make.width.mas_equalTo(100*Size_ratio);
        make.height.mas_equalTo(15*Size_ratio);
    }];
    
    CGFloat introductionHeight = [WYAJHTools heightOfConttent:checkString(_model.introduction) fontSize:15*Size_ratio maxWidth:295*Size_ratio];
    [_lecturerShortIntroductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lecturerNameLabel.mas_left);
        make.top.equalTo(_lecturerNameLabel.mas_bottom).offset(margin);
        make.width.mas_equalTo(295*Size_ratio);
        make.height.mas_equalTo(introductionHeight);
    }];
    
    [_lineRowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_left);
        make.top.mas_equalTo(_lecturerShortIntroductionLabel.mas_bottom).offset(margin);
        make.width.mas_equalTo(norWidth);
        make.height.mas_equalTo(1);
    }];
    [_courseTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_left);
        make.top.mas_equalTo(_lineRowView.mas_bottom).offset(margin);
        make.width.mas_equalTo(norWidth);
        make.height.mas_equalTo(20*Size_ratio);
    }];
}
- (void)setModel:(CourseInfo *)model
{
    if (model) {
        _model = model;
        _titleLabel.text = checkString(_model.course_title);
        _titleLabel.textColor = [UIColor WYAJHBlackTextColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:16.f*Size_ratio];
        
        _learnPeopleLabel.text = [NSString stringWithFormat:@"%@人学过",checkString(_model.learned)];
        _learnPeopleLabel.textColor = [UIColor WYAJHSegNoSelectColor];
        _learnPeopleLabel.textAlignment = NSTextAlignmentLeft;
        _learnPeopleLabel.font = [UIFont systemFontOfSize:14.f*Size_ratio];
        
        _lineSectionView.backgroundColor = [UIColor WYAJHLightGreyColor];
        
        _lecturerTitleLabel.textColor = [UIColor WYAJHBlackTextColor];
        _lecturerTitleLabel.textAlignment = NSTextAlignmentLeft;
        _lecturerTitleLabel.font = [UIFont systemFontOfSize:15.f*Size_ratio];
        _lecturerTitleLabel.text = @"讲师";
        
        [_lecturerImageView sd_setImageWithURL:[NSURL URLWithString:[checkString(_model.teacher_img) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@""]];
        _lecturerImageView.contentMode = UIViewContentModeScaleAspectFill;
        _lecturerImageView.layer.cornerRadius = 22*Size_ratio;
        _lecturerImageView.layer.masksToBounds = YES;
        
        _lecturerNameLabel.text = checkString(_model.teacher_name);
        _lecturerNameLabel.textColor = [UIColor WYAJHBlackTextColor];
        _lecturerNameLabel.textAlignment = NSTextAlignmentLeft;
        _lecturerNameLabel.font = [UIFont systemFontOfSize:16.f*Size_ratio];
        
        _lecturerShortIntroductionLabel.text = checkString(_model.introduction);
        _lecturerShortIntroductionLabel.textColor = [UIColor WYAJHSegNoSelectColor];
        _lecturerShortIntroductionLabel.font = [UIFont systemFontOfSize:15.f*Size_ratio];
        _lecturerShortIntroductionLabel.numberOfLines = 0;
        
        _lineRowView.backgroundColor = [UIColor WYAJHLightGreyColor];
        
        _courseTitleLabel.textColor = [UIColor WYAJHBlackTextColor];
        _courseTitleLabel.textAlignment = NSTextAlignmentLeft;
        _courseTitleLabel.font = [UIFont systemFontOfSize:15.f*Size_ratio];
        _courseTitleLabel.text = @"课程介绍";
        [self layoutIfNeeded];
    }
}

@end
