//
//  WYATestDoubleSelectedTableViewCell.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/16.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, WYATestTestDoubleSelectedCell) {
    WYATestTestDoubleSelected,//可以点击
    WYATestTestDoubleUnSelected,//不可点击
};
#import "WYATestQuestionListModel.h"
//@class WYATestDoubleSelectedTableViewCell;
//@protocol WYATestDoubleSelectedTableViewCellDelegate<NSObject>
//- (void)doubleChooseAnswerButtonClicked:(WYATestDoubleSelectedTableViewCell *)target;
//@end
@interface WYATestDoubleSelectedTableViewCell : UITableViewCell
@property(nonatomic,assign)WYATestTestDoubleSelectedCell isDoubleTouchUpInsde;
@property(nonatomic, copy) NSString * paperId;
@property(nonatomic, strong) WYATestQuestionListModel * listModel;
+ (CGFloat)cellHeightWithModel:(WYATestQuestionListModel *)model;
@property(nonatomic, assign) NSInteger * selectIndex;
//@property(nonatomic, weak) id<WYATestDoubleSelectedTableViewCellDelegate> delegate;
@end
