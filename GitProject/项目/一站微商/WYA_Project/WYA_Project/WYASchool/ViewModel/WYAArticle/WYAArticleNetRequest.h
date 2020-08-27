//
//  WYAArticleNetRequest.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/9.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYABaseNetRequest.h"

@interface WYAArticleNetRequest : WYABaseNetRequest
/**
 获取文章分类
 
 @param params 参数
 @param success 成功
 @param fail 失败
 */
- (void)loadArticlCategoryWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail;


/**
 获取文章分类列表
 
 @param params 参数
 @param success 成功
 @param fail 失败
 */
- (void)loadArticlListWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail;

/**
 获取文章详情
 
 @param params 参数
 @param success 成功
 @param fail 失败
 */
- (void)loadArticlDetailWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail;


/**
 点赞
 
 @param params 参数
 @param success 成功
 @param fail 失败
 */
- (void)thumArticlDetailWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail;
/**
 收藏文章
 
 @param params 参数
 @param success 成功
 @param fail 失败
 */
- (void)collectionArticlDetailWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail;
/**
 关注讲师
 
 @param params 参数
 @param success 成功
 @param fail 失败
 */
- (void)focusTeacherWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail;
@end
