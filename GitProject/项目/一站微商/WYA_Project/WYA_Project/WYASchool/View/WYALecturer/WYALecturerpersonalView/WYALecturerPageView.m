//
//  WYALecturerPageView.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/10.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYALecturerPageView.h"
@interface WYALecturerPageView()
@property(nonatomic, strong) UIButton * button;
@property(nonatomic, strong) UILabel * lineLabel;

@property(nonatomic, strong) UIView * lineView;
@end
@implementation WYALecturerPageView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    
        self.backgroundColor = [UIColor whiteColor];
        _lineView = [[UIView alloc]init];
        _leftButton = [[UIButton alloc]init];
        _leftLineLabel = [[UILabel alloc]init];
        _rightButton = [[UIButton alloc]init];
        _rightLineLabel = [[UILabel alloc]init];
        
        [self addSubview:_leftButton];
        [self addSubview:_leftLineLabel];
        [self addSubview:_rightButton];
        [self addSubview:_rightLineLabel];
        [self addSubview:_lineView];
        
//        [self creatScrollButton];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat spacing = 47.f;
    CGFloat width = 80.f;
    CGFloat height = 15.f;
    CGFloat X = (ScreenWidth - width*2 - spacing)*0.5;
    CGFloat Y = 12.f;
    
    [_leftButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(X);
        make.top.equalTo(self.mas_top).offset(Y);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
    }];
    
    [_leftLineLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(X);
        make.top.equalTo(_leftButton.mas_bottom).offset(5.f);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(1.f);
    }];
    
    [_rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-X);
        make.top.equalTo(self.mas_top).offset(Y);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
    }];
    
    [_rightLineLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-X);
        make.top.equalTo(_rightButton.mas_bottom).offset(5.f);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(1.f);
    }];
    
    [_lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(-5.f);
        make.height.mas_equalTo(5.f);
    }];
}
- (void)setModel:(WYALecturerHeaderModel *)model
{
    _model = model;
    [_leftButton setTitle:[NSString stringWithFormat:@"课程·%@",_model.count_course] forState:UIControlStateNormal];
    [_leftButton setTitleColor:[UIColor WYAJHBasePurpleColor] forState:UIControlStateNormal];
    [_leftLineLabel setBackgroundColor:[UIColor WYAJHBasePurpleColor]];
    [_leftButton addTarget:self action:@selector(leftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    [_rightButton setTitle:[NSString stringWithFormat:@"文章·%@",_model.count_article] forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor WYAJHgrayTextColor] forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_rightLineLabel setBackgroundColor:[UIColor whiteColor]];

    _lineView.backgroundColor = [UIColor WYAJHLightGreyColor];
    [self layoutIfNeeded];

}

- (void)leftButtonClicked:(UIButton *)sender
{

    [_rightButton setTitleColor:[UIColor WYAJHgrayTextColor] forState:UIControlStateNormal];
    _rightLineLabel.backgroundColor = [UIColor whiteColor];

    [_leftButton setTitleColor:[UIColor WYAJHBasePurpleColor] forState:UIControlStateNormal];
    _leftLineLabel.backgroundColor = [UIColor WYAJHBasePurpleColor];
    if (self.delegate && [self.delegate respondsToSelector:@selector(courseButtonClickedEvent:)]) {
        [self.delegate courseButtonClickedEvent:sender];
    }

}
- (void)rightButtonClicked:(UIButton *)sender
{
    [_leftButton setTitleColor:[UIColor WYAJHgrayTextColor] forState:UIControlStateNormal];
    _leftLineLabel.backgroundColor = [UIColor whiteColor];

    [_rightButton setTitleColor:[UIColor WYAJHBasePurpleColor] forState:UIControlStateNormal];
    _rightLineLabel.backgroundColor = [UIColor WYAJHBasePurpleColor];
    if (self.delegate && [self.delegate respondsToSelector:@selector(articleButtonClickedEvent:)]) {
        [self.delegate articleButtonClickedEvent:sender];
    }
}
#pragma mark ====== 循环创建多个按钮单选事件（按钮可以实现单选但是下边指示条目前无法解决弃用）
//- (void)buttonClicked:(UIButton *)sender
//{
//
//    if (_button == nil){
//        sender.selected = YES;
//        _button = sender;
//    }
//    else  if (_button !=nil &&_button == sender){
//        sender.selected = YES;
//    } else if (_button!= sender && _button!=nil){
//        _button.selected = NO;
//        sender.selected = YES;
//        _button = sender;
//    }
//    _selectIndex = sender.tag;
//}
//- (void)creatScrollButton{
//    CGFloat spacing = 47.f;
//    CGFloat with = 80.f;
//    CGFloat height = 15.f;
//    CGFloat X = (ScreenWidth - with*2 - spacing)*0.5;
//    CGFloat Y = 12.f;
//    for (int i = 0; i < 2; i++) {
//        NSInteger column = i%2;
//        _button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_button setTitle:[NSString stringWithFormat:@"课程·%d",i] forState:UIControlStateNormal];
//        _button.tag = 1000 + i;
//
//        [_button setTitleColor:[UIColor WYAJHgrayTextColor] forState:UIControlStateNormal];
//        [_button setTitleColor:[UIColor WYAJHBasePurpleColor] forState:UIControlStateSelected];
//
//        _button.frame = CGRectMake(X+column*(with + spacing), Y, with, height);
//        [_button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(X+column*(with + spacing), Y + height + 5.f, with, 1.f)];
////        if (i==0) {
//////            _lineLabel.backgroundColor = [UIColor WYAJHBasePurpleColor];
////            _button.selected = YES;
////            //            [_button setTitleColor:[UIColor WYAJHBasePurpleColor] forState:UIControlStateNormal];
////        }else
////        {
////
////        }
//
////        _lineLabel.tag = 2000 + i;
//        [self addSubview:_button];
//        [self addSubview:_lineLabel];
//    }
//    [self layoutIfNeeded];
//}
@end
