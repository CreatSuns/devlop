//
//  WYALecturerDetailsNetRequest.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/11.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYALecturerDetailsNetRequest.h"
#import "WYALecturerHeaderModel.h"
#import "WYAArticleListModel.h"
#import "WYACouresListModel.h"
@implementation WYALecturerDetailsNetRequest
- (void)lecturerDetailsWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail
{
    [WYALecturerDetailsNetRequest GetWithUrl:LecturerDetail Params:params Success:^(id data) {
        NSLog(@"讲师个人信息%@",data);
       
        WYALecturerHeaderModel * model = [WYALecturerHeaderModel LecturerHeaderViewModelWith:data];
        success(model);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
- (void)lecturerAllCourseWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail
{
    [WYALecturerDetailsNetRequest GetWithUrl:LecturerAllCourse Params:params Success:^(id data) {
        NSLog(@"data==%@",data);
        WYACouresListModel * model = [WYACouresListModel yy_modelWithJSON:data[@"data"]];
        NSLog(@"model==%@",model);
        success(model);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
- (void)lecturerAllArticleWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail
{
    [WYALecturerDetailsNetRequest GetWithUrl:LecturerAllArticle Params:params Success:^(id data) {
        NSLog(@"文章listdata==%@",data);
        NSMutableArray * array = [NSMutableArray array];
        array = [WYAArticleListModel articleListModelWith:data];
        success(array);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
- (void)lecturerAttentionWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail
{
    [WYALecturerDetailsNetRequest GetWithUrl:AttentionLecturer Params:params Success:^(id data) {
        NSString * status = data[@"status"];
        success(status);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
@end
