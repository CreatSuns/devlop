//
//  WYATestScoresModel.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/18.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYAMineTestScoresListModel : NSObject

@property (nonatomic, copy) NSString * course_id;

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * img_url;

@property (nonatomic, copy) NSString * all_count;

@property (nonatomic, copy) NSString * user_count;

@property (nonatomic, copy) NSString * number;

@end

@interface WYAMineTestScoresModel : NSObject

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, assign) NSInteger totalPage;

@property (nonatomic, copy)   NSString * totalCount;

@property (nonatomic, strong) NSArray * list;

@end
