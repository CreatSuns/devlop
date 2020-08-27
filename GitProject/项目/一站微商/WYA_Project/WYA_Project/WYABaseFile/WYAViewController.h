//
//  WYAViewController.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/4.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYAViewController : UIViewController
- (void)addNavRightButtonWithTitle:(NSString *)title TitleColor:(UIColor *)titleColor;

- (void)addNavRightButtonWithImageNamed:(NSString *)named;

- (void)rightBarButtonItemClicked:(UIButton *)sender;
- (void)addCustomNavLeftButton;

- (void)goBack:(UIButton *)sender;
@end
