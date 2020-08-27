//
//  WYAMineInfoModel.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/20.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYAMineInfoModel : NSObject

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * headImageString;

@property (nonatomic, copy) NSString * subtitle;

-(instancetype)initWithTitle:(NSString *)title headImage:(NSString *)headImageString Subtitle:(NSString *)subtitle;

@end
