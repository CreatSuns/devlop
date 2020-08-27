//
//  NSString+WYAString.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/10.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "NSString+WYAString.h"

@implementation NSString (WYAString)

+ (NSString *)upperCaseNumber:(NSInteger)number{
    switch (number) {
            case 0: return @"零";
            case 1: return @"一";
            case 2: return @"二";
            case 3: return @"三";
            case 4: return @"四";
            case 5: return @"五";
            case 6: return @"六";
            case 7: return @"七";
            case 8: return @"八";
            case 9: return @"九";
            case 10: return @"十";
            case 11: return @"十一";
            case 12: return @"十二";
    }
    return @"";
}

+ (NSString *)homePath{
    return NSHomeDirectory();
}

+ (NSString *)appPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)docPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)libPrefPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preference"];
}

+ (NSString *)libCachePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
}

+ (NSString *)tmpPath
{
    return [NSHomeDirectory() stringByAppendingFormat:@"/tmp"];
}

+ (NSString *)allUserDownloadFile{
    NSString * string = [[NSString libCachePath] stringByAppendingPathComponent:@"allUserData"];
    return string;
}

+ (NSString *)allUserDownloaderPlist{
    NSString * string = [[NSString allUserDownloadFile] stringByAppendingPathComponent:@"allUserDownloader.plist"];
    return string;
}

+ (NSString *)downloadFilePath{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    NSString *dataFilePath = [[NSString allUserDownloadFile] stringByAppendingPathComponent:@"downFile"];
    return dataFilePath;
}

+ (NSString *)downloadVideoPath{
    NSString * string = [[NSString downloadFilePath] stringByAppendingPathComponent:@"video"];
    return string;
}


- (unsigned long long)fileSize
{
    // 总大小
    unsigned long long size = 0;
    NSString *sizeText = nil;
    NSFileManager *manager = [NSFileManager defaultManager];
    
    BOOL isDir = NO;
    BOOL exist = [manager fileExistsAtPath:self isDirectory:&isDir];
    
    // 判断路径是否存在
    if (!exist) return size;
    if (isDir) { // 是文件夹
        NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:self];
        for (NSString *subPath in enumerator) {
            NSString *fullPath = [self stringByAppendingPathComponent:subPath];
            size += [manager attributesOfItemAtPath:fullPath error:nil].fileSize;
            
        }
    }else{ // 是文件
        size += [manager attributesOfItemAtPath:self error:nil].fileSize;
    }
    return size;
}

@end
