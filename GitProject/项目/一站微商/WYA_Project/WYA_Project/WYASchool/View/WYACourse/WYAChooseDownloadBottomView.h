//
//  WYAChooseDownloadBottomView.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/24.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//  选择下载页面下方的view

#import <UIKit/UIKit.h>

@protocol ChooseDownloadDelegate <NSObject>

- (void)seletedAllAction;

- (void)startDownload;

@end

@interface WYAChooseDownloadBottomView : UIView

@property (nonatomic, weak) id <ChooseDownloadDelegate> delegate;

@property (nonatomic, copy) void(^showAlert)();

@end
