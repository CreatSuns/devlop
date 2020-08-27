//
//  WYATestScoresNetRequest.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/18.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYATestScoresNetRequest.h"
#import "WYAMineTestScoresModel.h"
@implementation WYATestScoresNetRequest

- (void)loadTestScoresWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail{
    [WYATestScoresNetRequest GetWithUrl:TestScorse Params:params Success:^(id data) {
        NSLog(@"data==%@",data);
        WYAMineTestScoresModel * model = [WYAMineTestScoresModel yy_modelWithJSON:data[@"data"]];
        success(model);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        fail(netCode, errorDes);
    }];
}

@end
