//
//  WYALecturerNetRequest.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/9.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYABaseNetRequest.h"

@interface WYALecturerNetRequest : WYABaseNetRequest
/**
 * 获取教师列表数据
 */
- (void)lecturerListDataWithParams:(NSMutableDictionary *)params
                           Success:(Success)success
                              Fail:(Fail)fail;
@end
