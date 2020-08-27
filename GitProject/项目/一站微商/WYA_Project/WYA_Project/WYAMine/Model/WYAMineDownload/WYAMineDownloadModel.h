//
//  WYAMineDownloadModel.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/20.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYAVideoDownloadModel : NSObject

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, copy)  NSString * course_id;

@property (nonatomic, copy)  NSString * img_url;

@property (nonatomic, copy)  NSString * size;

@property (nonatomic, copy)  NSString * title;

@end

@interface WYAArticleDownloadModel : NSObject

@property (nonatomic, copy)  NSString * size;

@property (nonatomic, copy)  NSString * ext;

@property (nonatomic, copy)  NSString * article_id;

@property (nonatomic, copy)  NSString * title;

@property (nonatomic, copy)  NSString * url;
@end

@interface WYAMineDownloadModel : NSObject

@property (nonatomic, copy) NSString * downloading;

@property (nonatomic, strong) NSArray * article_download;

@property (nonatomic, strong) NSArray * video_download;

@end
