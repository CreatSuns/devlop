//
//  WYANewCourseNetRequest.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/10.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYANewCourseNetRequest.h"
#import "WYANewCourseModel.h"

@implementation WYANewCourseNetRequest

- (void)loadNewCourseWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail{
    [WYANewCourseNetRequest GetWithUrl:NewCourse Params:params Success:^(id data) {
        NSLog(@"data==%@",data);
        WYANewCourseModel * model = [WYANewCourseModel yy_modelWithJSON:data[@"data"]];
        NSLog(@"model==%@",model);
        success(model);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        fail(netCode, errorDes);
    }];
}

@end
