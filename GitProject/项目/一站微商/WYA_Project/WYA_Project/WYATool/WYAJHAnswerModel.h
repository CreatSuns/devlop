//
//  WYAJHAnswerModel.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/17.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYAJHAnswerModel : NSObject
@property(nonatomic, copy) NSString * paper_id;//试卷ID
@property(nonatomic, copy) NSString * question_number;//题号
@property(nonatomic, copy) NSString * questionType;//题型
@property(nonatomic, copy) NSString * answerString;//答案
- (instancetype)initWithPaper_id:(NSString *)paper_id
                 question_number:(NSString *)question_number
                    questionType:(NSString *)questionType
                    answerString:(NSString *)answerString;
@end
