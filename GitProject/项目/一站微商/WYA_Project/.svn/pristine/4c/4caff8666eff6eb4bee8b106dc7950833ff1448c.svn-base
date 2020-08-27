//
//  WYALecturerPageView.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/10.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYALecturerHeaderModel.h"
@protocol WYALecturerPageViewDelegate <NSObject>
/**
 * 课程点击事件
 */
- (void)courseButtonClickedEvent:(UIButton *)sender;
/**
 * 文章点击事件
 */
- (void)articleButtonClickedEvent:(UIButton *)sender;

@end
@interface WYALecturerPageView : UIView
//@property(nonatomic,assign)NSInteger selectIndex;
@property(nonatomic, strong) UIButton * leftButton;
@property(nonatomic, strong) UILabel * leftLineLabel;
@property(nonatomic, strong) UIButton * rightButton;
@property(nonatomic, strong) UILabel * rightLineLabel;
@property(nonatomic, weak) id <WYALecturerPageViewDelegate> delegate;
@property(nonatomic, strong) WYALecturerHeaderModel * model;
@end
