//
//  WYATestVolumeNetRequest.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/16.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYATestVolumeNetRequest.h"
#import "WYATestQuestionListModel.h"
#import "WYAJHAnswerModel.h"
#import "WYACardParsingModel.h"
#import "WYACardParsingListModel.h"
@implementation WYATestVolumeNetRequest
/**
 * 获取测试题
 */
- (void)testQuestionListDataWithParams:(NSMutableDictionary *)params
                               Success:(Success)success
                                  Fail:(Fail)fail{
    [WYATestVolumeNetRequest GetWithUrl:TestQuestion Params:params Success:^(id data) {
        WYATestQuestionListModel * model = [WYATestQuestionListModel testQuestionListModelWith:data];
        success(model);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}

/**
 * 获取全部题号
 */
- (void)testAllQuestionNumWithParams:(NSMutableDictionary *)params
                             Success:(Success)success
                                Fail:(Fail)fail{
    [WYATestVolumeNetRequest GetWithUrl:TestAllQuestionNum Params:params Success:^(id data) {
        NSDictionary * dict = data[@"data"];
        NSString * radionNum = dict[@"radio"];
        NSString * multipleNum = dict[@"multiple"];
        NSString * judgeNum = dict[@"judge"];
        NSString * case_topic = dict[@"case_topic"];
        
        int radionCount = [radionNum intValue];
        int radionBegin = 0;
        
        NSArray * radionArray = [self getSectionDataSourcesWithCount:radionCount beginIndex:radionBegin];
        
        int multipleCount = [multipleNum intValue]+radionCount;
        int multipleBegin = radionCount;
        NSArray * multipleArray = [self getSectionDataSourcesWithCount:multipleCount beginIndex:multipleBegin];
        
        
        int judgeCount = [judgeNum intValue] + multipleCount;
        int judgeBegin = multipleCount;
        NSArray * judgeArray  = [self getSectionDataSourcesWithCount:judgeCount beginIndex:judgeBegin];
        
        int caseCount = [case_topic intValue] + judgeCount;
        
        int caseBegin = judgeCount;
        NSArray * caseArray = [self getSectionDataSourcesWithCount:caseCount beginIndex:caseBegin];
        
        NSMutableArray * allDataSources = [NSMutableArray array];
        
        [allDataSources addObject:radionArray];
        
        [allDataSources addObject:multipleArray];

        [allDataSources addObject:judgeArray];

        [allDataSources addObject:caseArray];
        
        success(allDataSources);

    } Fail:^(NetRequestCode netCode, NSString *errorDes) {

    }];
}
// 数据处理
- (NSArray *)getSectionDataSourcesWithCount:(int)index beginIndex:(int)beginIndex{
    
    NSMutableArray * sectionDataArr = [NSMutableArray array];
    for (int i = beginIndex; i < index; i++) {
        JQFMDB * db = [JQFMDB shareDatabase];
        // 查询条件
        NSString * searchString = [NSString stringWithFormat:@"where question_number = '%d'",i+1];
        //查询结果
        NSArray * answerArr = [db jq_lookupTable:ANSWE_DataBase dicOrModel:[WYAJHAnswerModel class] whereFormat:searchString];
        // 判断这个数组是否存在，查到说明这个题目选择过没查到就是没有
        if (answerArr.count==0) {
            // 加入一个空数据
            NSDictionary * dic = [NSDictionary dictionaryWithObject:@"NO" forKey:[NSString stringWithFormat:@"%d",i+1]];
            [sectionDataArr addObject:dic];
        }else{
            WYAJHAnswerModel * model = answerArr[0];
            if (model.answerString != nil) {
                NSDictionary * dic = [NSDictionary dictionaryWithObject:@"YES" forKey:[NSString stringWithFormat:@"%d",i+1]];
                [sectionDataArr addObject:dic];
            }
        }
    }
    return [sectionDataArr copy];
}
/**
 * 提交测试答案
 */
- (void)submitTestQuestionListWithParams:(NSMutableDictionary *)params
                                 Success:(Success)success
                                    Fail:(Fail)fail{
    [WYATestVolumeNetRequest GetWithUrl:TestAssignment Params:params Success:^(id data) {
        success(data);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
     NSLog(@"error==%@",errorDes);
         [WYAShowMessageView showToastAWithMessage:@"交卷失败,请重试"];
    }];
}
/**
 * 答题报告
 */
- (void)testQuestionReportWithParams:(NSMutableDictionary *)params
                             Success:(Success)success
                                Fail:(Fail)fail{
    [WYATestVolumeNetRequest GetWithUrl:TestPresentation Params:params Success:^(id data) {
        
        success([WYACardParsingModel cardParsingModelWithdata:data]);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
/**
 * 详细答题报告
 */
- (void)testQuestionDeatiledReportWithParams:(NSMutableDictionary *)params
                                     Success:(Success)success
                                        Fail:(Fail)fail{
    [WYATestVolumeNetRequest GetWithUrl:TestDetailPresentation Params:params Success:^(id data) {
        
        NSDictionary * dict = data[@"data"];
        NSString * radionNum = dict[@"radio"];
        NSString * multipleNum = dict[@"multiple"];
        NSString * judgeNum = dict[@"judge"];
        NSString * case_topic = dict[@"case_topic"];
        NSArray * list = dict[@"list"];
        int radionCount = [radionNum intValue];
        int radionBegin = 0;
        
        NSArray * radionArray = [self getSectionQuestionDeatiledDataSourcesWithCount:radionCount beginIndex:radionBegin listdataSources:list];
        
        int multipleCount = [multipleNum intValue]+radionCount;
        int multipleBegin = radionCount;
        NSArray * multipleArray = [self getSectionQuestionDeatiledDataSourcesWithCount:multipleCount beginIndex:multipleBegin listdataSources:list];
        
        
        int judgeCount = [judgeNum intValue] + multipleCount;
        int judgeBegin = multipleCount;
        NSArray * judgeArray  = [self getSectionQuestionDeatiledDataSourcesWithCount:judgeCount beginIndex:judgeBegin listdataSources:list];
        
        int caseCount = [case_topic intValue] + judgeCount;
        
        int caseBegin = judgeCount;
        NSArray * caseArray = [self getSectionQuestionDeatiledDataSourcesWithCount:caseCount beginIndex:caseBegin listdataSources:list];
        
        NSMutableArray * allDataSources = [NSMutableArray array];
        
        [allDataSources addObject:radionArray];
        
        [allDataSources addObject:multipleArray];
        
        [allDataSources addObject:judgeArray];
        
        [allDataSources addObject:caseArray];
        
        success(allDataSources);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
// 详细答题报告数据分组处理
- (NSArray *)getSectionQuestionDeatiledDataSourcesWithCount:(int)index beginIndex:(int)beginIndex listdataSources:(NSArray *)listArray{
    
    NSMutableArray * sectionDataArr = [NSMutableArray array];
    for (int i = beginIndex; i < index; i++) {
        NSDictionary * dict = listArray[i];
        NSString * numberString = [NSString stringWithFormat:@"%d",i+1];
        NSArray * dataArray = @[numberString,dict[@"is_correct"]];
        [sectionDataArr addObject:dataArray];
        }
    
    return [sectionDataArr copy];
}
/**
 * 错题解析
 */
- (void)testQuestionErrorAnalysisWithParams:(NSMutableDictionary *)params
                                    Success:(Success)success
                                       Fail:(Fail)fail
{
    [WYATestVolumeNetRequest GetWithUrl:TestError_Analysis Params:params Success:^(id data) {
        WYACardParsingListModel * model = [WYACardParsingListModel cardParsingListModelWith:data];
        success(model);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
/**
 * 全部解析
 */
- (void)testQuestionAllAnalysisWithParams:(NSMutableDictionary *)params
                                  Success:(Success)success
                                     Fail:(Fail)fail{
    [WYATestVolumeNetRequest GetWithUrl:TestAll_Analysis Params:params Success:^(id data) {
        WYACardParsingListModel * model = [WYACardParsingListModel cardParsingListModelWith:data];
        success(model);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
@end
