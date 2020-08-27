//
//  WYALecturerDetailsNetRequest.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/11.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYABaseNetRequest.h"

@interface WYALecturerDetailsNetRequest : WYABaseNetRequest
/**
 * 获取讲师个人数据
 */
- (void)lecturerDetailsWithParams:(NSMutableDictionary *)params
                           Success:(Success)success
                              Fail:(Fail)fail;
/**
 * 获取讲师所有课程
 */
- (void)lecturerAllCourseWithParams:(NSMutableDictionary *)params
                          Success:(Success)success
                             Fail:(Fail)fail;
/**
 * 获取讲师所有文章
 */
- (void)lecturerAllArticleWithParams:(NSMutableDictionary *)params
                          Success:(Success)success
                             Fail:(Fail)fail;

/**
 * 关注/取消关注讲师个人
 */
- (void)lecturerAttentionWithParams:(NSMutableDictionary *)params
                            Success:(Success)success
                               Fail:(Fail)fail;
@end
