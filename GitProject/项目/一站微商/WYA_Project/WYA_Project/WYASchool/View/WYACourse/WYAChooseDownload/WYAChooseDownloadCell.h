//
//  WYAChooseDownloadCell.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/23.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYAChooseDownloadMolde.h"
#import "WYALocalDownloadModel.h"
@interface WYAChooseDownloadCell : UITableViewCell

@property (nonatomic, strong) UIButton * chooseButton;

@property (nonatomic, strong) WYAChooseChapterModel * model;

@property (nonatomic, strong) NSArray * downArray;

@property (nonatomic, strong) NSArray * localArray;

@property (nonatomic, strong) WYALocalDownloadModel * localModel;

@property (nonatomic, copy) NSString * stateString;

@property (nonatomic, assign) BOOL isDeleteVideo;

@end
