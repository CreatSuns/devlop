//
//  WYAMyCouresTableNoDataView.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/10.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMyCouresTableNoDataView.h"

@implementation WYAMyCouresTableNoDataView

-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor WYAJHLightGreyColor];
        self.placeholdImageView = [[UIImageView alloc]init];
        self.placeholdImageView.image = [UIImage imageNamed:@"notdata"];
        [self addSubview:self.placeholdImageView];
        
        self.errorMessageLabel = [[UILabel alloc]init];
        self.errorMessageLabel.text = @"亲！暂时没有加入课程哦~";
        self.errorMessageLabel.textColor = [UIColor WYAJHMyCouresTableNoDataTextColor];
        [self addSubview:self.errorMessageLabel];
        
        [self.placeholdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.mas_top).with.offset(132.f);
            make.size.mas_equalTo(CGSizeMake(100, 100));
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
