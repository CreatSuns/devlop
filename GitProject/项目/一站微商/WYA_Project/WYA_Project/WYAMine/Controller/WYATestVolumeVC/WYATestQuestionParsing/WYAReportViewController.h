//
//  WYAReportViewController.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/19.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAViewController.h"
typedef NS_ENUM(NSInteger, WYAReportVCWherePush) {
    WYAReportPushForPaperContorller,//从测试试卷push
    WYAReportPushForCourseController,//从课程详情目录进入
};
@interface WYAReportViewController : WYAViewController
@property(nonatomic,assign)WYAReportVCWherePush reportPushType;
@property(nonatomic, strong) NSArray * array;
@property(nonatomic, copy) NSString * paper_id;
@property(nonatomic, assign) BOOL  isShowTestBtn;
@end
