//
//  WYAChooseDownloadVC.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/23.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAViewController.h"

@interface WYAChooseDownloadVC : WYAViewController

@property (nonatomic, copy) NSString * courseID;

@property (nonatomic, copy) NSString * course_name;

/**
 是否允许乱序播放
 */
@property (nonatomic, copy) NSString * skip;

@end
