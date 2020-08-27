//
//  WYASearchCourseModel.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/24.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYASearchCourseModel : NSObject
@property (nonatomic, copy) NSString * learned;
@property (nonatomic, copy) NSString * teacher_name;
@property (nonatomic, copy) NSString * teacher_id;
@property (nonatomic, copy) NSString * title_name;
@property (nonatomic, copy) NSString * img_url;
@property (nonatomic, copy) NSString * course_title;
@property (nonatomic, copy) NSString * course_id;
@property(nonatomic, copy) NSString * count;
+ (NSMutableArray *)searchCourseModelWith:(id)resulte;
@end
