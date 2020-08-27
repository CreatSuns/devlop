//
//  WYAChooseDownloadNetRequest.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/25.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYABaseNetRequest.h"

@interface WYAChooseDownloadNetRequest : WYABaseNetRequest

/**
 章节下载详情
 
 @param params 参数
 @param success 成功
 @param fail 失败
 */
- (void)loadChapterDownloadWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail;

/**
 开始下载文件

 @param fileArray model数组（元素为WYAChooseChapterModel类型）
 */
- (void)startDownloadFileWithfileArray:(NSMutableArray *)fileArray
                              CourseID:(NSString *)course_id
                             TableName:(NSString *)tableName
                             GroupName:(NSString *)groupName;

/**
 根据表名查找该表的元素

 @param tableName 表名
 @return 元素集
 */
- (NSArray *)findLocalArrayModelWithTableName:(NSString *)tableName;

/**
 根据表名查找该表下载状态不为0的元素

 @param tableName 表名
 @return 元素集
 */
- (NSArray *)findLocalStateChangeArrayWithTableName:(NSString *)tableName;
@end
