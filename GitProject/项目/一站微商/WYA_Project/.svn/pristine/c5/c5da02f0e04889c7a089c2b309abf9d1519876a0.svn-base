//
//  WYALecturerHeaderView.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/10.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYALecturerHeaderView.h"
#import "UILabel+WYALabelAlighTop.h"


@interface WYALecturerHeaderView ()
@property(nonatomic, strong) UIImageView * headerBackGroundImageView;// 背景大图

@property(nonatomic, strong) UIImageView * lecturerIcon;// 讲师头像
@property(nonatomic, strong) UILabel * lecturerName;// 讲师姓名

@property(nonatomic, strong) UIButton * focusOnBtn;//关注按钮

@property(nonatomic, strong) UILabel * focusNum;// 关注人数
@property(nonatomic, strong) UILabel * focusLabel;//关注

@property(nonatomic, strong) UIView * verticalBarOne;// 竖直分界线

@property(nonatomic, strong) UILabel * courseNum;// 课程数
@property(nonatomic, strong) UILabel * courseLabel;

@property(nonatomic, strong) UIView * verticalBarTwo;// 竖直分界线

@property(nonatomic, strong) UILabel * articleNum;
@property(nonatomic, strong) UILabel * articleLabel;

@property(nonatomic, strong) UIImageView * titleIcon;// 讲师职称图标
@property(nonatomic, strong) UILabel * titleName;// 讲师职称介绍
@property(nonatomic, strong) UILabel * introduction;//讲师简介

@property(nonatomic, strong) UIView * lineView;
@end
@implementation WYALecturerHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _headerBackGroundImageView = [[UIImageView alloc]init];
        
        _lecturerIcon = [[UIImageView alloc]init];
        _lecturerName = [[UILabel alloc]init];
        
        _focusOnBtn = [[UIButton alloc]init];
        
        _focusNum = [[UILabel alloc]init];
        _focusLabel = [[UILabel alloc]init];
        
        _verticalBarOne = [[UIView alloc]init];
        
        _courseNum = [[UILabel alloc]init];
        _courseLabel = [[UILabel alloc]init];
        
        _verticalBarTwo = [[UIView alloc]init];
        
        _articleNum = [[UILabel alloc]init];
        _articleLabel = [[UILabel alloc]init];
        
        _titleIcon = [[UIImageView alloc]init];
        _titleName = [[UILabel alloc]init];
        _introduction = [[UILabel alloc]init];
        
        _lineView = [[UIView alloc]init];
        
        
        
        NSArray * childViewArray = @[_headerBackGroundImageView,_lecturerIcon,_lecturerName,
                                 _focusOnBtn, _focusNum,_focusLabel,_verticalBarOne,_courseNum,
                                 _courseLabel,_verticalBarTwo,_articleNum,_articleLabel,
                                 _titleIcon,_titleName,_introduction,_lineView];
        for (UIView * childView in childViewArray) {
            [self addSubview:childView];
        }
        
