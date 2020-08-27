//
//  WYAMineCollectionNetRequest.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/16.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYABaseNetRequest.h"

@interface WYAMineCollectionNetRequest : WYABaseNetRequest

/**
 获取我的收藏课程数据

 @param params 参数
 @param success 成功
 @param fail 失败
 */
- (void)loadMineCollectionCourseWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail;

/**
 获取我的收藏文章数据

 @param params 参数
 @param success 成功
 @param fail 失败
 */
- (void)loadMineCollectionArticleWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail;

/**
 删除我的收藏

 @param params 参数
 @param success 成功
 @param fail 失败
 */
- (void)deleteMineCollectionWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail;
@end
