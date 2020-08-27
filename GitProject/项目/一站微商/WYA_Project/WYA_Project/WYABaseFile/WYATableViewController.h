//
//  WYATableViewController.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/8.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYATableViewController : UITableViewController

/**
 是否需要刷新功能(暂不使用，默认为需要刷新)
 */
@property (nonatomic, assign) BOOL needRefresh;

/**
 替换网络数据为空或无网络连接视图（设置之后不需要调用cy_reloadData方法）
 */
@property (nonatomic, strong) UIView * replacePlaceholdView;

@end
