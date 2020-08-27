//
//  WYACouresNetRequest.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/8.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYACouresNetRequest.h"
#import "WYACouresCategory.h"
#import "WYACouresListModel.h"
#import "WYACourseDetailModel.h"
#import "WYATableNameModel.h"
#import "WYALocalDownloadModel.h"
@interface WYACouresNetRequest ()



@end

@implementation WYACouresNetRequest

- (void)loadCouresCategoryWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail{
    [WYACouresNetRequest GetWithUrl:CourseCategory Params:params Success:^(id data) {
        NSLog(@"data==%@",data);
        id obj = data[@"data"];
        NSMutableArray * array = [NSMutableArray new];
        if ([obj isKindOfClass:[NSArray class]]) {
            for (NSDictionary * dic in obj) {
                WYACouresCategory * couresCategory = [WYACouresCategory yy_modelWithJSON:dic];
                [array addObject:couresCategory];
            }
        }else if ([obj isKindOfClass:[NSDictionary class]]) {
            
        }
        success(array);
        
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        NSLog(@"error==%@",errorDes);
    }];
}

- (void)loadCouresListWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail{
    [WYACouresNetRequest GetWithUrl:CourseList Params:params Success:^(id data) {
        NSLog(@"data==%@",data);
        WYACouresListModel * model = [WYACouresListModel yy_modelWithJSON:data[@"data"]];
        NSLog(@"model==%@",model);
        
        
        success(model);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}

- (void)loadCourseDetailWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail{
    
    [WYACouresNetRequest GetWithUrl:CourseDetail Params:params Success:^(id data) {
        NSLog(@"data==%@",data);
        WYACourseDetailModel * model = [WYACourseDetailModel yy_modelWithJSON:data[@"data"]];
        NSLog(@"model==%@",model);
        success(model);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        fail(netCode, errorDes);
    }];
}

- (void)loadCourseCollectionWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail{
    [WYACouresNetRequest GetWithUrl:CourseCollection Params:params Success:^(id data) {
        NSLog(@"data==%@",data);
        success(data);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        fail(netCode, errorDes);
    }];
}

- (void)changeLearnTimeWithParmas:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail{
    [WYACouresNetRequest GetWithUrl:changeLearnTime Params:params Success:^(id data) {
        success(data);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        fail(netCode, errorDes);
    }];
}

- (void)addLearnPeopleWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail{
    [WYACouresNetRequest GetWithUrl:addLearnPeople Params:params Success:^(id data) {
        success(data);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        fail(netCode, errorDes);
    }];
}

- (void)addMyLearnCourseWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail{
    [WYACouresNetRequest GetWithUrl:addMyLearnCourse Params:params Success:^(id data) {
        success(data);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        fail(netCode, errorDes);
    }];
}

@end
