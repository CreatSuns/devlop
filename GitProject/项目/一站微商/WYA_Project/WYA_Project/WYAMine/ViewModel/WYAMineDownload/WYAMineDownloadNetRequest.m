//
//  WYAMineDownloadNetRequest.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/20.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMineDownloadNetRequest.h"
#import "WYAMineDownloadModel.h"
#import "WYATableNameModel.h"
#import "WYALocalDownloadModel.h"
@implementation WYAMineDownloadNetRequest

- (JQFMDB *)fmdb{
    if (!_fmdb) {
        _fmdb = [JQFMDB shareDatabase:FileDownload_DataBase path:[NSString downloadFilePath]];
    }
    return _fmdb;
}

- (void)loadMineDownloadFileWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail{
    [WYAMineDownloadNetRequest GetWithUrl:MineDownload Params:params Success:^(id data) {
        NSLog(@"data==%@",data);
        WYAMineDownloadModel * model = [WYAMineDownloadModel yy_modelWithJSON:data[@"data"]];
        success(model);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        fail(netCode, errorDes);
    }];
}



- (NSArray *)getFinishDownloadFileArray{
    NSArray * array = [self.fmdb jq_lookupTable:FileDownload_TableName dicOrModel:[WYATableNameModel class] whereFormat:@"WHERE haveDownloadChapter = 1"];

    return array;
}

@end
