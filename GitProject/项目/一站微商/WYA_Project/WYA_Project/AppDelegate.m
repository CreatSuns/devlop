//
//  AppDelegate.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/4.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "AppDelegate.h"
#import "WYALoginVC.h"
#import "WYATabbarViewController.h"
#import "SODownloader+WYAVideoDownload.h"
#import <Bugly/Bugly.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
         
    [self addThirdPartyDependence];
    
    [self createMainFolder];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * token = [userDefaults objectForKey:@"access_token"];
    if (token) {
        [SODownloader videoDownloader];
        WYATabbarViewController * tabbar = [[WYATabbarViewController alloc]init];
        self.window.rootViewController = tabbar;
    }else{
    WYALoginVC * login = [[WYALoginVC alloc]init];
    self.window.rootViewController = login;
    }
    [self.window makeKeyWindow];
    
    
    
    return YES;
}

#pragma mark 添加配置第三方工具
- (void)addThirdPartyDependence{
    [Bugly startWithAppId:@"049a4e200a"];
}

#pragma mark 创建根文件夹
- (void)createMainFolder{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    
    // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    BOOL existed = [fileManager fileExistsAtPath:[NSString allUserDownloadFile] isDirectory:&isDir];
    
    if (!(isDir && existed)) {
        // 在Document目录下创建一个archiver目录
        [fileManager createDirectoryAtPath:[NSString allUserDownloadFile] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSLog(@"data==%@",[NSString allUserDownloadFile]);
}



#pragma mark    禁止横屏
//- (UIInterfaceOrientationMask )application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
//{
//    //    if (self.allowRotation) {
//    //        return UIInterfaceOrientationMaskAll;
//    //    }
//    return UIInterfaceOrientationMaskPortrait;
//}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
