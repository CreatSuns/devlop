//
//  WYAPadsingDetailsCell.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/23.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYACardParsingListModel.h"

@interface WYAPadsingDetailsCell : UITableViewCell
@property(nonatomic, strong) WYACardParsingListModel * listModel;
+ (CGFloat)cellHeightWithModel:(WYACardParsingListModel *)model;
@end
