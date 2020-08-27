//
//  WYAFMDBManager.h
//  WYA_Project
//
//  Created by 李世航 on 2018/5/22.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WYALocalDownloadModel.h"
#import "WYATableNameModel.h"

@interface WYAFMDBManager : NSObject

+(instancetype)shardFmdbManager;

+ (void)save:(WYALocalDownloadModel *)model;

+(void)deleteLocalModel:(WYALocalDownloadModel *)model;

-(void)saveDownloadInfoWithModel:(WYALocalDownloadModel *)model;

+ (NSMutableArray *)downloadingMusicArrayInDB;

+ (NSMutableArray *)pausedMusicArrayInDB;

+ (NSMutableArray *)complatedMusicArrayInDB;

@end
