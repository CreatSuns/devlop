//
//  WYACardParsingListModel.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/23.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYACardParsingListModel.h"

@implementation WYACardParsingListModel
+ (instancetype)cardParsingListModelWith:(id)response
{
    WYACardParsingListModel * model = [[WYACardParsingListModel alloc]init];
    NSDictionary * responseData = response[@"data"];
    model.count = responseData[@"count"];
    NSDictionary * data = responseData[@"list"];
    model.stabdardAnswer = checkString(data[@"standard_answer"]);
    model.analysis = checkString(data[@"analysis"]);
    model.isCorrect = checkString(data[@"is_correct"]);
    model.myAnswer = checkString(data[@"my_answer"]);
    model.caseOther = checkString(data[@"case"]);
    
    NSString * caseTopicStr = checkString(data[@"case_topic"]);
    if ([caseTopicStr hasPrefix:@"【案例分析题】"]) {
        model.caseTopic = caseTopicStr;
    }else
    {
         model.caseTopic = [NSString stringWithFormat:@"【案例分析题】%@",caseTopicStr];
    }
    if (data[@"options"]) {
        model.options = checkArray(data[@"options"]);
    }
    model.question = checkString(data[@"question"]);
    model.questionNum = checkString(data[@"question_number"]);
    if ([checkString(data[@"type"]) isEqualToString:@"1"]) {
        model.type = @"单选题";
    }  if ([checkString(data[@"type"]) isEqualToString:@"2"]) {
        model.type = @"多选题";
    }  if ([checkString(data[@"type"]) isEqualToString:@"3"]) {
        model.type = @"判断题";
    }  if ([checkString(data[@"type"]) isEqualToString:@"4"]) {
        model.type = @"案例分析题";
    }if ([checkString(data[@"type"]) isEqualToString:@"暂无数据"]) {
        model.type = @"未知类型";
    }
    
    return model;
}
@end
