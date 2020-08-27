//
//  WYAArticleDetailModel.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/13.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAArticleDetailModel.h"

@implementation WYAArticleDetailModel
+ (instancetype)articleDetailWith:(id)respone
{
    WYAArticleDetailModel * model = [[WYAArticleDetailModel alloc]init];
    NSDictionary * dict = respone[@"data"];
    model.article_id = checkString(dict[@"article_id"]);
    model.teacher_id = checkString(dict[@"teacher_id"]);
    model.article_title = checkString(dict[@"article_title"]);
    model.pv = checkString(dict[@"pv"]);
    NSDictionary * content = dict[@"content"];
    model.content = checkString(content[@"html"]);
    model.create_time = checkString(dict[@"create_time"]);
    model.teacher_name = checkString(dict[@"teacher_name"]);
    model.is_collection = checkNumber(dict[@"is_collection"]);
    model.is_attention = checkNumber(dict[@"is_attention"]);
    model.is_thumb = checkNumber(dict[@"is_thumb"]);
    
    return model;
}
@end
