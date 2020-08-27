//
//  WYAOpinionView.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/9.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYAOpinionView : UIView

@property (nonatomic, copy)void(^submitOpinion)(NSString * text);

@end
