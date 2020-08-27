//
//  WYALocalDownloadModel.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/24.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYALocalDownloadModel.h"
#import "WYAFMDBManager.h"
@implementation WYALocalDownloadModel
@synthesize so_downloadState = _so_downloadState, so_downloadSpeed = _so_downloadSpeed;

- (NSString *)savePath{
//    NSString * string;
//    if ([self.fileNumber isEqualToString:@"2"]) {
//        string = @"mp4";
//    }else{
//        string = nil;
//    }
    return [[[NSString downloadVideoPath] stringByAppendingPathComponent:self.fileName] stringByAppendingPathExtension:@"mp4"];
    
}

- (NSURL *)so_downloadURL{
    return [NSURL URLWithString:[self.fileUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

- (void)setSo_downloadState:(SODownloadState)so_downloadState {
    _so_downloadState = so_downloadState;
    switch (so_downloadState) {
        case SODownloadStateNormal | SODownloadStateError:
            if ([[NSFileManager defaultManager]fileExistsAtPath:[self savePath]]) {
                // 清理下载的文件
                [[NSFileManager defaultManager]removeItemAtPath:[self savePath] error:nil];
                
            }
            
            break;
        default:
            break;
    }
    
    [WYAFMDBManager save:self];
}

#pragma mark - SODownloadItem建议实现的方法
/**
 实现下面这两个方法用于判断两个对象相等。这两个方法一般不会被直接调用，而是间接的调用，比如在集合（NSArray、NSSet等）中的相关方法（比如indexOfObject、containsObject等）中被间接调用。
 了解更多关于这两个方法的内容可以看我写的这个 [WiKi](https://github.com/scfhao/SODownloader/wiki/%E4%BF%9D%E8%AF%81%E4%B8%8B%E8%BD%BD%E5%AF%B9%E8%B1%A1%E7%9A%84%E5%94%AF%E4%B8%80%E6%80%A7)
 */
- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[WYALocalDownloadModel class]]) {
        return [super isEqual:object];
    }
    //如果self和object代表同一个对象，比如这两个对象内存地址不同，但是所有的属性值都相等，对于 SODownloader 来说，就是下载地址相同时返回 YES，否则返回 NO。
    WYALocalDownloadModel * music = (WYALocalDownloadModel *)object;
    return self.findModel == music.findModel;
}

/**
 为相等的对象返回相同的hash值，为不相等的对象返回不同的hash值。
 */
- (NSUInteger)hash {
    return [self.findModel hash];
}
@end
