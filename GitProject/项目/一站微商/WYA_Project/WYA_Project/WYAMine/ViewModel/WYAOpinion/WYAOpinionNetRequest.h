//
//  WYAOpinionNetRequest.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/9.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYABaseNetRequest.h"

@interface WYAOpinionNetRequest : WYABaseNetRequest

- (void)submitOpinionWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail;

@end
