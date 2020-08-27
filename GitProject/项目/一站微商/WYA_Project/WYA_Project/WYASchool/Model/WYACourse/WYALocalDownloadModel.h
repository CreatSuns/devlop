//
//  WYALocalDownloadModel.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/24.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYALocalDownloadModel : NSObject

/**
 文件名
 */
@property (nonatomic, copy) NSString * fileName;

/**
 下载的url
 */
@property (nonatomic, copy) NSString * url;

/**
 本地存储的url
 */
@property (nonatomic, copy) NSString * localurl;

/**
 文件大小
 */
@property (nonatomic, assign) float fileSize;

/**
 文件下载进度
 */
@property (nonatomic, assign) float progress;

/**
 文件下载状态
 */
@property (nonatomic, assign) NSUInteger fileState;

/**
 下载文件类型
 */
@property (nonatomic, copy) NSString * fileType;

/**
 查找model关键字
 */
@property (nonatomic, copy) NSString * findModel;

@property (nonatomic, copy) NSString * fileID;

@end
