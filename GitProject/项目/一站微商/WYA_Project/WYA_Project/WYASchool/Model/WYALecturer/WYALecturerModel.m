//
//  WYALecturerModel.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/9.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYALecturerModel.h"

@implementation WYALecturerModel
+ (NSMutableArray *)LecturerModelWith:(id)response
{
    NSMutableArray * array = [NSMutableArray array];
    NSDictionary * data = response[@"data"];
    NSArray * list = [data objectForKey:@"list"];
    for (NSDictionary * dic in list) {
        WYALecturerModel * model = [[WYALecturerModel alloc]init];
        model.teacher_id = checkString(dic[@"teacher_id"]);
        model.teacher_name = checkString(dic[@"teacher_name"]);
        model.introduction = checkString(dic[@"introduction"]);
        model.good = checkString(dic[@"good"]);
        model.category_ico = checkString(dic[@"category_ico"]);
        model.title_name = checkString(dic[@"title_name"]);
        model.teacher_attention = checkString(dic[@"teacher_attention"]);
        model.head_img = checkString(dic[@"head_img"]);
        [array addObject:model];
    }
    
    return array;
}

+ (NSMutableArray *)searchLecturerModelWith:(id)resulte
{
    NSMutableArray * array = [NSMutableArray array];
    NSArray * list = [resulte objectForKey:@"list"];
    for (NSDictionary * dic in list) {
        WYALecturerModel * model = [[WYALecturerModel alloc]init];
        model.count = checkString(resulte[@"count"]);
        model.teacher_id = checkString(dic[@"teacher_id"]);
        model.teacher_name = checkString(dic[@"teacher_name"]);
        model.introduction = checkString(dic[@"introduction"]);
        model.good = checkString(dic[@"good"]);
        model.title_name = checkString(dic[@"title_name"]);
        model.teacher_attention = checkString(dic[@"teacher_attention"]);
        model.head_img = checkString(dic[@"head_img"]);
        [array addObject:model];
    }
    
    return array;
}
@end
