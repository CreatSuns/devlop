//
//  WYAMineCollectionArticleModel.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/16.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMineCollectionArticleModel.h"

@implementation WYAMineCollectionArticleListModel

@end

@implementation WYAMineCollectionArticleModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"list" : [WYAMineCollectionArticleListModel class],
             };
}

@end

