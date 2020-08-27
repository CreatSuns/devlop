//
//  WYASearchCourseModel.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/24.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//
#import "WYASearchCourseModel.h"

@implementation WYASearchCourseModel
+ (NSMutableArray *)searchCourseModelWith:(id)resulte
{
    NSMutableArray * array = [NSMutableArray array];
    NSArray * list = [resulte objectForKey:@"list"];
    for (NSDictionary * dic in list) {
        WYASearchCourseModel * model = [[WYASearchCourseModel alloc]init];
        model.count = checkString(resulte[@"count"]);
        model.learned = checkString(dic[@"learned"]);
        model.teacher_name = checkString(dic[@"teacher_name"]);
        model.teacher_id = checkString(dic[@"teacher_id"]);
        model.title_name = checkString(dic[@"title_name"]);
        model.course_id = checkString(dic[@"course_id"]);
        model.course_title = checkString(dic[@"course_title"]);
        model.img_url = checkString(dic[@"img_url"]);
        [array addObject:model];
    }
    return array;
}
@end
