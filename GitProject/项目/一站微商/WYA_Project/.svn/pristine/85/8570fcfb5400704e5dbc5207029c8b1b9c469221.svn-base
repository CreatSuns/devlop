//
//  WYAOpinionNetRequest.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/9.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAOpinionNetRequest.h"

@implementation WYAOpinionNetRequest

- (void)submitOpinionWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail{
    
    [WYAOpinionNetRequest GetWithUrl:SubmitOpinion Params:params Success:^(id data) {
        success(data);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        fail(netCode, errorDes);
    }];
}

@end
