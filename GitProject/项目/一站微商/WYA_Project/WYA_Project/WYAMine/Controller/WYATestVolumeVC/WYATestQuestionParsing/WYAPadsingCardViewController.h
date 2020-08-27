//
//  WYAPadsingCardViewController.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/18.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAViewController.h"

@interface WYAPadsingCardViewController : WYAViewController
@property(nonatomic, copy) NSString * paper_id;//试卷ID
@property(nonatomic, copy) NSString * examTime;//第几次考试
@property(nonatomic, assign) BOOL  isLookErrorQuestion;//是否可以查看错题解析
@property(nonatomic, assign) BOOL  isSetScore;//是否设置达标分数
@property(nonatomic, assign) BOOL  isMoreThanSetScore;//成绩是否达标
@property(nonatomic, copy)NSString * myScore;//我的成绩
@property(nonatomic, copy) NSString * passScore;// 达标成绩
@property(nonatomic, strong) NSMutableArray * dataSources;
@property(nonatomic, copy) NSString * isShowBottomItem;
@property(nonatomic, copy) NSString * itemNum;
@end
