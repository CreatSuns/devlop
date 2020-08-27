//
//  UILabel+WYALabelAlighTop.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/13.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (WYALabelAlighTop)
- (void)alignTop;
- (void)alignBottom;
/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space text:(NSString *)labelText;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space ;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

/**
 获得UILabel高度
 
 @param width 宽度
 @param title title
 @param font font
 @return 返回高度
 */
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;


/**
 获得UILabel宽度
 
 @param title title
 @param font fon
 @return 返回宽度
 */
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;
@end
