//
//  WYACourseCatalogVC.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/13.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAViewController.h"
#import "WYACourseDetailModel.h"
#import "WYACourseCatalogModel.h"

@class WYACourseDetailVC;

@interface WYACourseCatalogVC : WYAViewController

@property (nonatomic, strong)WYACourseDetailVC * lastVC;

@property (nonatomic, strong)CourseInfo * model;

@property (nonatomic, copy) NSString * tableName;

@property (nonatomic, assign) BOOL onlyShowDownloadFinish;

/**
 当前播放视频的model
 */
@property (nonatomic, strong) WYACourseCatalogChaptersModel * videoModel;

@end
