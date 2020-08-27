//
//  WYANowDownloadManager.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/25.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYABaseNetRequest.h"
#import "WYALocalDownloadModel.h"
@interface WYANowDownloadManager : WYABaseNetRequest

/**
 获取正在下载的数据

 @return 下载数组
 */
- (NSArray *)getDownloadingArray;



@end
