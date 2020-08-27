//
//  WYAMineHeaderView.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/8.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMineHeaderView.h"
@interface WYAMineHeaderView ()
@property(nonatomic, strong) UIImageView * userBackGroundImg;   // 背景图片
@property(nonatomic, strong) UIButton * userIconImg;            // 用户头像
@property(nonatomic, strong) UILabel * userNameLabel;           // 用户名
@property(nonatomic, strong) UILabel * learTime;                // 用户学习时长
@property(nonatomic, strong) UIImageView * classTable;             // 课表
@property(nonatomic, strong) UIButton * classBtn;
@property(nonatomic, strong) UILabel * classLabel;
@property(nonatomic, strong) UIImageView * testScores;             // 测试成绩
@property(nonatomic, strong) UIButton * testBtn;
@property(nonatomic, strong) UILabel * testLabel;
@property(nonatomic, strong) UIImageView * courseNew;              // 新课上架
@property(nonatomic, strong) UIButton * courseBtn;
@property(nonatomic, strong) UILabel * courseLabel;
@property(nonatomic, strong) UIImageView * userIconButtonImg;
@end

@implementation WYAMineHeaderView
#pragma mark ======
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _userBackGroundImg = [[UIImageView alloc]init];
        _userIconImg = [[UIButton alloc]init];
        _userNameLabel = [[UILabel alloc]init];
        _learTime = [[UILabel alloc]init];
        _classTable = [[UIImageView alloc]init];
        _testScores = [[UIImageView alloc]init];
        _courseNew = [[UIImageView alloc]init];
        _classLabel = [[UILabel alloc]init];
        _testLabel = [[UILabel alloc]init];
        _courseLabel = [[UILabel alloc]init];
        _classBtn = [[UIButton alloc]init];
        _testBtn = [[UIButton alloc]init];
        _courseBtn = [[UIButton alloc]init];
        _userIconButtonImg = [[UIImageView alloc]init];
        
        [_userIconImg addSubview:_userIconButtonImg];
        [self addSubview:_userBackGroundImg];
        [self addSubview:_userIconImg];
        [self addSubview:_userNameLabel];
        [self addSubview:_learTime];
        [_classTable addSubview:_classLabel];
        [self addSubview:_classTable];
        [_testScores addSubview:_testLabel];
        [self addSubview:_testScores];
        [_courseNew addSubview:_courseLabel];
        [self addSubview:_courseNew];
        [self addSubview:_classBtn];
        [self addSubview:_testBtn];
        [self addSubview:_courseBtn];
        
        [self setCustomViewUI];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_userBackGroundImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.top.equalTo(self.mas_top).offset(0);
        make.height.mas_equalTo(135.f*Size_ratio+RectStatus.size.height);
    }];
    
    [_userIconImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.equalTo(_userBackGroundImg.mas_bottom).offset(-44.f*Size_ratio);
        make.width.mas_equalTo(70*Size_ratio);
        make.height.mas_equalTo(70*Size_ratio);
    }];
    [_userIconButtonImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.equalTo(_userBackGroundImg.mas_bottom).offset(-44.f*Size_ratio);
        make.width.mas_equalTo(70*Size_ratio);
        make.height.mas_equalTo(70*Size_ratio);
    }];
    
    [_userNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.equalTo(_userIconImg.mas_bottom).offset(9.f*Size_ratio);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(15.f*Size_ratio);
    }];
    
    [_learTime mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.equalTo(_userNameLabel.mas_bottom).offset(11.f*Size_ratio);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(13*Size_ratio);
    }];
    
    [_classTable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(44.f*Size_ratio);
        make.top.equalTo(_learTime.mas_bottom).offset(20.f*Size_ratio);
        make.height.mas_equalTo(22.f*Size_ratio);
        make.width.mas_equalTo(22.f*Size_ratio);
    }];
    
    [_classLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_classTable.mas_centerX);
        make.top.equalTo(_classTable.mas_bottom).offset(8.f*Size_ratio);
        make.height.mas_equalTo(15.f*Size_ratio);
        make.width.mas_equalTo(80.f*Size_ratio);
    }];
    [_classBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(44.f*Size_ratio);
        make.top.equalTo(_learTime.mas_bottom).offset(20.f*Size_ratio);
        make.height.mas_equalTo(45.f*Size_ratio);
        make.width.mas_equalTo(45.f*Size_ratio);
    }];
    
    [_testScores mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.equalTo(_learTime.mas_bottom).offset(20.f*Size_ratio);
        make.height.mas_equalTo(22*Size_ratio);
        make.width.mas_equalTo(22*Size_ratio);
    }];
    [_testLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.equalTo(_testScores.mas_bottom).offset(8.f*Size_ratio);
        make.height.mas_equalTo(15.f*Size_ratio);
        make.width.mas_equalTo(80.f*Size_ratio);
    }];
    [_testBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.equalTo(_learTime.mas_bottom).offset(20.f*Size_ratio);
        make.height.mas_equalTo(45.f*Size_ratio);
        make.width.mas_equalTo(80.f*Size_ratio);
    }];
    
    [_courseNew mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-32.f*Size_ratio);
        make.top.equalTo(_learTime.mas_bottom).offset(20.f*Size_ratio);
        make.height.mas_equalTo(22*Size_ratio);
        make.width.mas_equalTo(22*Size_ratio);
    }];
    [_courseLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_courseNew.mas_centerX);
        make.top.equalTo(_courseNew.mas_bottom).offset(8.f*Size_ratio);
        make.height.mas_equalTo(15.f*Size_ratio);
        make.width.mas_equalTo(80.f*Size_ratio);
    }];
    
    [_courseBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-32.f*Size_ratio);
        make.top.equalTo(_learTime.mas_bottom).offset(20.f*Size_ratio);
        make.height.mas_equalTo(45.f*Size_ratio);
        make.width.mas_equalTo(80.5*Size_ratio);
    }];
}
#pragma mark ====== createUI
- (void)setCustomViewUI{
    _userBackGroundImg.image = [UIImage imageNamed:@"标签"];

    [_userIconImg addTarget:self action:@selector(userIconButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _userNameLabel.textColor = [UIColor WYAJHBlackTextColor];
    _userNameLabel.font = [UIFont systemFontOfSize:15.f*Size_ratio];
    _userNameLabel.textAlignment = NSTextAlignmentCenter;
    
    _learTime.textColor = [UIColor WYAJHBaseRedColor];
    _learTime.textAlignment = NSTextAlignmentCenter;
    _learTime.font = [UIFont systemFontOfSize:13.f*Size_ratio];
    
    [self setButtonImageEdgeInsetsWith:_classTable titleText:@"课表" buttonLabel:_classLabel];
    [_classBtn addTarget:self action:@selector(classTableButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setButtonImageEdgeInsetsWith:_testScores titleText:@"测试成绩" buttonLabel:_testLabel];
    [_testBtn addTarget:self action:@selector(testScoresButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setButtonImageEdgeInsetsWith:_courseNew titleText:@"新课上架" buttonLabel:_courseLabel];
    [_courseBtn addTarget:self action:@selector(courseNewButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setModel:(WYAAdminInfoModel *)model{
    _model = model;
    _userIconButtonImg.layer.cornerRadius = 35.f*Size_ratio;
    _userIconButtonImg.layer.masksToBounds = YES;
    [_userIconButtonImg sd_setImageWithURL:[NSURL URLWithString:_model.shop_logo] placeholderImage:[UIImage imageNamed:@"userIconNorm"] options:SDWebImageDelayPlaceholder];
    
    _userNameLabel.text = _model.user_name;
    
    _learTime.text = [NSString stringWithFormat:@"已经学习时长：%@",_model.study_time];

    [self layoutIfNeeded];
}

- (void)setButtonImageEdgeInsetsWith:(UIImageView *)buttonImageView titleText:(NSString *)titleText buttonLabel:(UILabel *)btnLabel
{
    buttonImageView.image = [UIImage imageNamed:titleText];
    btnLabel.text = titleText;
    btnLabel.textColor = [UIColor WYAJHBlackTextColor];
    btnLabel.font = [UIFont systemFontOfSize:14.f*Size_ratio];
    btnLabel.textAlignment = NSTextAlignmentCenter;
    
}

#pragma mark ====== event
- (void)userIconButtonClicked:(UIButton *)sender{
    // 头像点击事件
    if (self.delegate && [self.delegate respondsToSelector:@selector(userIconClickedEvent:)]) {
        [self.delegate userIconClickedEvent:sender];
    }
}

- (void)classTableButtonClicked:(UIButton *)sender{
    // 课表点击事件
    if (self.delegate && [self.delegate respondsToSelector:@selector(classTableClickedEvent:)]) {
        [self.delegate classTableClickedEvent:sender];
    }
}

- (void)testScoresButtonClicked:(UIButton *)sender{
    // 测试成绩点击事件
    if (self.delegate && [self.delegate respondsToSelector:@selector(testScoresClickedEvent:)]) {
        [self.delegate testScoresClickedEvent:sender];
    }
}

- (void)courseNewButtonClicked:(UIButton *)sender{
    // 新课上架点击事件
    if (self.delegate && [self.delegate respondsToSelector:@selector(courseNewClickedEvent:)]) {
        [self.delegate courseNewClickedEvent:sender];
    }
}
@end
