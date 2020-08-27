//
//  WYACourseDownloadNetRequest.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/14.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYABaseNetRequest.h"
#import "WYACourseDownloadModel.h"

@interface WYACourseDownloadNetRequest : WYABaseNetRequest

/**
 获取课程下载列表

 @param params 参数
 @param success 成功
 @param fail 失败
 */
- (void)loadCourseDownloadWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail;


/**
 下载文件

 @param urlString url
 @param params 参数
 @param fileName 文件名
 @param progress 进度
 @param success 成功
 @param fail 失败
 @return 下载管理
 */
- (NSURLSessionDownloadTask *)downLoadCourseFileWithUrl:(NSString *)urlString
                                                 Params:(NSMutableDictionary *)params
                                               FileName:(NSString *)fileName
                                               progress:(Progress)fileProgress
                                                Success:(Success)success
                                                   Fail:(Fail)fail;

/**
 储存文件

 @param model model
 @param tableName 表名
 @param courseID ID
 */
- (void)storageFileWithModel:(WYACourseDownloadModel *)model TableName:(NSString *)tableName CourseID:(NSString *)courseID;
@end
