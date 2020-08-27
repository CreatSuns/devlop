//
//  WYAAdminInfoModel.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/12.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAAdminInfoModel.h"

@implementation WYAAdminInfoModel
+ (id)AdminInfoModelWith:(id)response
{
    NSDictionary * dic = response[@"data"];
    WYAAdminInfoModel * model = [[WYAAdminInfoModel alloc]init];
    model.user_name = checkString(dic[@"user_name"]);
    model.account = checkString(dic[@"account"]);
    model.shop_logo = [checkString(dic[@"shop_logo"]) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    model.study_time = checkString(dic[@"study_time"]);
    
    return model;
}
@end
