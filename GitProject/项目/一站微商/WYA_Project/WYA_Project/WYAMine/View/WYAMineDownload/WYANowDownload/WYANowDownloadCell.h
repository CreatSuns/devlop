//
//  WYANowDownloadCell.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/25.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYALocalDownloadModel;

@protocol NowDownloadCellDelegate <NSObject>

- (void)selectCellWithState:(BOOL)state Model:(WYALocalDownloadModel *)model;

@end

@interface WYANowDownloadCell : UITableViewCell

@property (nonatomic, strong) UIProgressView * progress;

@property (nonatomic, strong) UILabel * downloadSpeedLabel;

@property (nonatomic, strong) UILabel * downloadNowSizeLabel;

@property (nonatomic, strong) WYALocalDownloadModel * model;

@property (nonatomic, assign) BOOL canEdit;

@property (nonatomic, assign) BOOL selectCell;

@property (nonatomic, weak) id<NowDownloadCellDelegate> delegate;
- (void)configureMusic:(WYALocalDownloadModel *)model;
//@property (nonatomic, copy) void(^buttonXZ)(BOOL seletState, WYALocalDownloadModel * model);
//@property (nonatomic, copy) void(^aaa)(BOOL seletState, WYALocalDownloadModel * model);
@end
