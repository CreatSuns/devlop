//
//  WYATestPaperModel.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/19.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYATestPaperModel.h"

@implementation WYATestPaperUserModel

@end

@implementation WYATestPaperListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"user" : [WYATestPaperUserModel class],
             };
}

@end

@implementation WYATestPaperModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"list" : [WYATestPaperListModel class],
             };
}

@end
