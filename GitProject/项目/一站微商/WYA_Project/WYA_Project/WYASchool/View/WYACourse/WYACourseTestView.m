//
//  WYACourseTestView.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/16.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYACourseTestView.h"

@interface WYACourseTestView ()

@property(nonatomic, strong) UIButton * testButton;

@end

@implementation WYACourseTestView

- (UILabel *)testTitleLabel{
    if (!_testTitleLabel) {
        _testTitleLabel = [[UILabel alloc]init];
        _testTitleLabel.textColor = [UIColor whiteColor];
        _testTitleLabel.font = [UIFont systemFontOfSize:15*Size_ratio];
        _testTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _testTitleLabel;
}

- (UIButton *)testButton{
    if (!_testButton) {
        _testButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_testButton setBackgroundColor:[UIColor clearColor]];
        [_testButton setTitle:@"开始测试" forState:UIControlStateNormal];
        [_testButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_testButton addTarget:self action:@selector(startTestClick) forControlEvents:UIControlEventTouchUpInside];
        _testButton.titleLabel.font = [UIFont systemFontOfSize:15*Size_ratio];
        _testButton.layer.cornerRadius = 5.f;
        _testButton.layer.masksToBounds = YES;
        _testButton.layer.borderWidth = 0.5;
        _testButton.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _testButton;
}


- (instancetype)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.1];
        [self addSubview:self.testTitleLabel];
        [self addSubview:self.testButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.testTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY).with.offset(-20);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(@25.f);
    }];
    
    [self.testButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY).with.offset(20);
        make.width.mas_equalTo(88*Size_ratio);
        make.height.mas_equalTo(29*Size_ratio);
    }];
}

- (void)startTestClick{
    if (self.testDelegate && [self.testDelegate respondsToSelector:@selector(goTest)]) {
        [self.testDelegate goTest];
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
