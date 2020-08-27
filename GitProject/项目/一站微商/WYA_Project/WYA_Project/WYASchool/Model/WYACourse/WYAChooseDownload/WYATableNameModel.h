//
//  WYATableNameModel.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/25.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYATableNameModel : NSObject
/** 创建的表名*/
@property (nonatomic, copy) NSString * tableName;
/** 课程图片*/
@property (nonatomic, copy) NSString * course_image_url;
/** 课程标题*/
@property (nonatomic, copy) NSString * course_title;
/** 课程id*/
@property (nonatomic, copy) NSString * course_id;
/** 是否有下载的课件或视频   1有视频和课件 0没有视频和课件 */
@property (nonatomic, copy) NSString * haveDownloadChapter;

@end
