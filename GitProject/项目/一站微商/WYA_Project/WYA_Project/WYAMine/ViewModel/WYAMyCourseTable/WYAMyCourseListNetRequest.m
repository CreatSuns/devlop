//
//  WYAMyCourseListNetRequest.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/9.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMyCourseListNetRequest.h"
#import "WYAMyCourseListModel.h"
#import "WYATableNameModel.h"
#import "WYALocalDownloadModel.h"
@interface WYAMyCourseListNetRequest ()

@property (nonatomic, strong) JQFMDB * fmdb;

@end

@implementation WYAMyCourseListNetRequest

- (JQFMDB *)fmdb{
    if (!_fmdb) {
        _fmdb = [JQFMDB shareDatabase:FileDownload_DataBase path:[NSString downloadFilePath]];
    }
    return _fmdb;
}

- (void)loadMyCoureseListWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail{
    [WYAMyCourseListNetRequest GetWithUrl:MyCoureseList Params:params Success:^(id data) {
        
        WYAMyCourseListModel * model = [WYAMyCourseListModel yy_modelWithJSON:data[@"data"]];
        NSLog(@"data==%@",data);
        for (MyCourseList * list in model.list) {
            NSArray * downloadingArray = [self queryLocalDownloadingWithTableName:list.title];
            NSArray * downloadFinishArray = [self queryLocalDownloadFinishWithTableName:list.title];
            if (downloadFinishArray.count>0) {
                list.download_status = @"已下载";
            }else{
                if (downloadingArray.count>0) {
                    list.download_status = @"正在下载";
                }
            }
        }
        success(model);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        NSLog(@"error==%@",errorDes);
        fail(netCode, errorDes);
    }];
}

- (NSArray *)queryLocalDownloadFinishWithTableName:(NSString *)tableName{
    __block NSArray * array;
    [self.fmdb jq_inDatabase:^{
        array = [self.fmdb jq_lookupTable:tableName dicOrModel:[WYALocalDownloadModel class] whereFormat:@"WHERE fileState = 4"];
    }];
    
    return array;
}
- (NSArray *)queryLocalDownloadingWithTableName:(NSString *)tableName{
    
    __block NSArray * array;
    [self.fmdb jq_inDatabase:^{
        array = [self.fmdb jq_lookupTable:tableName dicOrModel:[WYALocalDownloadModel class] whereFormat:@"WHERE fileState = 2"];
    }];
    
    return array;

}
@end
