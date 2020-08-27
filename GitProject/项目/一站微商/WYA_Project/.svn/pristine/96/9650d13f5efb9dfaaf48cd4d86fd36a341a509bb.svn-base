//
//  NSDate+WYADate.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/10.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "NSDate+WYADate.h"

@implementation NSDate (WYADate)

- (NSUInteger)year{
    return [NSDate year:self];
}

- (NSUInteger)month{
    return [NSDate month:self];
}

+ (NSUInteger)month:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
    
    return [dayComponents month];
}

+ (NSUInteger)year:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
    
    return [dayComponents year];
}
@end
