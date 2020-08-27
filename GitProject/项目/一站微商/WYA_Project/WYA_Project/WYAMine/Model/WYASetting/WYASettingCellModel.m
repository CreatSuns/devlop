//
//  WYASettingCellModel.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/9.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYASettingCellModel.h"

@implementation WYASettingCellModel

-(instancetype)initWithTitle:(NSString *)title{
    
    self = [super init];
    
    if (self) {
        _title = title;
    }
    
    return self;
}

@end
