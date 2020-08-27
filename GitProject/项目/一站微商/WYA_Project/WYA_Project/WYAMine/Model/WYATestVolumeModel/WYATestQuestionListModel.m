//
//  WYATestQuestionListModel.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/16.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYATestQuestionListModel.h"

@implementation WYATestQuestionListModel
+ (instancetype)testQuestionListModelWith:(id)response{
    WYATestQuestionListModel * model = [[WYATestQuestionListModel alloc]init];
    NSDictionary * data = response[@"data"];
    model.questionCase = checkString(data[@"case"]);
    NSString * caseTopicStr = checkString(data[@"case_topic"]);
    if ([caseTopicStr hasPrefix:@"【案例分析题】"]) {
        model.case_topic = caseTopicStr;
    }else
    {
        model.case_topic = [NSString stringWithFormat:@"【案例分析题】%@",caseTopicStr];
    }
    model.count = checkString(data[@"count"]);
    if (data[@"options"]) {
        model.options = data[@"options"];
    }
    model.question = checkString(data[@"question"]);
    model.question_case_id = checkString(data[@"question_case_id"]);
    model.question_id = checkString(data[@"question_id"]);
    model.question_number = checkString(data[@"question_number"]);
    if ([data[@"type"] isEqualToString:@"1"]) {
        model.type = @"单选题";
    }  if ([data[@"type"] isEqualToString:@"2"]) {
        model.type = @"多选题";
    }  if ([data[@"type"] isEqualToString:@"3"]) {
        model.type = @"判断题";
    }  if ([data[@"type"] isEqualToString:@"4"]) {
        model.type = @"案例分析题";
    }
    model.type_id = checkString(data[@"type_id"]);
    return model;
}
@end
