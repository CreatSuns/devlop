//
//  WYANowDownloadEditView.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/27.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NowDownloadEditDelegate<NSObject>

- (void)allSeletedWithSeleted:(BOOL)seleted;

- (void)deleteSeleted;

@end

@interface WYANowDownloadEditView : UIView

@property (nonatomic, weak) id<NowDownloadEditDelegate> delegate;

@property (nonatomic, strong) UIButton * allSelectButton;

@property (nonatomic, strong) UIButton * deleteButton;

@end
