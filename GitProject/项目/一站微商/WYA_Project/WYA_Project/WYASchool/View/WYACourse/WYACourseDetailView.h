//
//  WYACourseDetailView.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/11.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYAVideoControlView.h"
#import "WYACourseCatalogModel.h"
@class WYACourseDetailModel;

@protocol WYAVideoControlDelegate<NSObject>

@required
/**
 返回事件
 */
- (void)videoBackButtonClick;

/**
 收藏事件
 */
- (void)videoLikeButtonClick:(UIButton *)sender;

/**
 下载事件

 @param url url
 */
- (void)videoDownloadUrl:(NSString *)url;


/**
 播放结束
 */
//- (void)videoEndWithChapterID:(NSString *)chapterID;

/**
 开始测试

 @param paperID paperID
 */
- (void)goChapterTestPaperWithPaperID:(NSString *)paperID;

/**
 上传当前视频信息
 */
- (void)saveCurrentVideoInfo;

@optional
/**
  课程学习结束
 */
- (void)courseLearningEnd;

/**
 添加到我的学习列表
 */
- (void)addMyLearnCourses;

@end

@interface WYACourseDetailView : UIView

@property (nonatomic, weak) id<WYAVideoControlDelegate> videoControlDelegate;

@property (nonatomic, copy) void(^showAlert)();

/**
 视频控制层
 */
@property (nonatomic, strong) WYAVideoControlView * coverView;

/**
 课程详情Model
 */
@property (nonatomic, strong) WYACourseDetailModel * model;

/**
 传入目录Model
 */
@property (nonatomic, strong) WYACourseCatalogModel * catalogModel;

@property (nonatomic, strong) WYACourseCatalogChaptersModel * chapterModel;

/**
 点击目录的视频传入的视频信息
 */
@property (nonatomic, strong)   NSDictionary * videoInfo;

/**
 观看时间
 */
@property (nonatomic, readonly) NSInteger learnTime;

/**
 视频长度
 */
@property (nonatomic, readonly) NSInteger allTime;

/**
 是否重置并移除video
 */
@property (nonatomic, assign)   BOOL resetVideo;

/**
 是否暂停
 */
@property (nonatomic, assign)   BOOL needSuspended;

/**
 是否是push界面（视频自动暂停）
 */
@property (nonatomic, assign)   BOOL pushOrPresent;

@property (nonatomic, copy)     NSString * chapterID;


-(instancetype)initWithFrame:(CGRect)frame PlaceHoldImage:(NSString *)placeholdImage;

/**
 考试完成刷新video显示的测试
 */
- (void)loadVideoPlayerAndEndTest;


@end
