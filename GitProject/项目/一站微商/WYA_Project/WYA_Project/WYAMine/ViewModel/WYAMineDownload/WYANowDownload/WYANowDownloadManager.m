//
//  WYANowDownloadManager.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/25.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYANowDownloadManager.h"

#import "WYATableNameModel.h"

#import "SODownloader+WYAVideoDownload.h"

@interface WYANowDownloadManager ()

@end

@implementation WYANowDownloadManager



- (NSArray *)getDownloadingArray{
    NSArray * array = [[SODownloader videoDownloader]downloadArray];
    NSLog(@"array==%@",array);
    return array;
}


///**
// 删除下载数据改变状态上传服务器
//
// @param array 要删除的数据
// */
//- (void)deleteNetWorkNowDownloadFileWithArray:(NSArray *)array{
//    for (WYALocalDownloadModel * model in array) {
//        NSMutableDictionary * params  = [NSMutableDictionary dictionaryWithCapacity:0];
//        [params setObject:model.fileID forKey:@"iid"];
//        [params setObject:model.fileNumber forKey:@"type"];
//        [WYANowDownloadManager GetWithUrl:MineDELDownload Params:params Success:^(id data) {
//            NSLog(@"成功");
//        } Fail:^(NetRequestCode netCode, NSString *errorDes) {
//            
//        }];
//    }
//    
//}


- (void)changeDownloadStateWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail{
    [WYANowDownloadManager GetWithUrl:ChangeDownloadState Params:params Success:^(id data) {
        
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
    
@end
