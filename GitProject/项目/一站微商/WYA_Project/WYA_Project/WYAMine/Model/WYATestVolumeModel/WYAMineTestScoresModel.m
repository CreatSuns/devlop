//
//  WYATestScoresModel.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/18.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMineTestScoresModel.h"

@implementation WYAMineTestScoresListModel

@end

@implementation WYAMineTestScoresModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"list" : [WYAMineTestScoresListModel class],
             };
}

@end
