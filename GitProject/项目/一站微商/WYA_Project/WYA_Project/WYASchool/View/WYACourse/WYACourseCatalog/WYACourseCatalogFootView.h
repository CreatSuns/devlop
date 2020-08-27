//
//  WYACourseCatalogFootView.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/14.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYACourseCatalogModel.h"

typedef NS_ENUM(NSUInteger, GroupTestPaperType) {
    GroupNeedTestPaper,
    GroupWatchTestPaper,
};

@interface WYACourseCatalogFootView : UITableViewHeaderFooterView

@property (nonatomic, strong) WYACourseCatalogGroupPaperModel * model;

@property (nonatomic, copy)void(^testPaper)(GroupTestPaperType paperType, NSString * papaerID);

@end
