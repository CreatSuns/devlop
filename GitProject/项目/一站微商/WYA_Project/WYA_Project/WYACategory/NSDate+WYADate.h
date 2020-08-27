//
//  NSDate+WYADate.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/10.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WYADate)

/**
 获取当前年份
 */
- (NSUInteger)year;
+ (NSUInteger)year:(NSDate *)date;

/**
 获取当前月份
 */
- (NSUInteger)month;
+ (NSUInteger)month:(NSDate *)date;

@end
