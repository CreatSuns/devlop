//
//  WYALoginNetRequest.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/8.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYABaseNetRequest.h"

@interface WYALoginNetRequest : WYABaseNetRequest

/**
 登录

 @param params 参数
 @param success 成功
 @param fail 失败
 */
-(void)loginWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail;

@end
