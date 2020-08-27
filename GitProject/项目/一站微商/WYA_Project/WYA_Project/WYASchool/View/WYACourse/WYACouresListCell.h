//
//  WYACouresListCell.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/8.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYASearchCourseModel.h"

@class List;

@interface WYACouresListCell : UITableViewCell

@property (nonatomic, strong) List * model;
@property (nonatomic, strong) WYASearchCourseModel * searchModel;

@end
