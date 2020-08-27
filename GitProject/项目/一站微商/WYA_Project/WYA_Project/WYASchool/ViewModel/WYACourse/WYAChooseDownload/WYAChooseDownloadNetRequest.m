//
//  WYAChooseDownloadNetRequest.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/25.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAChooseDownloadNetRequest.h"
#import "WYAChooseDownloadMolde.h"
#import "WYAChooseDownloadMolde.h"

#import "WYALocalDownloadModel.h"
#import "WYATableNameModel.h"

#import "SODownloader+WYAVideoDownload.h"


@interface WYAChooseDownloadNetRequest ()

@property (nonatomic, strong) dispatch_queue_t globalQueue;

@property (nonatomic, strong) SODownloader * downloadManager;

@end

@implementation WYAChooseDownloadNetRequest

-(SODownloader *)downloadManager{
    if (!_downloadManager) {
        _downloadManager = [SODownloader videoDownloader];
    }
    return _downloadManager;
}

- (void)loadChapterDownloadWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail{
    [WYAChooseDownloadNetRequest GetWithUrl:ChapterDownload Params:params Success:^(id data) {
//        NSLog(@"data==%@",data);
        WYAChooseDownloadMolde * model = [WYAChooseDownloadMolde yy_modelWithJSON:data];
        for (WYAChooseGroupModel * groupModel in model.data) {
            groupModel.flag = YES;
        }
        success(model);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        fail(netCode, errorDes);
    }];
}

//- (void)createTableDataBaseWithName:(NSString *)dbName{
//    self.fmdbName = dbName;
//    //1.建表
//    if ([self.fmdb jq_isExistTable:dbName] == NO) {
//        BOOL aa = [self.fmdb jq_createTable:dbName dicOrModel:[WYALocalDownloadModel class]];
//        NSLog(@"aa==%d",aa);
//        WYATableNameModel * model = [[WYATableNameModel alloc] init];
//        model.tableName = dbName;
//        [self.fmdb jq_insertTable:FileDownload_TableName dicOrModel:model];
//    }
//}

- (void)startDownloadFileWithfileArray:(NSMutableArray *)fileArray
                              CourseID:(NSString *)course_id
                             TableName:(NSString *)tableName
                             GroupName:(NSString *)groupName
{
    
    if (!tableName) {
        return;
    }
    NSLog(@"filep==%@",[NSString downloadFilePath]);
    NSMutableArray * array = [NSMutableArray array];
    for (WYAChooseChapterModel * model in fileArray) {
        WYALocalDownloadModel * videoModel = [[WYALocalDownloadModel alloc]init];

        videoModel.fileName = [NSString stringWithFormat:@"%@%@",model.chapter_id,VideoType];
        videoModel.fileUrl = [model.video_url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        videoModel.videoName = model.chapter_title;
        videoModel.fileSize = model.video_size;
        videoModel.course_title = tableName;

        videoModel.fileType = [model.video_url pathExtension];
        videoModel.fileNumber = VideoType;
        videoModel.fileID = model.chapter_id;
        videoModel.findModel = [NSString stringWithFormat:@"%@_%@",model.chapter_id,VideoType];
        videoModel.fmdb_name = tableName;
        videoModel.course_id = course_id;
        videoModel.fileLocalurl = videoModel.savePath;
        
        [array addObject:videoModel];
        JQFMDB * fmdb = [JQFMDB shareDatabase:FileDownload_DataBase path:[NSString downloadFilePath]];
        BOOL aa = [fmdb jq_insertTable:tableName dicOrModel:videoModel];
        if ([model.download_status isEqualToString:@"yes"]) {
            [self.downloadManager resumeItem:videoModel];
        }else{
            [self.downloadManager downloadItem:videoModel autoStartDownload:YES];
        }
        
    }
    
    
}

//- (void)changeDownloadStateWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail{
//    [WYAChooseDownloadNetRequest GetWithUrl:ChangeDownloadState Params:params Success:^(id data) {
//
//    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
//
//    }];
//}

- (NSArray *)findLocalArrayModelWithTableName:(NSString *)tableName{
//    JQFMDB * fmdb = [JQFMDB shareDatabase:FileDownload_DataBase path:[NSString downloadFilePath]];
    JQFMDB * fmdb = [[JQFMDB alloc]initWithDBName:FileDownload_DataBase path:[NSString downloadFilePath]];
    NSString * string = FileDownload_DataBase;
    NSArray * array = [fmdb jq_lookupTable:tableName dicOrModel:[WYALocalDownloadModel class] whereFormat:nil];
//    NSLog(@"array==%@",array);
    return array;
}


- (NSArray *)findLocalStateChangeArrayWithTableName:(NSString *)tableName{
//    JQFMDB * fmdb = [JQFMDB shareDatabase:FileDownload_DataBase path:[NSString downloadFilePath]];
    JQFMDB * fmdb = [[JQFMDB alloc]initWithDBName:FileDownload_DataBase path:[NSString downloadFilePath]];
    NSArray * array = [fmdb jq_lookupTable:tableName dicOrModel:[WYALocalDownloadModel class] whereFormat:@"WHERE fileState != 0"];
//    NSLog(@"array==%@",array);
    return array;
}

@end

