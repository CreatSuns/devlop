//
//  WYAChooseDownloadCell.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/23.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "STDTableViewCell.h"
#import "WYAChooseDownloadMolde.h"
@interface WYAChooseDownloadCell : STDTableViewCell

@property (nonatomic, strong) UIButton * chooseButton;

@property (nonatomic, copy) void(^downloadSelector)(WYAChooseChapterModel * model);

@end
