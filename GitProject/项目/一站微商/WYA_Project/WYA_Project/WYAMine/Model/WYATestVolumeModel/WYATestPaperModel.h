//
//  WYATestPaperModel.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/19.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYATestPaperUserModel : NSObject

@property (nonatomic, copy) NSString * admin_user_id;
@property (nonatomic, copy) NSString * contact;
@property (nonatomic, copy) NSString * score;

@end

@interface WYATestPaperListModel : NSObject

@property (nonatomic, copy) NSString * paper_id;
@property (nonatomic, copy) NSString * group_id;
@property (nonatomic, copy) NSString * chapter_id;
@property (nonatomic, copy) NSString * group_name;
@property (nonatomic, copy) NSString * paper_name;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSArray * user;

@end

@interface WYATestPaperModel : NSObject

@property (nonatomic, copy) NSString * currentPage;

@property (nonatomic, copy) NSString * totalPage;
@property (nonatomic, strong) NSArray * list;
@end
