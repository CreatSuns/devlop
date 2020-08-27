//
//  WYALecturerHeaderView.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/10.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYALecturerHeaderModel.h"

@protocol WYALecturerHeaderDelegate <NSObject>
/**
 * 关注或者取消关注
 */
- (void)attentionButtonClicked:(UIButton *)sender;
@end
@interface WYALecturerHeaderView : UIView
@property(nonatomic, strong) WYALecturerHeaderModel * model;
@property(nonatomic, weak) id<WYALecturerHeaderDelegate> delegate;
@end
