//
//  UIColor+WYAColor.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/4.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (WYAColor)

+ (UIColor *)colorWithHexString:(NSString *)color;

/**
 绘制渐变色

 @param context 内容
 @param path 路径
 @param startColor 开始颜色
 @param endColor 结束颜色
 */
+ (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor;

/**
 * tabBar选中的颜色
 */
+ (UIColor *)WYAJHTabBarSelectedColor;

/**
 * tabBar的普通状态颜色
 */
+ (UIColor *)WYAJHTabBarNormalColor;

/**
 * TextColor黑色
 */
+ (UIColor *)WYAJHBlackTextColor;

/**
 * 亮黑色
 */
+ (UIColor *)WYAJHLightBlackTextColor;

/**
 * TextColor灰色
 */
+ (UIColor *)WYAJHgrayTextColor;

/**
 * 深灰色背景色
 */
+ (UIColor *)WYAJHDarkgGreyColor;

/**
 * 亮灰色背景色
 */
+ (UIColor *)WYAJHLightGreyColor;

/**
 * 关注按钮背景色
 */
+ (UIColor *)WYAFocusBackGroundColor;

/**
 * 背景色
 */
+ (UIColor *)WYAJHBackGroundColor;

/**
 * 基础紫色
 */
+ (UIColor *)WYAJHBasePurpleColor;

/**
 * 基础绿色
 */
+ (UIColor *)WYAJHBaseGreenColor;
/**
 * 基础红色
 */
+ (UIColor *)WYAJHBaseRedColor;

/**
 * 答题卡红色
 */
+ (UIColor *)WYAJHCardRedColor;

/**
 * 答题卡紫色
 */
+ (UIColor *)WYAJHCardPurpleColor;

/**
 * 基础蓝色
 */
+ (UIColor *)WYAJHBaseBlueColor;

/**
 选项卡未选中文字颜色
 */
+ (UIColor *)WYAJHSegNoSelectColor;

/**
 设置页面灰色文字
 */
+ (UIColor *)WYAJHSettingGrayTextColor;

/**
 反馈意见中的黑色文字
 */
+ (UIColor *)WYAJHOpinionBlackTextColor;

/**
 我的课表没有数据展示的视图中文字颜色
 */
+ (UIColor *)WYAJHMyCouresTableNoDataTextColor;

/**
 课程详情简介cell文字颜色
 */
+ (UIColor *)WYAJHCourseCatalogCellTextColor;

/**石灰色*/
+ (UIColor *)WYAJHStoneGrayColor;
@end
