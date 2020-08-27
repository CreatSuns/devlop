//
//  WYATestPaperNetRequest.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/18.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYATestPaperNetRequest.h"
#import "WYATestPaperPeopleAndChapterModel.h"
#import "WYATestPaperModel.h"
#import "WYAMainPaperListModel.h"
#import "WYALevelPaperListModel.h"
@implementation WYATestPaperNetRequest

- (void)loadAllPerpleAndChapterWithParmas:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail{
    [WYATestPaperNetRequest GetWithUrl:AllPeopleAndChapter Params:params Success:^(id data) {
        NSLog(@"data==%@",data);
        WYATestPaperPeopleAndChapterModel * model = [WYATestPaperPeopleAndChapterModel yy_modelWithJSON:data[@"data"]];
        success(model);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        fail(netCode, errorDes);
    }];
}

- (void)loadTestPaperWithParams:(NSMutableDictionary *)params  Success:(Success)success Fail:(Fail)fail{
    [WYATestPaperNetRequest GetWithUrl:TestPaper Params:params Success:^(id data) {
        NSLog(@"data==%@",data);
        if ([params.allKeys containsObject:@"group_id"] || [params.allKeys containsObject:@"admin_user_id"]) {
            NSMutableArray * array = [WYALevelPaperListModel mainPaperListModelWith:data];
            success(array);
        }else{
            WYATestPaperModel * model = [WYATestPaperModel yy_modelWithJSON:data[@"data"]];
            success(model);
        }
        
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        fail(netCode, errorDes);
    }];
}
// 主账号测试试卷
- (void)loadMainTestPaperWithParams:(NSMutableDictionary *)params  Success:(Success)success Fail:(Fail)fail
{
    
    [WYATestPaperNetRequest GetWithUrl:TestPaper Params:params Success:^(id data) {
        NSLog(@"data==%@",data);
        NSMutableArray * array = [WYAMainPaperListModel mainPaperListModelWith:data];
        success(array);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        fail(netCode, errorDes);
    }];
}
@end
