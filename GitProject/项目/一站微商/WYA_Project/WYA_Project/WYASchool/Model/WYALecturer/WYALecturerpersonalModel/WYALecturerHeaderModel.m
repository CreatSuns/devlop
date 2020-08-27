//
//  WYALecturerHeaderModel.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/11.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYALecturerHeaderModel.h"

@implementation WYALecturerHeaderModel
+ (id)LecturerHeaderViewModelWith:(id)response
{
   
    NSDictionary * dic = response[@"data"];
    WYALecturerHeaderModel * model = [[WYALecturerHeaderModel alloc]init];
    model.teacher_id = checkString(dic[@"teacher_id"]);
    model.teacher_name = checkString(dic[@"teacher_name"]);
    model.head_img = checkString([dic[@"head_img"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
    model.count_course = checkString(dic[@"count_course"]);
    model.count_article = checkString(dic[@"count_article"]);
    model.teacher_attention = checkString(dic[@"teacher_attention"]);
    model.is_attention = checkString(dic[@"is_attention"]);
    model.title_name = checkString(dic[@"title_name"]);
    model.good = checkString(dic[@"good"]);
    model.introduction = checkString(dic[@"introduction"]);
    model.category_ico = [checkString(dic[@"category_ico"]) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return model;
}
@end