//        [self setUI];
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_headerBackGroundImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.top.equalTo(self.mas_top).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(Size_ratio*230.f);
    }];
    [_lecturerIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerBackGroundImageView.mas_top).offset(Size_ratio*51.f);
        make.centerX.mas_equalTo(_headerBackGroundImageView.mas_centerX);
        make.width.mas_equalTo(Size_ratio*66.f);
        make.height.mas_equalTo(Size_ratio*66.f);
    }];
    [_lecturerName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lecturerIcon.mas_bottom).offset(Size_ratio*4.f);
        make.left.equalTo(_headerBackGroundImageView.mas_left).offset(0);
        make.right.equalTo(_headerBackGroundImageView.mas_right).offset(0);
        make.height.mas_equalTo(Size_ratio*15.f);
    }];
    [_focusOnBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_headerBackGroundImageView.mas_centerX);
        make.top.equalTo(_lecturerName.mas_bottom).offset(Size_ratio*13.f);
        make.width.mas_equalTo(Size_ratio*65);
        make.height.mas_equalTo(Size_ratio*25);
    }];
    
    [_focusNum mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headerBackGroundImageView.mas_left).offset(Size_ratio*91.f);
        make.top.equalTo(_focusOnBtn.mas_bottom).offset(Size_ratio*8.f);
        make.width.mas_equalTo(Size_ratio*60.f);
        make.height.mas_equalTo(Size_ratio*15.f);
    }];
    
    [_focusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_focusNum.mas_centerX);
        make.top.equalTo(_focusNum.mas_bottom).offset(Size_ratio*2.f);
        make.width.mas_equalTo(Size_ratio*60.f);
        make.height.mas_equalTo(Size_ratio*15.f);
    }];
    
    [_verticalBarOne mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_focusOnBtn.mas_left).offset(Size_ratio*(-5.f));
        make.top.equalTo(_focusOnBtn.mas_bottom).offset(Size_ratio*8.f);
        make.width.mas_equalTo(1.f);
        make.height.mas_equalTo(Size_ratio*24.f);
    }];
    
    [_courseNum mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_focusOnBtn.mas_bottom).offset(Size_ratio*8.f);
        make.centerX.mas_equalTo(_headerBackGroundImageView.mas_centerX);
        make.width.mas_equalTo(Size_ratio*60.f);
        make.height.mas_equalTo(Size_ratio*15.f);
    }];
    [_courseLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_courseNum.mas_bottom).offset(Size_ratio*2.f);
        make.centerX.mas_equalTo(_headerBackGroundImageView.mas_centerX);
        make.width.mas_equalTo(Size_ratio*60.f);
        make.height.mas_equalTo(Size_ratio*15.f);
    }];
    
    [_verticalBarTwo mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_focusOnBtn.mas_right).offset(Size_ratio*5.f);
        make.top.equalTo(_focusOnBtn.mas_bottom).offset(Size_ratio*8.f);
        make.width.mas_equalTo(1.f);
        make.height.mas_equalTo(Size_ratio*24.f);
    }];
    
    [_articleNum mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_headerBackGroundImageView.mas_right).offset(-91.f*Size_ratio);
        make.top.equalTo(_focusOnBtn.mas_bottom).offset(Size_ratio*8.f);
        make.width.mas_equalTo(Size_ratio*60.f);
        make.height.mas_equalTo(Size_ratio*15.f);
    }];
    
    [_articleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_articleNum.mas_centerX);
        make.top.equalTo(_articleNum.mas_bottom).offset(Size_ratio*2.f);
        make.width.mas_equalTo(Size_ratio*60.f);
        make.height.mas_equalTo(Size_ratio*15.f);
    }];
    
    [_titleIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(140.f*Size_ratio);
        make.top.equalTo(_headerBackGroundImageView.mas_bottom).offset(12.f*Size_ratio);
        make.width.mas_equalTo(25*Size_ratio);
        make.height.mas_equalTo(25*Size_ratio);
    }];
    
    [_titleName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleIcon.mas_right).offset(5.f*Size_ratio);
        make.top.equalTo(_headerBackGroundImageView.mas_bottom).offset(Size_ratio*19.f);
        make.right.equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(Size_ratio*15.f);
    }];
    _titleName.textAlignment = NSTextAlignmentLeft;
    
    [_introduction mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10.f*Size_ratio);
        make.left.equalTo(self.mas_left).offset(Size_ratio*10.f);
        make.top.equalTo(_titleName.mas_bottom).offset(Size_ratio*6.f);
        make.bottom.equalTo(self.mas_bottom).offset(-5.f*Size_ratio);
    }];
    [_lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(0.f);
        make.left.equalTo(self.mas_left).offset(0.f);
        make.bottom.equalTo(self.mas_bottom).offset(-1.f);
        make.height.mas_equalTo(1.f);
    }];
}
#pragma mark ====== childViewArray UI setter
- (void)setModel:(WYALecturerHeaderModel *)model{
    _model = model;
    _headerBackGroundImageView.image = [UIImage imageNamed:@"讲师详情.png"];
    NSString * titleIconUrl = _model.category_ico;
      [_titleIcon sd_setImageWithURL:[NSURL URLWithString:titleIconUrl] placeholderImage:[UIImage imageNamed:@"placeHoldImage"]];
    
    [_lecturerIcon sd_setImageWithURL:[NSURL URLWithString:_model.head_img] placeholderImage:nil];
    _lecturerIcon.layer.cornerRadius = Size_ratio*33.f;
    _lecturerIcon.layer.masksToBounds = YES;
    [self setLabel:_lecturerName text:_model.teacher_name textColor:[UIColor whiteColor] font:Size_ratio*15.f];

    _focusOnBtn.backgroundColor = [UIColor WYAFocusBackGroundColor];
    if ([_model.is_attention integerValue]==1) {
        [_focusOnBtn setTitle:@"已关注" forState:UIControlStateNormal];
    }else
    {
        [_focusOnBtn setTitle:@"关注" forState:UIControlStateNormal];
    }
    [_focusOnBtn setTitleColor:[UIColor colorWithHexString:@"#FFE5A6"] forState:UIControlStateNormal];
    [_focusOnBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [_focusOnBtn addTarget:self action:@selector(focusOnBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _focusOnBtn.layer.cornerRadius = Size_ratio*12.f;
    _focusOnBtn.layer.masksToBounds = YES;
    _focusOnBtn.titleLabel.font = [UIFont systemFontOfSize:Size_ratio*14.f];
    
    [self setLabel:_focusNum text:_model.teacher_attention textColor:[UIColor whiteColor] font:Size_ratio*14.f];
    [self setLabel:_focusLabel text:@"关注" textColor:[UIColor whiteColor] font:Size_ratio*14.f];

    _verticalBarOne.backgroundColor = [UIColor whiteColor];
    
    [self setLabel:_courseNum text:_model.count_course textColor:[UIColor whiteColor] font:Size_ratio*14.f];
    [self setLabel:_courseLabel text:@"课程" textColor:[UIColor whiteColor] font:Size_ratio*14.f];
    
    _verticalBarTwo.backgroundColor = [UIColor whiteColor];
    
    [self setLabel:_articleNum text:_model.count_article textColor:[UIColor whiteColor] font:Size_ratio*14.f];
    [self setLabel:_articleLabel text:@"文章" textColor:[UIColor whiteColor] font:Size_ratio*14.f];

    [self setLabel:_titleName text:_model.title_name textColor:[UIColor WYAJHBlackTextColor] font:Size_ratio*16.f];
    
    [self setLabel:_introduction text:_model.introduction textColor:[UIColor WYAJHgrayTextColor] font:Size_ratio*13.f];
    _introduction.numberOfLines = 0;
    _introduction.adjustsFontSizeToFitWidth = YES;
    _lineView.backgroundColor = [UIColor WYAJHLightGreyColor];
//    [_introduction alignTop];
    
    [self layoutIfNeeded];
    
}
- (void)setLabel:(UILabel *)label text:(NSString *)text textColor:(UIColor *)color font:(CGFloat)font {
    label.text = text;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:font];
    label.textAlignment = NSTextAlignmentCenter;
}

#pragma mark ====== event
- (void)focusOnBtnClicked:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(attentionButtonClicked:)]) {
        [self.delegate attentionButtonClicked:sender];
    }
}

@end
