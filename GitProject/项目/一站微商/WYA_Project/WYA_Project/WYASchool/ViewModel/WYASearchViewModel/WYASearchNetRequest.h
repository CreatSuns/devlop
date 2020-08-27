//
//  WYASearchNetRequest.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/24.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYABaseNetRequest.h"

@interface WYASearchNetRequest : WYABaseNetRequest
/**
 搜索
 
 @param params 参数
 @param success 成功
 @param fail 失败
 */
- (void)searchRequestWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail;
@end
