//
//  WYANetErrorView.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/12.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYANetErrorView.h"

@interface WYANetErrorView ()

@property (nonatomic, strong) UIView * learnView;

@property (nonatomic, strong) UILabel * learnLabel;

@property (nonatomic, strong) UIButton * learnButton;

@end

@implementation WYANetErrorView

- (UIView *)learnView{
    if (!_learnView) {
        _learnView = [[UIView alloc]init];
        _learnView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.1];//
    }
    return _learnView;
}

- (UILabel *)learnLabel{
    if (!_learnLabel) {
        _learnLabel = [[UILabel alloc]init];
        _learnLabel.textColor = [UIColor whiteColor];
        _learnLabel.font = [UIFont systemFontOfSize:15*Size_ratio];
        _learnLabel.textAlignment = NSTextAlignmentCenter;
        _learnLabel.text = @"加载失败，请检查网络重试";
    }
    return _learnLabel;
    
}

- (UIButton *)learnButton{
    if (!_learnButton) {
        _learnButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_learnButton setBackgroundColor:[UIColor clearColor]];
        [_learnButton setTitle:@"刷新重试" forState:UIControlStateNormal];
        [_learnButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_learnButton addTarget:self action:@selector(refreshClick) forControlEvents:UIControlEventTouchUpInside];
        _learnButton.titleLabel.font = [UIFont systemFontOfSize:15*Size_ratio];
        _learnButton.layer.cornerRadius = 5.f;
        _learnButton.layer.masksToBounds = YES;
        _learnButton.layer.borderWidth = 0.5;
        _learnButton.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _learnButton;
}

-(instancetype)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.1];
        [self addSubview:self.learnView];
        [self.learnView addSubview:self.learnLabel];
        [self.learnView addSubview:self.learnButton];
    
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.learnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.learnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.learnView.mas_centerY).with.offset(-20.f);
        make.centerX.mas_equalTo(self.learnView.mas_centerX);
    }];
    [self.learnButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.learnView.mas_centerX);
        make.centerY.mas_equalTo(self.learnView.mas_centerY).with.offset(20.f);
        make.width.mas_equalTo(88*Size_ratio);
        make.height.mas_equalTo(29*Size_ratio);
    }];
}

- (void)refreshClick{
    if (self.netReload) {
        self.netReload();
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
