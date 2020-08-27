//
//  WYACourseCatalogHeadView.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/13.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYAChooseDownloadMolde.h"

typedef void(^HeaderViewClickedBack)(BOOL);

@interface WYAChooseDownloadHeadView : UITableViewHeaderFooterView

@property (nonatomic, strong) WYAChooseGroupModel * model;
@property (nonatomic, copy) HeaderViewClickedBack HeaderClickedBack;

@end
