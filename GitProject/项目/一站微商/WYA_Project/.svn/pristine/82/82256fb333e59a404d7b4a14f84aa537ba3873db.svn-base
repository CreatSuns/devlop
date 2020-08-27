//
//  WYANewCourseModel.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/10.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LastMonth : NSObject

@property (nonatomic, copy)   NSString * course_id;
@property (nonatomic, copy)   NSString * title;
@property (nonatomic, copy)   NSString * img_url;
@property (nonatomic, copy)   NSString * create_time;
@property (nonatomic, copy)   NSString * name;
@property (nonatomic, copy)   NSString * teacher_name;
@property (nonatomic, copy)   NSString * category_ico;

@end

@interface ThisMonth : NSObject

@property (nonatomic, copy)   NSString * course_id;
@property (nonatomic, copy)   NSString * title;
@property (nonatomic, copy)   NSString * img_url;
@property (nonatomic, copy)   NSString * create_time;
@property (nonatomic, copy)   NSString * name;
@property (nonatomic, copy)   NSString * teacher_name;
@property (nonatomic, copy)   NSString * category_ico;
@end

@interface NewCourseList : NSObject

@property (nonatomic, strong) NSArray * this_month;

@property (nonatomic, strong) NSArray * last_month;
@end

@interface WYANewCourseModel : NSObject

@property (nonatomic, assign) CGFloat currentPage;
@property (nonatomic, assign) CGFloat totalPage;
@property (nonatomic, copy)   NSString * totalCount;
@property (nonatomic, strong) NewCourseList * list;

@end
