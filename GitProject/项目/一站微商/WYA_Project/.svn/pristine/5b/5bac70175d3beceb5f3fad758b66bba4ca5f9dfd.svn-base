//
//  WYATestPaperCollectionHeadView.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/19.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYATestPaperCollectionHeadView.h"

@interface WYATestPaperCollectionHeadView ()

@property (nonatomic, strong) UILabel * titleLabel;

@end

@implementation WYATestPaperCollectionHeadView

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:17*Size_ratio];
        _titleLabel.textColor = [UIColor WYAJHgrayTextColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor WYAJHLightGreyColor];
    }
    return _titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.frame = frame;
        [self addSubview:self.titleLabel];
    }
    return self;
}

-(void)setTitle:(NSString *)title{
    if (title) {
        self.titleLabel.text = title;
    }
}

@end
