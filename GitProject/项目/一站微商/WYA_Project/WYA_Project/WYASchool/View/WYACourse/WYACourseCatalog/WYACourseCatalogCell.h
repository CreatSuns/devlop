//
//  WYACourseCatalogCell.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/13.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYACourseCatalogModel.h"

typedef NS_ENUM(NSUInteger, ChapterTestPaperType) {
    ChapterNeedTestPaper,
    ChapterWatchTestPaper,
};


@interface WYACourseCatalogCell : UITableViewCell

@property (nonatomic, strong) WYACourseCatalogChaptersModel * model;
@property (nonatomic, strong) WYACourseCatalogChaptersModel * pushModel;
@property (nonatomic, strong) WYACourseCatalogChaptersModel * currentModel;
@property (nonatomic, strong) UILabel * videoTitleLabel;

@property (nonatomic, strong) UILabel * downloadlabel;


@property (nonatomic, strong)void(^canWatchVideo)(WYACourseCatalogChaptersModel * chapterModel);

@property (nonatomic, strong)void(^testPaper)(ChapterTestPaperType paperType, NSString * paperID);

//@property (nonatomic, weak) id<catalogDelegate> cellDelegate;

+ (CGFloat)cellHeight:(WYACourseCatalogChaptersModel *)model;

@end
