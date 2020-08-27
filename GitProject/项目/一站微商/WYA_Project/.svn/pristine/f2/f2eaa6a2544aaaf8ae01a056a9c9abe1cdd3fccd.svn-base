//
//  WYAFinishDownloadManager.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/27.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAFinishDownloadManager.h"
#import "WYALocalDownloadModel.h"
#import "WYATableNameModel.h"
#import "SODownloader+WYAVideoDownload.h"
@interface WYAFinishDownloadManager ()

@property (nonatomic, strong) JQFMDB * fmdb;

@end

@implementation WYAFinishDownloadManager

- (JQFMDB *)fmdb{
    if (!_fmdb) {
        _fmdb = [JQFMDB shareDatabase:FileDownload_DataBase path:[NSString downloadFilePath]];
    }
    return _fmdb;
}

- (NSArray *)getFinishDownloadFileWithTableName:(NSString *)tableName{
    __block NSArray * array;
    [self.fmdb jq_inDatabase:^{
        array = [self.fmdb jq_lookupTable:tableName dicOrModel:[WYALocalDownloadModel class] whereFormat:@"WHERE fileState = 4"];
    }];
    return array;
}

- (void)deleteNowDownloadFile:(NSMutableArray *)deleteArray TableName:(NSString *)tableName{
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSArray * tableArray = [self.fmdb jq_lookupTable:tableName dicOrModel:[WYALocalDownloadModel class] whereFormat:@"WHERE fileState = 4"];
    if (tableArray.count>0) {
        for (WYALocalDownloadModel * model in tableArray) {
            for (WYALocalDownloadModel * deleteModel in deleteArray) {
                if ([model.fileID isEqualToString:deleteModel.fileID]) {
                    
                    [self.fmdb jq_inDatabase:^{
                        BOOL abc = [self.fmdb jq_deleteTable:tableName whereFormat:[NSString stringWithFormat:@"WHERE findModel = '%@'",model.findModel]];
                        NSLog(@"abc==%d",abc);
                    }];
                    
                    BOOL aa = [fileManager fileExistsAtPath:deleteModel.fileLocalurl];
                    BOOL state;
                    if (aa) {
                        state = [fileManager removeItemAtPath:deleteModel.fileLocalurl error:nil];
                    }
                    
//                    if ([deleteModel.fileNumber isEqualToString:@"2"]) {
//                        BOOL ss = [[SODownloader videoDownloader] isControlDownloadFlowForItem:deleteModel];
//                        if (ss == YES) {
//                            [[SODownloader videoDownloader] removeCompletedItem:deleteModel];
//                        }
//                        BOOL aa = [fileManager fileExistsAtPath:[model.savePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//                        BOOL state;
//                        if (aa) {
//                            state = [fileManager removeItemAtPath:[model.savePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] error:nil];
//                        }
//
//                    }else if ([model.fileNumber isEqualToString:@"3"]){
//
//
//                    }
                    
                    
                    NSArray * tableA = [self.fmdb jq_lookupTable:tableName dicOrModel:[WYALocalDownloadModel class] whereFormat:@"WHERE fileState = 4"];
                    if (tableA.count == 0) {
                        [self.fmdb jq_inDatabase:^{
                            [self.fmdb jq_updateTable:FileDownload_TableName dicOrModel:@{@"haveDownloadChapter":@"0"} whereFormat:[NSString stringWithFormat:@"WHERE tableName = '%@'",tableName]];
                        }];
                    }
                    
                }
            }
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:WYAFINISHDOWNLOADDELETEFILE object:nil];
    }
    
    
    
}

@end
