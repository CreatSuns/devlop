//
//  WYACardParsingListModel.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/23.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYACardParsingListModel : NSObject
@property(nonatomic, copy) NSString * analysis;//解析内容
@property(nonatomic, copy) NSString * count;// 总数
@property(nonatomic, copy) NSString * type;// 题目类型
@property(nonatomic, copy) NSString * isCorrect;// 是否正确
@property(nonatomic, copy) NSString * myAnswer;// 我的答案
@property(nonatomic, strong) NSArray * options;
@property(nonatomic, copy) NSString * caseTopic;//案例分析的内容
@property(nonatomic, copy) NSString * caseOther;// 不知道什么鬼
@property(nonatomic, copy) NSString * question;//问题
@property(nonatomic, copy) NSString * questionNum;//题号
@property(nonatomic, copy) NSString * stabdardAnswer;//标准答案
+ (instancetype)cardParsingListModelWith:(id)response;

@end
