//
//  WYACardParsingModel.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/23.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYACardParsingModel.h"

@implementation WYACardParsingModel
+ (NSMutableArray *)cardParsingModelWithdata:(id)respone
{
    NSMutableArray * dataArray = [NSMutableArray array];
    NSDictionary * data = respone[@"data"];
    if (data) {
    NSArray * list = data[@"list"];
    for (int i = 0; i< list.count; i++) {
        WYACardParsingModel * model = [[WYACardParsingModel alloc]init];
        NSDictionary * dict = list[i];
        model.exam_time = checkString(dict[@"exam_time"]);
        model.pass_point = checkString(dict[@"pass_point"]);
        model.points = checkString(dict[@"points"]);
        model.score = checkString(dict[@"score"]);
        model.use_time = checkString(dict[@"use_time"]);
        model.itemsNum = data[@"count"];
        CGFloat passPoint = [model.pass_point floatValue];
        CGFloat scorePoint = [model.score floatValue];
        
        model.isShowBottomItem = passPoint > scorePoint ? @"0":@"1";
        [dataArray addObject:model];
    }
      }
    return dataArray;
}
@end
