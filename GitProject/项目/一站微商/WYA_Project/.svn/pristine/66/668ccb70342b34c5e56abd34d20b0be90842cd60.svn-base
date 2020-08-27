//
//  WYACourseDetailModel.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/11.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseDescription : NSObject

@property (nonatomic, copy) NSString * html;

@end

@interface LastChapter : NSObject

@property (nonatomic, copy)  NSString * chapter_id;
@property (nonatomic, copy)  NSString * chapter_title;
@property (nonatomic, copy)  NSString * group_id;
@property (nonatomic, copy)  NSString * group_title;
@property (nonatomic, copy)  NSString * video_length;
@property (nonatomic, copy)  NSString * process;
@property (nonatomic, copy)  NSString * video_url;
@property (nonatomic, copy)  NSString * is_completed;

@end

@interface CourseInfo : NSObject

@property (nonatomic, copy)  NSString * allow_download;
@property (nonatomic, copy)  NSString * allow_fast_forward;
@property (nonatomic, copy)  NSString * allow_skip;
@property (nonatomic, assign)NSInteger  course_id;
@property (nonatomic, copy)  NSString * course_title;
@property (nonatomic, copy)  NSString * courseDescription;
@property (nonatomic, copy)  NSString * introduction;
@property (nonatomic, assign)NSInteger  is_collected;
@property (nonatomic, copy)  NSString * learned;
@property (nonatomic, copy)  NSString * teacher_id;
@property (nonatomic, copy)  NSString * teacher_img;
@property (nonatomic, copy)  NSString * teacher_name;

@property (nonatomic, strong)  CourseDescription * cDescription;

@end

@interface WYACourseDetailModel : NSObject

@property (nonatomic, strong) CourseInfo * course_info;

@property (nonatomic, strong) LastChapter * last_chapter;

@end
