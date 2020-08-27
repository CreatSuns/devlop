//
//  WYAAdminInfoModel.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/12.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYAAdminInfoModel : NSObject
@property(nonatomic, copy) NSString * user_name;//用户名
@property(nonatomic, copy) NSString * account;//账号（昵称）
@property(nonatomic, copy) NSString * shop_logo;//头像
@property(nonatomic, copy) NSString * study_time;//学习时长
+ (id)AdminInfoModelWith:(id)response;
@end
