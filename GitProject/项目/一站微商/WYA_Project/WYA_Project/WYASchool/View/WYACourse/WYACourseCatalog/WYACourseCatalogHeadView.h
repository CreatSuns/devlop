//
//  WYACourseCatalogHeadView.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/13.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYACourseCatalogModel.h"

typedef void(^HeaderViewClickedBack)(BOOL);

@interface WYACourseCatalogHeadView : UITableViewHeaderFooterView

@property (nonatomic, strong) WYACourseCatalogGroupsModel * model;
@property (nonatomic, copy)   HeaderViewClickedBack HeaderClickedBack;

@end
