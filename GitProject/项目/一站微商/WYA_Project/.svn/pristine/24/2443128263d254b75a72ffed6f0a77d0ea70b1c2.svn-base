//
//  NSString+WYAString.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/10.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WYAString)

/**
 小写转大写

 @param number 数字（0-12）
 @return 字符串
 */
+ (NSString *)upperCaseNumber:(NSInteger)number;

// 程序主目录，可见子目录(3个):Documents、Library、tmp
+ (NSString *)homePath;

// 程序目录，不能存任何东西
+ (NSString *)appPath;

// 文档目录，需要ITUNES同步备份的数据存这里，可存放用户数据
+ (NSString *)docPath;

// 配置目录，配置文件存这里
+ (NSString *)libPrefPath;

// 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
+ (NSString *)libCachePath;

// 临时缓存目录，APP退出后，系统可能会删除这里的内容
+ (NSString *)tmpPath;

//所有用户存放下载数据的文件夹路径
+ (NSString *)allUserDownloadFile;

+ (NSString *)allUserDownloaderPlist;

//获取项目下载文件的文件夹路径
+ (NSString *)downloadFilePath;

+ (NSString *)downloadVideoPath;

- (unsigned long long)fileSize;
@end
