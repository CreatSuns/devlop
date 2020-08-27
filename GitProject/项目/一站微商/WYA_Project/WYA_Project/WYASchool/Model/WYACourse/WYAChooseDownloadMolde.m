//
//  WYAChooseDownloadMolde.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/23.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAChooseDownloadMolde.h"

@implementation WYAChooseChapterModel

@end

@implementation WYAChooseGroupModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"chapters" : [WYAChooseChapterModel class],
             };
}

@end

@implementation WYAChooseDownloadMolde

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"data" : [WYAChooseGroupModel class],
             };
}

@end
