//
//  WYASearchView.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/24.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WYASearchBarDelegate<NSObject>
/**
 * 取消搜索按钮点击
 */
- (void)searchCancleBtnClicked:(UIButton *)sender;
/**
 * 搜索按钮的点击
 */
- (void)searchBtnClicked:(NSString *)searceContent;
@end
@interface WYASearchView : UIView
@property(nonatomic, weak) id<WYASearchBarDelegate> delegate;
@property(nonatomic, strong) UITextField * searchTextFiled;

@end
