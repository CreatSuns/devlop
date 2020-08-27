//
//  WYAFinishDownloadView.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/27.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WYALocalDownloadModel;

@interface WYAFinishDownloadView : UIView

@property (nonatomic, copy) NSString * title;

@property (nonatomic, strong) NSMutableArray * datas;

@property (nonatomic, assign) BOOL canEdit;

@property (nonatomic, copy) void(^deleteAction)(NSMutableArray * array);

@property (nonatomic, copy) void(^goDetailVC)();

@property (nonatomic, copy) void(^goWatch)(WYALocalDownloadModel * model);

@end
