//
//  WYANewCourseNetRequest.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/10.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYABaseNetRequest.h"

@interface WYANewCourseNetRequest : WYABaseNetRequest

/**
 获取新课上架数据

 @param params 参数
 @param success 成功
 @param fail 失败
 */
- (void)loadNewCourseWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail;

@end
