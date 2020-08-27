//
//  WYANewCourseCell.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/10.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ThisMonth;

@class LastMonth;

@interface WYANewCourseCell : UITableViewCell

@property (nonatomic, strong) ThisMonth * thisModel;

@property (nonatomic, strong) LastMonth * lastModel;

@end
