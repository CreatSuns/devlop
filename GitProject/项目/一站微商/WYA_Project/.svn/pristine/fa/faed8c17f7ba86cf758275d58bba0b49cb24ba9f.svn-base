//
//  WYAMineInfoNetRequest.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/20.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMineInfoNetRequest.h"
#import "WYAMineInfoModel.h"

@implementation WYAMineInfoNetRequest

- (NSArray *)loadMineInfoWithAdminInfo:(WYAAdminInfoModel *)model{
    WYAMineInfoModel * model1 = [[WYAMineInfoModel alloc]initWithTitle:@"头像" headImage:model.shop_logo Subtitle:nil];
    WYAMineInfoModel * model2 = [[WYAMineInfoModel alloc]initWithTitle:@"用户名" headImage:nil Subtitle:model.user_name];
    WYAMineInfoModel * model3 = [[WYAMineInfoModel alloc]initWithTitle:@"昵称" headImage:nil Subtitle:model.account];
    WYAMineInfoModel * model4 = [[WYAMineInfoModel alloc]initWithTitle:@"账号密码" headImage:nil Subtitle:@"修改"];
    NSArray * array1 = @[model1];
    NSArray * array2 = @[model2, model3, model4];
    NSArray * array = @[array1, array2];
    return array;
}

- (void)uploadHeadImage:(UIImage *)image Success:(Success)success Fail:(Fail)fail{
    [WYAMineInfoNetRequest UploadImageWithUrl:UploadHeaderImage params:nil Images:@[image] progress:^(float progress) {
        
    } Success:^(id data) {
        NSLog(@"data==%@",data);
        [self uploadHeadImageUrlString:data[@"data"][@"url"] Success:^(id data) {
            NSLog(@"data==%@",data);
            success(data);
            
        } Fail:^(NetRequestCode netCode, NSString *errorDes) {
            fail(netCode, errorDes);
        }];
        
        
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        fail(netCode, errorDes);
    }];
}

- (void)uploadHeadImageUrlString:(NSString *)imageString Success:(Success)success Fail:(Fail)fail{
    NSMutableDictionary * params = [NSMutableDictionary new];
    [params setObject:imageString forKey:@"shop_logo"];
    
    [WYAMineInfoNetRequest GetWithUrl:UploadHeaderImageString Params:params Success:^(id data) {
        NSLog(@"data==%@",data);
        success(data);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        fail(netCode, errorDes);
    }];
}

- (void)updateUserNickName:(NSString *)nickName Success:(Success)success Fail:(Fail)fail{
    NSMutableDictionary * params = [NSMutableDictionary new];
    [params setObject:nickName forKey:@"account"];
    [WYAMineInfoNetRequest GetWithUrl:UpdateNickName Params:params Success:^(id data) {
        NSLog(@"data==%@",data);
        success(data);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        fail(netCode, errorDes);
    }];
}

- (void)changerPasswordWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail{
    
    [WYAMineInfoNetRequest GetWithUrl:ChangePassword Params:params Success:^(id data) {
        NSLog(@"data==%@",data);
        success(data);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        fail(netCode, errorDes);
    }];
}
@end
