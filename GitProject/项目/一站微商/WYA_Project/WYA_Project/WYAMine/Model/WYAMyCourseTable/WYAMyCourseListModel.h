//
//  WYAMyCourseListModel.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/10.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyCourseList : NSObject

@property (nonatomic, copy) NSString * course_id;
@property (nonatomic, copy) NSString * img_url;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, assign) float process;
//@property (nonatomic, copy) NSString * download;
@property (nonatomic, copy) NSString * teacher_name;
@property (nonatomic, copy) NSString * total_process;
@property (nonatomic, copy) NSString * download_status;
@end

@interface WYAMyCourseListModel : NSObject

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger totalPage;
@property (nonatomic, copy) NSString * totalCount;
@property (nonatomic, strong) NSArray * list;

@end
