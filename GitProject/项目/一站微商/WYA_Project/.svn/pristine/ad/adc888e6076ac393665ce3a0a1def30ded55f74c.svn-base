//
//  UIColor+WYAColor.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/4.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "UIColor+WYAColor.h"
#import "WYA_LJHColor.h"
@implementation UIColor (WYAColor)

+ (UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}
#pragma mark ====== JHBaseColor
// 根据colorType获取color内部实现
+ (UIColor *)getLJHColorWithColorType:(WYAJHColor)JHColorType{
    UIColor * WYAColor = [UIColor colorWithRed:JHColorType.WYAJHRed
                                         green:JHColorType.WYAJHGreen
                                          blue:JHColorType.WYAJHBlue
                                         alpha:JHColorType.WYAJHAlph];
    return WYAColor;
}

+ (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    
    //具体方向可根据需求修改
    CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

+ (UIColor *)WYAJHTabBarSelectedColor
{
    return [UIColor getLJHColorWithColorType:WYAJHTabBarSelectedColor];
}

+ (UIColor *)WYAJHTabBarNormalColor
{
    return [UIColor getLJHColorWithColorType:WYAJHTabBarNormalColor];
}

+ (UIColor *)WYAJHBlackTextColor
{
    return [UIColor getLJHColorWithColorType:WYAJHBlackTextColor];
}

+ (UIColor *)WYAJHLightBlackTextColor
{
    return [UIColor getLJHColorWithColorType:WYAJHLightBlackTextColor];
}

+ (UIColor *)WYAJHgrayTextColor
{
    return [UIColor getLJHColorWithColorType:WYAJHgrayTextColor];
}

+ (UIColor *)WYAJHDarkgGreyColor
{
    return [UIColor getLJHColorWithColorType:WYAJHDarkgGreyColor];
}

+ (UIColor *)WYAJHLightGreyColor
{
    return [UIColor getLJHColorWithColorType:WYAJHLightGreyColor];
}

+ (UIColor *)WYAJHBackGroundColor
{
    return [UIColor getLJHColorWithColorType:WYAJHBackGroundColor];

}

+ (UIColor *)WYAFocusBackGroundColor
{
    return [UIColor getLJHColorWithColorType:WYAFocusBackGroundColor];
}

+ (UIColor *)WYAJHBasePurpleColor
{
    return [UIColor getLJHColorWithColorType:WYAJHBasePurpleColor];
}

+ (UIColor *)WYAJHBaseRedColor
{
    return [UIColor getLJHColorWithColorType:WYAJHBaseRedColor];
}

+ (UIColor *)WYAJHBaseGreenColor
{
    return [UIColor getLJHColorWithColorType:WYAJHBaseGreenColor];
}

+ (UIColor *)WYAJHCardRedColor
{
    return [UIColor getLJHColorWithColorType:WYAJHCardRedColor];
}

+ (UIColor *)WYAJHCardPurpleColor
{
    return [UIColor getLJHColorWithColorType:WYAJHCardPurpleColor];
}

+ (UIColor *)WYAJHBaseBlueColor
{
    return [UIColor getLJHColorWithColorType:WYAJHBaseBlueColor];
}

+ (UIColor *)WYAJHSegNoSelectColor
{
    return [UIColor getLJHColorWithColorType:WYAJHSegNoSelectColor];
}

+ (UIColor *)WYAJHSettingGrayTextColor
{
    return [UIColor getLJHColorWithColorType:WYAJHSettingGrayTextColor];
}

+ (UIColor *)WYAJHOpinionBlackTextColor
{
    return [UIColor getLJHColorWithColorType:WYAJHOpinionBlackTextColor];
}

+ (UIColor *)WYAJHMyCouresTableNoDataTextColor
{
    return [UIColor getLJHColorWithColorType:WYAJHMyCouresTableNoDataTextColor];
}

+ (UIColor *)WYAJHCourseCatalogCellTextColor
{
    return [UIColor getLJHColorWithColorType:WYAJHCourseCatalogCellTextColor];
}

+ (UIColor *)WYAJHStoneGrayColor
{
    return [UIColor getLJHColorWithColorType:WYAJHStoneGrayColor];
}
@end
