//
//  WYAArticleCategory.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/9.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAArticleCategory.h"

@implementation WYAArticleCategory
+ (NSMutableArray *)articleCategoryModelWith:(id)response
{
    NSMutableArray * array = [NSMutableArray array];
    NSArray * categoryArray = response[@"data"];
    for (NSDictionary * dic in categoryArray) {
        WYAArticleCategory * model = [[WYAArticleCategory alloc]init];
        model.category_id = checkString(dic[@"category_id"]);
        model.name = checkString(dic[@"name"]);
        if (![model.name isEqualToString:@"下载专区"]) {
          [array addObject:model];
        }
    }
    return array;
}
@end
