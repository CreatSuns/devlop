//
//  WYAMineCellModel.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/8.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMineCellModel.h"

@implementation WYAMineCellModel
- (id)initWithIconImgNamed:(NSString *)iconImgNamed titleText:(NSString *)titleText arrowImgNamed:(NSString *)arrowImgNamed
{
     if (self = [super init]){
         
    _iconImgNamed = iconImgNamed;
    _titleText = titleText;
    _arrowBtnImgNamed = arrowImgNamed;
    
     }
    
    return self;
}
+ (instancetype)mineCellModelWithIconImgNamed:(NSString *)iconImgNamed titleText:(NSString *)titleText arrowImgNamed:(NSString *)arrowImgNamed
{
    return [[[WYAMineCellModel alloc]init] initWithIconImgNamed:iconImgNamed titleText:titleText arrowImgNamed:arrowImgNamed];
}

@end
