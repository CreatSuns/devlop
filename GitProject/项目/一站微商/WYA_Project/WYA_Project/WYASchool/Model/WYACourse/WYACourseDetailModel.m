//
//  WYACourseDetailModel.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/11.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYACourseDetailModel.h"

@implementation CourseDescription

@end

@implementation LastChapter

@end

@implementation CourseInfo

+ (NSDictionary *)modelCustomPropertyMapper {
    return@{@"cDescription" :@"description"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"cDescription" : [CourseDescription class],
             };
}
@end

@implementation WYACourseDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"course_info" : [CourseInfo class],
             @"last_chapter": [LastChapter class],
             };
}

@end
