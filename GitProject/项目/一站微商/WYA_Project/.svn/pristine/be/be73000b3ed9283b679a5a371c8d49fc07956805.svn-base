//
//  WYAMineDownloadView.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/20.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WYAMineDownloadModel;

@interface WYAMineDownloadView : UIView

@property (nonatomic, strong) WYAMineDownloadModel * model;

@property (nonatomic, copy) void(^selectRow)(NSIndexPath * indexPath, NSString * title, NSString * courseID);

@property (nonatomic, assign) NSUInteger nowDownloadCount;

@property (nonatomic, strong) NSArray * finishDownloadArray;

@property (nonatomic, readonly) UITableView * table;

@end
