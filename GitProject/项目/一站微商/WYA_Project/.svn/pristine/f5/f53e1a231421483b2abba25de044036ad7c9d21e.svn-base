//
//  WYAMineAdminInfoNetRequest.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/12.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMineAdminInfoNetRequest.h"
#import "WYAAdminInfoModel.h"
@implementation WYAMineAdminInfoNetRequest
- (void)mineAdminInfoWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail
{
    [WYAMineAdminInfoNetRequest GetWithUrl:AdminInfo Params:params Success:^(id data) {
        success([WYAAdminInfoModel AdminInfoModelWith:data]);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
@end
