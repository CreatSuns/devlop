//
//  WYAMineCollectionCourseModel.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/16.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYAMineCollectionCourseListModel : NSObject

@property (nonatomic, copy) NSString * course_id;

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * img_url;

@property (nonatomic, copy) NSString * status;

@property (nonatomic, copy) NSString * process;

@property (nonatomic, copy) NSString * total_process;

@end

@interface WYAMineCollectionCourseModel : NSObject

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, assign) NSInteger totalPage;

@property (nonatomic, copy)   NSString * totalCount;

@property (nonatomic, strong) NSArray * list;

@end
