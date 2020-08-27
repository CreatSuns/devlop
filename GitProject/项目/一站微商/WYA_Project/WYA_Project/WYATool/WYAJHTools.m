//
//  WYAJHTools.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/18.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAJHTools.h"
#include <sys/param.h>
#include <sys/mount.h>
@interface WYAJHTools()<MBProgressHUDDelegate>
@property(nonatomic, strong) MBProgressHUD * HUD;
@end
@implementation WYAJHTools
+(NSString *)getNowTimeTimestampForSeconds{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //设置时区
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
}
//获取当前时间戳  （以毫秒为单位）
+(NSString *)getNowTimeTimestampForMs{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    return timeSp;
}
// 可变字符串
+ (NSAttributedString *)AttribytedStringWithstr:(NSString *)str changeStr:(NSString *)changeStr
{
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc]initWithString:str];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:3*Size_ratio];
    
    [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    
    NSRange range = [str rangeOfString:changeStr];
    
    [string addAttribute:NSForegroundColorAttributeName
                   value:[UIColor WYAJHBasePurpleColor]
                   range:range];
    
    [string addAttribute:NSFontAttributeName
                   value:[UIFont fontWithName:@"PingFang-SC-Medium" size:15*Size_ratio]
                   range:range];
    return string;
}

// 获取文本宽度
+ (CGFloat)widthOfConttent:(NSString*)content fontSize:(CGFloat)fontSize maxHeight:(CGFloat)maxHeight
{
    
    if (content.length==0) {
        return 0.0;
    }
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    return [content boundingRectWithSize:CGSizeMake(MAXFLOAT, maxHeight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.width;
    
}

// 获取文本高度
+ (CGFloat)heightOfConttent:(NSString*)content fontSize:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth
{
    
    if (content.length==0) {
        return 0.0;
    }
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    return [content boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height+fontSize;
    
}

// 可变字符串
+ (NSAttributedString *)AttribytedStringWithstr:(NSString *)str
                                      changeStr:(NSArray *)changeStrs
                         NSAttributedStringKeys:(NSArray *)keys
                              NSAttributedValue:(NSArray *)values
{
    if (!str || !changeStrs) {
        return nil;
    }
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc]initWithString:str];
    for (NSString * changeStr in changeStrs) {
        NSRange range = [str rangeOfString:changeStr];
        
        for (int i = 0; i<keys.count; i++) {
            [string addAttribute:keys[i] value:values[i] range:range];
        }
    }
    
    return string;
}

+ (double)getDivceAllSize{
    
    //总大小
    struct statfs buf1;
    long long maxspace = 0;
    if (statfs("/", &buf1) >= 0) {
        maxspace = (long long)buf1.f_bsize * buf1.f_blocks;
    }
    if (statfs("/private/var", &buf1) >= 0) {
        maxspace += (long long)buf1.f_bsize * buf1.f_blocks;
    }
    return (double)maxspace/1024/1024/1024;
}

+ (double)getDivceAvailableSize{
    //可用大小
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/var", &buf) >= 0){
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
    }
    return (double)freespace/1024/1024/1024;
}

+ (void)fileSizeWithFilePath:(NSString *)path
{
    // 总大小
    __block unsigned long long size = 0;
    __block NSString *sizeText = @"0KB";
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 文件管理者
        NSFileManager *mgr = [NSFileManager defaultManager];
        
        // 文件属性
        NSDictionary *attrs = [mgr attributesOfItemAtPath:path error:nil];
        // 如果这个文件或者文件夹不存在,或者路径不正确直接返回0;
        if (attrs == nil) {
            sizeText = @"0KB";
        }else{
            if ([attrs.fileType isEqualToString:NSFileTypeDirectory]) { // 如果是文件夹
                // 获得文件夹的大小  == 获得文件夹中所有文件的总大小
                NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:path];
                for (NSString *subpath in enumerator) {
                    // 全路径
                    NSString *fullSubpath = [path stringByAppendingPathComponent:subpath];
                    // 累加文件大小
                    size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
                    
                    if (size >= pow(10, 9)) { // size >= 1GB
                        sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
                    } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
                        sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
                    } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
                        sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
                    } else { // 1KB > size
                        sizeText = [NSString stringWithFormat:@"%zdB", size];
                    }
                    
                }
                //        return sizeText;
            } else { // 如果是文件
                size = attrs.fileSize;
                if (size >= pow(10, 9)) { // size >= 1GB
                    sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
                } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
                    sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
                } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
                    sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
                } else { // 1KB > size
                    sizeText = [NSString stringWithFormat:@"%zdB", size];
                }
                
            }
        }
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:sizeText forKey:@"VideoSize"];
        [userDefaults synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:DOWNLOADSIZE object:nil userInfo:@{@"size":sizeText}];
    });
    
    
   
    
}

#pragma mark ====== HUD
// 只显示文字
+ (void)showMassageView:(UIView *)view text:(NSString *)text{
    MBProgressHUD * hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.labelText = text;
    hud.mode = MBProgressHUDModeText;
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    }
       completionBlock:^{
           [hud removeFromSuperview];
       }];
}
// 圆形进度条
- (void)showMassageRoundView:(UIView *)view text:(NSString *)text{
    
    //圆形进度条
    MBProgressHUD * hud = [[MBProgressHUD alloc] initWithView:view];

    [view addSubview:hud];
    
    hud.mode = MBProgressHUDModeDeterminate;
    
    hud.delegate = self;
    
    hud.labelText = text;
    
    [hud showWhileExecuting:@selector(ProgressBar:) onTarget:self withObject:nil animated:YES];
}

//  进度条  计算
- (void)ProgressBar:(MBProgressHUD *)hud{
    // 进度指示器，从0.0到1.0，默认值为0.0
    float progress = 0.0f;
    
    while (progress < 1.0f) {
        
        progress += 0.01f;
        
        hud.progress = progress;
        
        //        usleep函数能把进程挂起一段时间， 单位是微秒（千分之一毫秒）
        usleep(50000);
    }
}

//   通常情况  文字  加 菊花
- (void)GeneralButtonAction:(UIView *)view Title:(NSString *)title SubTitle:(NSString *)subTitle{
    //初始化进度框，置于当前的View当中
    self.HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:_HUD];
    
    //如果设置此属性则当前的view置于后台
    _HUD.dimBackground = YES;
    
    //设置对话框文字
    if (title) {
        _HUD.labelText = title;
    }else{
        _HUD.labelText = @"加载中";
    }
    
    //细节文字
    if (subTitle) {
        _HUD.detailsLabelText = subTitle;
    }
    
    
    //显示对话框
    [_HUD showAnimated:YES whileExecutingBlock:^{
        //对话框显示时需要执行的操作
        sleep(3);
    }// 在HUD被隐藏后的回调
       completionBlock:^{
           //操作执行完后取消对话框
           [_HUD removeFromSuperview];
           _HUD = nil;
       }];
}

@end
