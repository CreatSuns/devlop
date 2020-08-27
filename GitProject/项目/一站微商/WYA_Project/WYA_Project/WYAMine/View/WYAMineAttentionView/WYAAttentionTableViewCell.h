//
//  WYAAttentionTableViewCell.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/12.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYAAttentionModel.h"
@class WYAAttentionTableViewCell;
@protocol WYAAttentionTableViewCellDelegate <NSObject>
- (void)attentionButtonClicked:(WYAAttentionTableViewCell *)tager;
@end

@interface WYAAttentionTableViewCell : UITableViewCell
@property(nonatomic, weak) id <WYAAttentionTableViewCellDelegate> delegate;
@property(nonatomic, strong) WYAAttentionModel * model;
@property(nonatomic, strong) UIButton * attentionBtn;

@end
