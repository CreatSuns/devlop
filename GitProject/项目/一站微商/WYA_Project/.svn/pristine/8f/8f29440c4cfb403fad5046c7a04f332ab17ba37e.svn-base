//
//  WYALecturerNetRequest.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/9.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYALecturerNetRequest.h"
#import "WYALecturerModel.h"
@implementation WYALecturerNetRequest
- (void)lecturerListDataWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail
{
    [WYALecturerNetRequest GetWithUrl:LecturerList Params:params Success:^(id data) {
         NSLog(@"讲师列表data==%@",data);
         NSMutableArray * array = [NSMutableArray array];
         array = [WYALecturerModel LecturerModelWith:data];
         success(array);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
         NSLog(@"error==%@",errorDes);
    }];
}
@end
