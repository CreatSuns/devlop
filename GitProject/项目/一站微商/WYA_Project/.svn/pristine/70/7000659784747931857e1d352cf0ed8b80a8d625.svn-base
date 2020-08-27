//
//  WYACourseCatalogNetRequst.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/13.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYABaseNetRequest.h"

@interface WYACourseCatalogNetRequst : WYABaseNetRequest

/**
 获取课程详情目录

 @param params 参数
 @param success 成功
 @param fail 失败
 */
- (void)loadCourseCatalogWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail;

/**
 查找相应条件的表中的元素

 @param tableName 表名
 @param conditions 查询条件
 @return 元素集
 */
- (NSArray *)queryFileDownloadState:(NSString *)tableName QueryConditions:(NSString *)conditions;

@end
