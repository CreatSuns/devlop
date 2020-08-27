//
//  InfoCache.h
//  Gas
//
//  Created by 李世航 on 18/4/8.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYAUserInfo : NSObject

//------------------NSUserDefaults--------------------
+ (void)saveValue:(id)value forKey:(NSString *)key;
+ (id)getValueForKey:(NSString *)key;


//------------------archive/unarchive--------------------
// 归档
+ (void)archiveObject:(id) obj toFile:(NSString *)path;

// 解档
+ (id)unarchiveObjectWithFile:(NSString *)path;

@end
