//
//  WYATestPaperNetRequest.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/18.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYABaseNetRequest.h"

@interface WYATestPaperNetRequest : WYABaseNetRequest

/**
 获取所有人员和章节

 @param params 参数
 @param success 成功
 @param fail 失败
 */
- (void)loadAllPerpleAndChapterWithParmas:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail;

/**
 获取测试试卷

 @param params 参数
 @param success 成功
 @param fail 失败
 */
- (void)loadTestPaperWithParams:(NSMutableDictionary *)params  Success:(Success)success Fail:(Fail)fail;


/**
 获取主账号测试试卷
 
 @param params 参数
 @param success 成功
 @param fail 失败
 */
- (void)loadMainTestPaperWithParams:(NSMutableDictionary *)params  Success:(Success)success Fail:(Fail)fail;
@end
