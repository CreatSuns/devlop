//
//  WYACourseDownloadNavView.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/14.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYACourseDownloadNavView.h"

@interface WYACourseDownloadNavView ()

@property (nonatomic, strong) UIView * navView;

@property (nonatomic, strong) UIButton * button;

@property (nonatomic, strong) UILabel * titleLabel;

@end

@implementation WYACourseDownloadNavView

-(UIView *)navView{
    if (!_navView) {
        _navView = [[UIView alloc]init];
        _navView.backgroundColor = [UIColor whiteColor];
    }
    return _navView;
}

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor WYAJHBlackTextColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.navView];
        [self.navView addSubview:self.button];
        [self.navView addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.navView.mas_left).with.offset(15.f);
        make.centerY.mas_equalTo(self.navView.mas_centerY).with.offset(WYAStatusBarHeight/2);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.navView.mas_centerY).with.offset(WYAStatusBarHeight/2);
        make.centerX.mas_equalTo(self.navView.mas_centerX);
        make.width.mas_greaterThanOrEqualTo(200);
        make.height.mas_equalTo(30);
    }];
}

-(void)setTitle:(NSString *)title{
    if (title) {
        self.titleLabel.text = title;
        [self layoutIfNeeded];
    }
}

- (void)buttonClick{
    if (self.buttonAction) {
        self.buttonAction();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
