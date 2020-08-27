//
//  WYAAttentionNetRequest.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/12.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAAttentionNetRequest.h"
#import "WYAAttentionModel.h"
@implementation WYAAttentionNetRequest
- (void)mineAttentionWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail
{
    [WYAAttentionNetRequest GetWithUrl:Attention Params:params Success:^(id data) {
        NSMutableArray * array = [NSMutableArray array];
        array = [WYAAttentionModel attentionModelWith:data];
        success(array);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
- (void)cancleAttentionWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail
{
    [WYAAttentionNetRequest GetWithUrl:CancelAttention Params:params Success:^(id data) {
        success(data[@"status"]);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
@end
