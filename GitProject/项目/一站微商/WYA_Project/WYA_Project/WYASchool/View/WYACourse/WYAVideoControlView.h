//
//  WYAVideoControlView.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/11.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "ZFPlayerControlView.h"
#import "WYACourseTestView.h"
#import "WYACourseDetailModel.h"

@protocol WYAVideoCoverViewControlDelegate<NSObject>

@optional

/**
 开始学习

 @param sender 开始学习按钮
 */
- (void)videoStartLearnClick:(UIButton *)sender;

/**
 播放和暂停

 @param sender 按钮
 @param progress 进度
 */
- (void)videoPlayButtonClick:(UIButton *)sender Progress:(NSString *)progress;

/**
 检测网络
 */
- (void)videoCkeckNet;

/**
 跳转测试卷事件
 */
- (void)goTestPaper;

@end

@interface WYAVideoControlView : ZFPlayerControlView

@property (nonatomic, weak)   id<WYAVideoCoverViewControlDelegate> videoCoverViewControlDelegate;

@property (nonatomic, strong) UIButton * playButton;

@property (nonatomic, copy)   void(^showAlert)();

@property (nonatomic, strong) UIView * learnView;

@property (nonatomic, strong) UILabel * learnLabel;

@property (nonatomic, strong) UIButton * learnButton;

@property (nonatomic, strong) WYACourseTestView * testView;

@property (nonatomic, strong) LastChapter * chapter;

- (void)startLearnClick;

@end
