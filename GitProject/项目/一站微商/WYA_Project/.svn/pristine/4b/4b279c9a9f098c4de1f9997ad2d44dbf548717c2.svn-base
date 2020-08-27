//
//  WYAEmptyDataView.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/5/23.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAEmptyDataView.h"

@implementation WYAEmptyDataView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView * imageView = [[UIImageView alloc]init];
        [self addSubview:imageView];
        UILabel * toastLabel = [[UILabel alloc]init];
        [self addSubview:toastLabel];
        [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(100*Size_ratio);
            make.width.mas_equalTo(150*Size_ratio);
        }];
        imageView.image = [UIImage imageNamed:@"notdata"];
        toastLabel.text = @"亲！暂时没有你要的内容个哦~";
        toastLabel.textColor = [UIColor WYAJHgrayTextColor];
        toastLabel.textAlignment = NSTextAlignmentCenter;
        toastLabel.font = [UIFont systemFontOfSize:15*Size_ratio];
        [toastLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_bottom).offset(15*Size_ratio);
            make.height.mas_equalTo(20*Size_ratio);
            make.width.mas_equalTo(ScreenWidth);
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
