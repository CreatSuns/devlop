//
//  WYAArticleDetailsBottomView.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/26.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYAArticleDetailModel.h"
@protocol WYAArticleDetailsBottomViewDelegate <NSObject>
- (void)bottomViewFocusSelected:(UIImageView*)sender;
- (void)bottomViewThumSelected:(UIImageView*)sender;
- (void)bottomViewCollectionSelected:(UIImageView*)sender;

@end
@interface WYAArticleDetailsBottomView : UIView
@property(nonatomic, strong) WYAArticleDetailModel * model;
@property(nonatomic, weak) id<WYAArticleDetailsBottomViewDelegate> delegate;
@end
