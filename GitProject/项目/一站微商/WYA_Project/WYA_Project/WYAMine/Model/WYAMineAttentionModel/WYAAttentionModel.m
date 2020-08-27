//
//  WYAAttentionModel.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/12.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAAttentionModel.h"

@implementation WYAAttentionModel
+ (NSMutableArray *)attentionModelWith:(id)respone
{
    NSMutableArray * array = [NSMutableArray array];

    NSArray * list = respone[@"data"];
    for (NSDictionary * dict in list) {
        WYAAttentionModel * model = [[WYAAttentionModel alloc]init];
        model.teacher_name = checkString(dict[@"teacher_name"]);
        model.category_name = checkString(dict[@"category_name"]);
        NSString * imgUrl = checkString(dict[@"head_img"]);
        model.head_img = [imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        model.teacher_id = checkString(dict[@"teacher_id"]);
        [array addObject:model];
    }
    return array;
}
@end
