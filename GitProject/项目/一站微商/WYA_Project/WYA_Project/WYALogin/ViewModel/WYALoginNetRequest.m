//
//  WYALoginNetRequest.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/8.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYALoginNetRequest.h"
#import "WYAUserModel.h"
#import "WYAUserInfo.h"
#import "WYATableNameModel.h"
#import "SODownloader+WYAVideoDownload.h"
@interface WYALoginNetRequest ()

@end

@implementation WYALoginNetRequest


-(void)loginWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail{
    [WYALoginNetRequest PostWithUrl:LoginUrl Params:params Success:^(id data) {
        
        NSLog(@"data==%@",data);
        WYAUserModel * model = [WYAUserModel yy_modelWithJSON:data[@"data"]];
        NSLog(@"model==%@",model);
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:data[@"data"][@"access_token"] forKey:@"access_token"];
        [userDefaults setObject:data[@"data"][@"admin_user_id"] forKey:@"admin_user_id"];
        [userDefaults setObject:data[@"data"][@"role_id"] forKey:@"role_id"];
        [userDefaults synchronize];
        
        NSFileManager * fileManager = [NSFileManager defaultManager];
        BOOL isDir = NO;
        
        // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
        BOOL existed = [fileManager fileExistsAtPath:[NSString downloadFilePath] isDirectory:&isDir];
        
        if (!(isDir && existed)) {
            // 在downloadFilePath目录下创建一个目录
            [fileManager createDirectoryAtPath:[NSString downloadFilePath] withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        BOOL isDirCopy = NO;
        BOOL existedCopy = [fileManager fileExistsAtPath:[NSString downloadVideoPath] isDirectory:&isDir];
        
        if (!(isDirCopy && existedCopy)) {
            // 在downloadVideoPath目录下创建一个目录
            [fileManager createDirectoryAtPath:[NSString downloadVideoPath] withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSString * fmdbPath = [[NSString downloadFilePath] stringByAppendingPathComponent:FileDownload_DataBase];
        if (![fileManager fileExistsAtPath:fmdbPath]) {
            JQFMDB * fmdb = [[JQFMDB alloc]initWithDBName:FileDownload_DataBase path:[NSString downloadFilePath]];
            if ([fmdb jq_isExistTable:FileDownload_TableName] == NO) {
                BOOL aa = [fmdb jq_createTable:FileDownload_TableName dicOrModel:[WYATableNameModel class]];
                NSLog(@"aa==%d",aa);
            }
        }
        
        //启用下载器
        [SODownloader videoDownloader];
        success(data);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        fail(netCode, errorDes);
        NSLog(@"errorDes==%@",errorDes);
    }];
}


@end
