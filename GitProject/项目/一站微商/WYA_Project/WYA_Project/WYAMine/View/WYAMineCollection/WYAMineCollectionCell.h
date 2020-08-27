//
//  WYAMineCollectionCell.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/16.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYAMineCollectionCell : UITableViewCell

@property (nonatomic, weak) id model;

@property (nonatomic, copy) void(^deleteButtonClick)(NSString * collectionID);

@end
