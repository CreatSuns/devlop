//
//  WYATestVolumeViewController.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/13.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAViewController.h"

typedef NS_ENUM(NSInteger, WYATestVCWherePush) {
    WYATestPushForPaperContorller,//从测试试卷push
    WYATestPushForAnswerCardController,//从答题卡界面push进入
    WYATestPushForCourseController,//从课程详情进入
    WYATestPushForReportVc,//从答题报告里进入
};
@interface WYATestVolumeViewController : WYAViewController
@property(nonatomic,assign)WYATestVCWherePush pushFromWhere;
@property(nonatomic, copy) NSString * paper_id;
@property(nonatomic, copy) NSString * question_number;// 题号
//@property(nonatomic, strong) NSMutableArray * pushAnswerArray;// 全部答案

@end
