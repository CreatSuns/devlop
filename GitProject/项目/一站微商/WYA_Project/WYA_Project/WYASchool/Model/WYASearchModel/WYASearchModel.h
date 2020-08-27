//
//  WYASearchModel.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/24.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYASearchModel : NSObject
@property(nonatomic, strong) NSMutableArray * searchArticleArray;
@property(nonatomic, strong) NSMutableArray * searchCourseArray;
@property(nonatomic, strong) NSMutableArray * searchLectureArray;
+ (instancetype)searchModelWith:(id)respone;
@end

