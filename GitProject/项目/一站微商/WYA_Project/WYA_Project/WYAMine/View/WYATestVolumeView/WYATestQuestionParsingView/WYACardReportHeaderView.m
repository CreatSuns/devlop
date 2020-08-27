//
//  WYACardReportHeaderView.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/19.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYACardReportHeaderView.h"
@interface WYACardReportHeaderView()
@property(nonatomic, strong) UISegmentedControl * segmentControll;//选择器
@property(nonatomic, strong) UILabel * timeLabel;//用时
@property(nonatomic, strong) UILabel * scoreLabel;//分数
@end
@implementation WYACardReportHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
	
    }
    return self;
}
- (void)setUI{

}
@end
