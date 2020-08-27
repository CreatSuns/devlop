//
//  WYATestSingleSelectedTableViewCell.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/14.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, WYATestTestSingleSelected) {
    WYATestTestSelected,//可以点击
    WYATestTestUnSelected,//不可点击
};
#import "WYATestQuestionListModel.h"
//@protocol WYATestQuestionListDelegate<NSObject>
//- (void)chooseAnswerButtonClicked:(UIButton *)sender;
//@end
@interface WYATestSingleSelectedTableViewCell : UITableViewCell
@property(nonatomic, strong) WYATestQuestionListModel * listModel;
@property(nonatomic,assign)WYATestTestSingleSelected isTouchUpInsde;
@property(nonatomic, copy) NSString * paperId;
+ (CGFloat)cellHeightWithModel:(WYATestQuestionListModel *)model;
//@property(nonatomic, weak) id<WYATestQuestionListDelegate> delegate;
@end
