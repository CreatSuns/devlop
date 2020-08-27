//
//  WYANowDownloadView.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/25.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYALocalDownloadModel;

@interface WYANowDownloadView : UIView

@property (nonatomic, strong) NSArray * datas;

@property (nonatomic, assign) BOOL canEdit;

//删除所有的
@property (nonatomic, copy) void(^deleteAction)(NSMutableArray * array);

@property (nonatomic, copy) void(^didSelectRow)(BOOL state, WYALocalDownloadModel * model);

@property (nonatomic, readonly) UITableView * tableView;

@end
