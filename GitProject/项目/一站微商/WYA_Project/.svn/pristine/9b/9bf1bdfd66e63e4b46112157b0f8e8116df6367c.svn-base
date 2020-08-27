//
//  WYAJHTools.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/18.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYAJHTools : NSObject
/**
 * 获取当前时间秒
 */
+(NSString *)getNowTimeTimestampForSeconds;
/**
 * 获取当前时间毫秒
 */
+(NSString *)getNowTimeTimestampForMs;
/**
 * 获取富文本字符串
 */
+ (NSAttributedString *)AttribytedStringWithstr:(NSString *)str changeStr:(NSString *)changeStr;

/**
 * 获取文本宽度
 */
//+ (CGFloat)widthOfConttent:(NSString*)content fontSize:(CGFloat)fontSize maxHeight:(CGFloat)maxHeight;

/**
 * 获取文本高度
 */
+ (CGFloat)heightOfConttent:(NSString*)content fontSize:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth;

/**
 获取富文本字符串

 @param str 初始字符串
 @param changeStr 改变的字符串
 @param keys NSAttributedStringKey
 @param values 值
 @return 富文本字符串
 */
+ (NSAttributedString *)AttribytedStringWithstr:(NSString *)str
                                      changeStr:(NSArray *)changeStr
                         NSAttributedStringKeys:(NSArray *)keys
                              NSAttributedValue:(NSArray *)values;

/**
 获取手机全部内存

 @return double
 */
+ (double)getDivceAllSize;

/**
 获取手机剩余内存

 @return double
 */
+ (double)getDivceAvailableSize;

/**
 获取已下载文件大小

 @param path 路径
 */
+ (void)fileSizeWithFilePath:(NSString *)path;
/**
 * 添加纯文字的hud
 * @param view 父视图
 * @param text 显示的文字内容
 */
+ (void)showMassageView:(UIView *)view text:(NSString *)text;
/**
 * 圆形进度加文字
 * @param view 父视图
 * @param text 显示的文字内容
 */
- (void)showMassageRoundView:(UIView *)view text:(NSString *)text;
/**
 * 文字+菊花
 * @param view 父视图
 * @param title 标题
 * @param subTitle 显示的副文字内容
 */
- (void)GeneralButtonAction:(UIView *)view Title:(NSString *)title SubTitle:(NSString *)subTitle;
@end
