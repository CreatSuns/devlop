//
//  WYATestScoresNetRequest.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/18.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYABaseNetRequest.h"

@interface WYATestScoresNetRequest : WYABaseNetRequest

/**
 获取测试成绩

 @param params 参数
 @param success 成功
 @param fail 失败
 */
- (void)loadTestScoresWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail;
@end
