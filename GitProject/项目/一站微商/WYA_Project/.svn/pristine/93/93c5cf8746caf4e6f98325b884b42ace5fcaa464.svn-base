//
//  InfoCache.h
//  Gas
//
//  Created by 李世航 on 18/4/8.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAUserInfo.h"

@implementation WYAUserInfo

//------------------NSUserDefaults--------------------
+ (void)saveValue:(id)value forKey:(NSString *)key
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:value forKey:key];
    [userDefaultes synchronize];
}

+ (id)getValueForKey:(NSString *)key
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    id value = [userDefaultes objectForKey:key];
    return value;
}

//------------------archive/unarchive--------------------
+ (void)archiveObject:(id)obj toFile:(NSString *)path
{
    // 不要用NSHomeDirectory，不然失败
    NSString *stringPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
    path = [stringPath stringByAppendingPathComponent:path];//添加储存的文件名
   BOOL success = [NSKeyedArchiver archiveRootObject:obj toFile:path];
    if (success) {
        NSLog(@"归档成功");
    }
    
}

+ (id)unarchiveObjectWithFile:(NSString *)path
{
    // 不要用NSHomeDirectory，不然失败
    NSString *stringPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
    path = [stringPath stringByAppendingPathComponent:path];//添加储存的文件名
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

@end
