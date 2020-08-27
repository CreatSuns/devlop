//
//  WYAMineTableView.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/8.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WYAMineTableViewDelegate <NSObject>
/**
 * cell点击事件
 */
- (void)WYAMineTableViewDidSelectCell:(NSInteger)index;
@end
@interface WYAMineTableView : UITableView
@property(nonatomic, weak)id <WYAMineTableViewDelegate> mineDelegate;
@end
