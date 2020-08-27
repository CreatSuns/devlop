//
//  WYAFMDBManager.m
//  WYA_Project
//
//  Created by 李世航 on 2018/5/22.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAFMDBManager.h"
#import "SODownloader+WYAVideoDownload.h"
@interface WYAFMDBManager ()



@end

@implementation WYAFMDBManager

+(instancetype)shardFmdbManager{
    static WYAFMDBManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[WYAFMDBManager alloc]init];
    });
    return manager;
}

+ (JQFMDB *)fmdb{
    JQFMDB * jq = [JQFMDB shareDatabase:FileDownload_DataBase path:[NSString downloadFilePath]];
    return jq;
}

-(void)saveDownloadInfoWithModel:(WYALocalDownloadModel *)model{
//    JQFMDB * fmdb = [self fmdb];
//    [fmdb jq_inDatabase:^{
//        NSInteger state;
//        switch (model.so_downloadState) {
//            case SODownloadStateComplete:
//                state = 4;
//                break;
//            case SODownloadStateError:
//                state = 5;
//                break;
//            default:
//                break;
//        }
//        BOOL flag = [fmdb jq_updateTable:model.fmdb_name dicOrModel:@{@"fileState":[NSNumber numberWithInteger:4]} whereFormat:[NSString stringWithFormat:@"WHERE findModel = '%@'",model.findModel]];
//        [fmdb jq_updateTable:FileDownload_TableName dicOrModel:@{@"haveDownloadChapter":@"1"} whereFormat:[NSString stringWithFormat:@"WHERE tableName = '%@'",model.fmdb_name]];
//        NSLog(@"flag==%d",flag);
//    }];
}


+ (void)save:(WYALocalDownloadModel *)model{
    JQFMDB * fmdb = [WYAFMDBManager fmdb];
    [fmdb jq_inDatabase:^{
        NSInteger state = 0;
        switch (model.so_downloadState) {
                case SODownloadStateNormal:
                state = 0;
                break;
                case SODownloadStateWait:
                state = 1;
                break;
            case SODownloadStatePaused:
                state = 3;
                break;
            case SODownloadStateLoading:
                state = 2;
                break;
            case SODownloadStateComplete:
                
                state = 4;
                break;
            case SODownloadStateError:
                state = 5;
                break;
            default:
                break;
        }

        NSArray * arr = [fmdb jq_lookupTable:model.fmdb_name dicOrModel:[WYALocalDownloadModel class] whereFormat:[NSString stringWithFormat:@"WHERE findModel = '%@'",model.findModel]];
        if (arr.count>1) {
            [fmdb jq_deleteTable:model.fmdb_name whereFormat:[NSString stringWithFormat:@"WHERE findModel = '%@' and pkid not in (select max(pkid) from %@ where findModel = '%@')",model.findModel,model.fmdb_name,model.findModel]];
        }else{
            [fmdb jq_updateTable:model.fmdb_name dicOrModel:@{@"fileState":[NSNumber numberWithInteger:state]} whereFormat:[NSString stringWithFormat:@"WHERE findModel = '%@'",model.findModel]];
        }
        if (state == 4) {
            [fmdb jq_updateTable:FileDownload_TableName dicOrModel:@{@"haveDownloadChapter":@"1"} whereFormat:[NSString stringWithFormat:@"WHERE tableName = '%@'",model.fmdb_name]];
        }
        
        
    }];
}

+(void)deleteLocalModel:(WYALocalDownloadModel *)model{
    JQFMDB * fmdb = [WYAFMDBManager fmdb];
    [fmdb jq_inDatabase:^{
        [fmdb jq_deleteTable:model.fmdb_name whereFormat:[NSString stringWithFormat:@"WHERE findModel = '%@'",model.findModel]];
    }];
}

+ (NSMutableArray *)downloadingMusicArrayInDB{
    JQFMDB * fmdb = [WYAFMDBManager fmdb];
    __block NSMutableArray * dataArray = [NSMutableArray arrayWithCapacity:0];
    [fmdb jq_inDatabase:^{
        NSArray * arr = [fmdb jq_lookupTable:FileDownload_TableName dicOrModel:[WYATableNameModel class] whereFormat:nil];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            WYATableNameModel * tableModel = (WYATableNameModel *)obj;
            NSArray * videoArray = [fmdb jq_lookupTable:tableModel.tableName dicOrModel:[WYALocalDownloadModel class] whereFormat:@"WHERE fileState = '2'"];
            NSArray * videoa = [fmdb jq_lookupTable:tableModel.tableName dicOrModel:[WYALocalDownloadModel class] whereFormat:@"WHERE fileState = '1'"];
            [dataArray addObjectsFromArray:videoArray];
            [dataArray addObjectsFromArray:videoa];
        }];
    }];
    return dataArray;
    
}

+ (NSMutableArray *)pausedMusicArrayInDB{
    JQFMDB * fmdb = [WYAFMDBManager fmdb];
    __block NSMutableArray * dataArray = [NSMutableArray arrayWithCapacity:0];
    [fmdb jq_inDatabase:^{
        NSArray * arr = [fmdb jq_lookupTable:FileDownload_TableName dicOrModel:[WYATableNameModel class] whereFormat:nil];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            WYATableNameModel * tableModel = (WYATableNameModel *)obj;
            NSArray * videoArray = [fmdb jq_lookupTable:tableModel.tableName dicOrModel:[WYALocalDownloadModel class] whereFormat:@"WHERE fileState = '3'"];
            [dataArray addObjectsFromArray:videoArray];
        }];
    }];
    return dataArray;
}

+ (NSMutableArray *)complatedMusicArrayInDB {
    JQFMDB * fmdb = [WYAFMDBManager fmdb];
    __block NSMutableArray * dataArray = [NSMutableArray arrayWithCapacity:0];
    [fmdb jq_inDatabase:^{
        NSArray * arr = [fmdb jq_lookupTable:FileDownload_TableName dicOrModel:[WYATableNameModel class] whereFormat:nil];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            WYATableNameModel * tableModel = (WYATableNameModel *)obj;
            NSArray * videoArray = [fmdb jq_lookupTable:tableModel.tableName dicOrModel:[WYALocalDownloadModel class] whereFormat:@"WHERE fileState = '4'"];
            [dataArray addObjectsFromArray:videoArray];
        }];
    }];
    return dataArray;
}

@end
