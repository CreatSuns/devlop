//
//  WYACourseCatalogNetRequst.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/13.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYACourseCatalogNetRequst.h"
#import "WYACourseCatalogModel.h"
#import "WYALocalDownloadModel.h"
@interface WYACourseCatalogNetRequst ()

@end

@implementation WYACourseCatalogNetRequst

- (void)loadCourseCatalogWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail
{
    [WYACourseCatalogNetRequst GetWithUrl:CourseCatalog Params:params Success:^(id data) {
        NSLog(@"data==%@",data);
        WYACourseCatalogModel * model = [WYACourseCatalogModel yy_modelWithJSON:data[@"data"]];
        for (WYACourseCatalogGroupsModel * groupModel in model.groups) {
            groupModel.flag = YES;
        }
        success(model);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        fail(netCode, errorDes);
    }];
}

- (NSArray *)queryFileDownloadState:(NSString *)tableName QueryConditions:(NSString *)conditions{
    __block NSArray * array;
    JQFMDB * fmdb = [JQFMDB shareDatabase:FileDownload_DataBase path:[NSString downloadFilePath]];
    [fmdb jq_inDatabase:^{
        array = [fmdb jq_lookupTable:tableName dicOrModel:[WYALocalDownloadModel class] whereFormat:conditions];
    }];
    return array;
}

@end
