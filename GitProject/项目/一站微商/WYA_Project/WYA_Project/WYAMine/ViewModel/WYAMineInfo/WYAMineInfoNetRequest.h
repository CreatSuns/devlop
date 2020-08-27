//
//  WYAMineInfoNetRequest.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/20.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYABaseNetRequest.h"
#import "WYAAdminInfoModel.h"
@interface WYAMineInfoNetRequest : WYABaseNetRequest

- (NSArray *)loadMineInfoWithAdminInfo:(WYAAdminInfoModel *)model;

/**
 上传用户头像

 @param image 图片
 @param success 成功
 @param fail 失败
 */
- (void)uploadHeadImage:(UIImage *)image Success:(Success)success Fail:(Fail)fail;

/**
 上传用户昵称

 @param nickName 昵称
 @param success 成功
 @param fail 失败
 */
- (void)updateUserNickName:(NSString *)nickName Success:(Success)success Fail:(Fail)fail;

/**
 修改用户密码

 @param params 参数
 @param success 成功
 @param fail 失败
 */
- (void)changerPasswordWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail;
@end
