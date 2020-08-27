//
//  WYACardParsingModel.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/23.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYACardParsingModel : NSObject
@property(nonatomic, copy) NSString * exam_time;
@property(nonatomic, copy) NSString * pass_point;
@property(nonatomic, copy) NSString * points;
@property(nonatomic, copy) NSString * score;
@property(nonatomic, copy) NSString * use_time;
@property(nonatomic, copy) NSString * isShowBottomItem;
@property(nonatomic, copy) NSString * itemsNum;
+ (NSMutableArray *)cardParsingModelWithdata:(id)respone;
@end
