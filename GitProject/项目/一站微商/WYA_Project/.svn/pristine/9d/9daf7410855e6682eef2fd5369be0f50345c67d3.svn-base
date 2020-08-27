//
//  WYAArticleListModel.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/9.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAArticleListModel.h"

@implementation WYAArticleListModel
+ (NSMutableArray *)articleListModelWith:(id)response
{
    NSMutableArray * array = [NSMutableArray array];
    NSDictionary * data = response[@"data"];
    NSArray * list = [data objectForKey:@"list"];
    for (NSDictionary * dic in list) {
        WYAArticleListModel * model = [[WYAArticleListModel alloc]init];
        model.article_id = checkString(dic[@"article_id"]);
        model.article_title = checkString(dic[@"article_title"]);
        NSString * imgUrl = checkString(dic[@"img"]);
        model.artic_img = [imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        model.pv = checkString(dic[@"pv"]);
        model.count_thumb = checkString(dic[@"count_thumb"]);
        model.count_collection = checkString(dic[@"count_collection"]);
        model.teacher_name = checkString(dic[@"teacher_name"]);
        [array addObject:model];
    }
    return array;
}

+ (NSMutableArray *)searchArticleModelWith:(id)resulte
{
    NSMutableArray * array = [NSMutableArray array];
    NSArray * list = [resulte objectForKey:@"list"];
    for (NSDictionary * dic in list) {
        WYAArticleListModel * model = [[WYAArticleListModel alloc]init];
        model.count = checkString(resulte[@"count"]);
        model.article_id = checkString(dic[@"article_id"]);
        model.article_title = checkString(dic[@"article_title"]);
        NSString * imgUrl = checkString(dic[@"img"]);
        model.artic_img = [imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        model.pv = checkString(dic[@"pv"]);
        model.count_thumb = checkString(dic[@"count_thumb"]);
        model.count_collection = checkString(dic[@"count_collection"]);
        model.teacher_name = checkString(dic[@"teacher_name"]);
        [array addObject:model];
    }
    return array;
}
@end
