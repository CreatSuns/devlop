//
//  WYANewCourseModel.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/10.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYANewCourseModel.h"

@implementation ThisMonth

@end

@implementation LastMonth

@end

@implementation NewCourseList

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic{
    if (!dic[@"this_month"]) {
        return NO;
    }
    if (!dic[@"last_month"]) {
        return NO;
    }
    return YES;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"this_month" : [ThisMonth class],
             @"last_month" : [LastMonth class],
             };
}

@end

@implementation WYANewCourseModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"list" : [NewCourseList class],
             };
}

@end
