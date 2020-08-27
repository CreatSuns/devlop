//
//  WYAMineCollectionNetRequest.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/16.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMineCollectionNetRequest.h"
#import "WYAMineCollectionCourseModel.h"
#import "WYAMineCollectionArticleModel.h"

@implementation WYAMineCollectionNetRequest

- (void)loadMineCollectionCourseWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail{
    [WYAMineCollectionNetRequest GetWithUrl:MineCollectionCourse Params:params Success:^(id data) {
        NSLog(@"data==%@",data);
        WYAMineCollectionCourseModel * model = [WYAMineCollectionCourseModel yy_modelWithJSON:data[@"data"]];
        success(model);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        fail(netCode, errorDes);
    }];
}

- (void)loadMineCollectionArticleWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail{
    [WYAMineCollectionNetRequest GetWithUrl:MineCollectionArticle Params:params Success:^(id data) {
        WYAMineCollectionArticleModel * model = [WYAMineCollectionArticleModel yy_modelWithJSON:data[@"data"]];
        success(model);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        fail(netCode, errorDes);
    }];
}

- (void)deleteMineCollectionWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail{
    
//    [WYAMineCollectionNetRequest PostWithUrl:DeleteMineCollection Params:params Success:^(id data) {
//        success(data[@"msg"]);
//    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
//        fail(netCode, errorDes);
//    }];
    
    [WYAMineCollectionNetRequest GetWithUrl:DeleteMineCollection Params:params Success:^(id data) {
        success(data[@"msg"]);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        fail(netCode, errorDes);
    }];
}

@end
