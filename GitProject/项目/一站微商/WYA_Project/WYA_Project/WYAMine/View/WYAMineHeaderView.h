//
//  WYAMineHeaderView.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/8.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYAAdminInfoModel.h"
@protocol WYAMineHeaderViewDelegate <NSObject>
/**
 * 用户头像点击事件
 */
- (void)userIconClickedEvent:(UIButton *)sender;
/**
 * 课表点击事件
 */
- (void)classTableClickedEvent:(UIButton *)sender;
/**
 * 测试成绩点击事件
 */
- (void)testScoresClickedEvent:(UIButton *)sender;
/**
 * 新课上架
 */
- (void)courseNewClickedEvent:(UIButton *)sender;
@end
@interface WYAMineHeaderView : UIView
@property (nonatomic,readwrite,weak)id <WYAMineHeaderViewDelegate> delegate;
@property(nonatomic, strong) WYAAdminInfoModel * model;
@end
