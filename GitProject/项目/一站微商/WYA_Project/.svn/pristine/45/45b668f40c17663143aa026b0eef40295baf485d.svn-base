//
//  WYALocalDownloadModel.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/24.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "SODownloadItem.h"

@interface WYALocalDownloadModel : SODownloadItem

/**文件名*/
@property (nonatomic, copy) NSString * fileName;
/**经过MD5加密过的url文件名，本地存的是这个*/
@property (nonatomic, copy) NSString * fileLocalName;
/**文件类型*/
@property (nonatomic, copy) NSString * fileType;
/**文件大小*/
@property (nonatomic, copy) NSString * fileSize;
/**文件下载状态*/
@property (nonatomic, assign) NSUInteger fileState;
/**文件下载进度*/
@property (nonatomic, assign) float fileProgress;
/**下载的url*/
@property (nonatomic, copy) NSString * fileUrl;
/**本地存储的url*/
@property (nonatomic, copy) NSString * fileLocalurl;
/**下载文件数字类型*/
@property (nonatomic, copy) NSString * fileNumber;
/**查找model关键字*/
@property (nonatomic, copy) NSString * findModel;

@property (nonatomic, copy) NSString * fileID;
@property (nonatomic, copy) NSString * videoName;
/**
下载速度
 */
@property (nonatomic, copy) NSString * fileSpeed;

/**
 记录表名
 */
@property (nonatomic, copy) NSString * fmdb_name;

/**
 课程ID
 */
@property (nonatomic, copy) NSString * course_id;

@property (nonatomic, copy) NSString * course_title;

- (NSString *)savePath;

@end
