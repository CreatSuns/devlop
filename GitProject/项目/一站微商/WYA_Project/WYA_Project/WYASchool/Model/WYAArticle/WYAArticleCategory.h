//
//  WYAArticleCategory.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/9.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYAArticleCategory : NSObject
@property (nonatomic, copy) NSString * category_id;

@property (nonatomic, copy) NSString * name;
+ (NSMutableArray *)articleCategoryModelWith:(id)response;
@end
