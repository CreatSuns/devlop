//
//  WYAChooseDownloadMolde.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/23.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYAChooseChapterModel : NSObject

@property (nonatomic, copy) NSString * chapter_id;
@property (nonatomic, copy) NSString * chapter_title;
@property (nonatomic, copy) NSString * article_id;
@property (nonatomic, copy) NSString * video_size;
@property (nonatomic, copy) NSString * video_url;
@property (nonatomic, copy) NSString * video_length;
@property (nonatomic, copy) NSString * process;
@property (nonatomic, copy) NSString * can_play;
@property (nonatomic, assign)  NSInteger can_download;
@property (nonatomic, copy) NSString * download_status;
@property (nonatomic, copy) NSString * download_status_id;
@end

@interface WYAChooseGroupModel : NSObject

@property (nonatomic, copy) NSString * group_id;
@property (nonatomic, copy) NSString * group_title;
@property (nonatomic, strong) NSArray * chapters;
@property (nonatomic, assign) BOOL flag;
@end

@interface WYAChooseDownloadMolde : NSObject

@property (nonatomic, strong) NSArray * data;

@end
