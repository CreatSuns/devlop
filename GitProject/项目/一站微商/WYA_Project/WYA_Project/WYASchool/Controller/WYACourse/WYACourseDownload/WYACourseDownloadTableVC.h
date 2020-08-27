//
//  WYACourseDownloadTableVC.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/14.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYATableViewController.h"
#import "WYACourseDetailModel.h"
@interface WYACourseDownloadTableVC : WYATableViewController

@property (nonatomic, strong)UIViewController * lastVC;

@property(nonatomic, strong)CourseInfo * model;

@property (nonatomic, copy) NSString * courseID;

@property (nonatomic, copy) NSString * course_name;

@end
