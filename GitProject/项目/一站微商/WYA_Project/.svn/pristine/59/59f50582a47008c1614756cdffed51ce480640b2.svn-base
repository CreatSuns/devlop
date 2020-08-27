//
//  WYATablePlaceHoldView.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/9.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYATablePlaceHoldView.h"

@implementation WYATablePlaceHoldView

-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.placeholdImageView = [[UIImageView alloc]init];
//        self.placeholdImageView.backgroundColor = [UIColor redColor];
        self.placeholdImageView.image = [UIImage imageNamed:@"notdata"];
        [self addSubview:self.placeholdImageView];
        
        self.errorMessageLabel = [[UILabel alloc]init];
        self.errorMessageLabel.text = @"加载失败，请下拉刷新重试！";
        self.errorMessageLabel.textColor = [UIColor blackColor];
        [self addSubview:self.errorMessageLabel];
        
        [self.placeholdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.mas_top).with.offset(100.f);
            make.size.mas_equalTo(CGSizeMake(100.f, 100.f));
        }];
        
        
        [self.errorMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.placeholdImageView.mas_bottom).with.offset(20.f);
        }];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
