//
//  WYASearchNetRequest.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/24.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYASearchNetRequest.h"
#import "WYASearchModel.h"
@implementation WYASearchNetRequest
- (void)searchRequestWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail
{
    [WYASearchNetRequest GetWithUrl:SearchUrl Params:params Success:^(id data) {
        WYASearchModel * model = [WYASearchModel searchModelWith:data];
        NSMutableArray * array = [NSMutableArray array];
        [array addObject:@[model.searchCourseArray,model.searchArticleArray,model.searchLectureArray]];
        [array addObject:model.searchCourseArray];
        [array addObject:model.searchArticleArray];
        [array addObject:model.searchLectureArray];
        success(array);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
@end
