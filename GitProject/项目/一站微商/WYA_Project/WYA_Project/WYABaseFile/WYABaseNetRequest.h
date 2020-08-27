//
//  NetRequest.h
//  CustomHUD
//
//  Created by lishihang on 18/03/28.
//  Copyright © 2018年 lishihang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

//定义网络返回值类型
typedef NS_ENUM(NSInteger, NetRequestCode) {
    code104 = 0,
    code105,
    code106,
    
};

typedef void(^Success)(id data);

typedef void(^Fail)(NetRequestCode netCode, NSString *errorDes);

typedef void(^Progress)(float progress);


@interface WYABaseNetRequest : NSObject

@property(nonatomic,readonly) NetRequestCode netCood;

/**
 Get请求

 @param urlString URL
 @param params 参数
 @param success 成功
 @param fail 失败
 */
+ (void)GetWithUrl:(NSString *)urlString
            Params:(NSMutableDictionary *)params
           Success:(Success)success
              Fail:(Fail)fail;


/**
 Post请求

 @param urlString URL
 @param params 参数
 @param success 成功
 @param fail 失败
 */
+ (void)PostWithUrl:(NSString *)urlString
             Params:(NSMutableDictionary *)params
            Success:(Success)success
               Fail:(Fail)fail;

/**
 下载文件

 @param urlString URL
 @param params 参数
 @param filePath 文件下载至本地路径
 @param progress 进度
 @param success 成功
 @param fail 失败
 @return 任务管理
 */
+ (NSURLSessionDownloadTask *)DownLoadFileWithUrl:(NSString *)urlString
                                           Params:(NSMutableDictionary *)params
                                         FilePath:(NSString *)filePath
                                         progress:(Progress)progress
                                          Success:(Success)success
                                             Fail:(Fail)fail;

/**
 上传图片

 @param urlString url
 @param params 参数
 @param images 图片数组
 @param progress 进度
 @param success 成功
 @param fail 失败
 */
+ (void)UploadImageWithUrl:(NSString *)urlString
                    params:(NSMutableDictionary *)params
                    Images:(NSArray *)images
                  progress:(Progress)progress
                   Success:(Success)success
                      Fail:(Fail)fail;
@end
