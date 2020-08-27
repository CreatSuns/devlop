//
//  WYACourseDownloadNetRequest.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/14.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYACourseDownloadNetRequest.h"
#import "WYACourseDownloadModel.h"
#import "WYALocalDownloadModel.h"

@interface WYACourseDownloadNetRequest ()

@property (nonatomic, strong) JQFMDB * fmdb;

@end

@implementation WYACourseDownloadNetRequest

- (JQFMDB *)fmdb{
    if (!_fmdb) {
        _fmdb = [JQFMDB shareDatabase:FileDownload_DataBase path:[NSString downloadFilePath]];
    }
    return _fmdb;
}

- (void)loadCourseDownloadWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail{
    [WYACourseDownloadNetRequest GetWithUrl:CourseDownload Params:params Success:^(id data) {
        NSLog(@"data==%@",data);
        id obj = data[@"data"];
        
        if ([obj isKindOfClass:[NSArray class]]) {
            NSMutableArray * array = [NSMutableArray new];
            for (id dic in obj) {
                WYACourseDownloadModel * model = [WYACourseDownloadModel yy_modelWithJSON:dic];
                [array addObject:model];
            }
            success(array);
        }
        
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        NSLog(@"error==%@",errorDes);
    }];
}

- (NSURLSessionDownloadTask *)downLoadCourseFileWithUrl:(NSString *)urlString
                                                 Params:(NSMutableDictionary *)params
                                               FileName:(NSString *)fileName
                                               progress:(Progress)fileProgress
                                                Success:(Success)success
                                                   Fail:(Fail)fail{
    //先改变下载状态
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:params];
    [dic setObject:classType forKey:@"type"];
    [dic setObject:@"1" forKey:@"status"];
    [self changeDownloadFileStateWithParams:dic Success:^(id data) {
        
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
    
    NSString * filePath = [[NSString downloadVideoPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",[[fileName lastPathComponent] stringByDeletingPathExtension],[urlString pathExtension]]];
    NSURLSessionDownloadTask * task = [WYACourseDownloadNetRequest DownLoadFileWithUrl:urlString Params:params FilePath:filePath progress:^(float progress) {
        fileProgress(progress);
    } Success:^(id data) {
//        NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:params];
//        [dic setObject:classType forKey:@"type"];
//        [dic setObject:@"2" forKey:@"status"];
//        [self changeDownloadFileStateWithParams:dic Success:^(id data) {
//
//        } Fail:^(NetRequestCode netCode, NSString *errorDes) {
//
//        }];
        success(data);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        fail(netCode, errorDes);
    }];
    
    return task;
}

- (void)changeDownloadFileStateWithParams:(NSMutableDictionary *)params
                                  Success:(Success)success
                                     Fail:(Fail)fail
{
    [WYACourseDownloadNetRequest GetWithUrl:ChangeDownloadState Params:params Success:^(id data) {
        
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}

- (void)storageFileWithModel:(WYACourseDownloadModel *)model TableName:(NSString *)tableName CourseID:(NSString *)courseID{
    WYALocalDownloadModel * localModel = [[WYALocalDownloadModel alloc]init];
    
    localModel.fileName = model.courseware_title;
    localModel.videoName = model.courseware_title;
    localModel.fileUrl = model.courseware_url;
    localModel.fileType = [model.courseware_url pathExtension];
    localModel.fileNumber = classType;
    localModel.fileID = model.chapter_id;
    localModel.findModel = [NSString stringWithFormat:@"%@%@",model.chapter_id,classType];
    localModel.fmdb_name = tableName;
    localModel.course_id = courseID;
    localModel.course_title = tableName;
    localModel.fileState = 4;
    localModel.fileLocalurl = [[NSString downloadVideoPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",[[localModel.fileName lastPathComponent] stringByDeletingPathExtension],[localModel.fileUrl pathExtension]]];
    
    NSArray * array = [self.fmdb jq_lookupTable:tableName dicOrModel:[WYALocalDownloadModel class] whereFormat:[NSString stringWithFormat:@"WHERE findModel = '%@'",localModel.findModel]];
    if (array.count<1) {
        [self.fmdb jq_insertTable:tableName dicOrModel:localModel];
    }
    
    [self.fmdb jq_updateTable:FileDownload_TableName dicOrModel:@{@"haveDownloadChapter":@"1"} whereFormat:[NSString stringWithFormat:@"WHERE tableName = '%@'",tableName]];
}

@end
