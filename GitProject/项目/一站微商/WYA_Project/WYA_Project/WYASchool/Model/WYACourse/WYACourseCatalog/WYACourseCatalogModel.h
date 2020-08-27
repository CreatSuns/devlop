//
//  WYACourseCatalogModel.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/13.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYACourseCatalogChapterPaperModel : NSObject

@property (nonatomic, copy) NSString * paper_id;

@property (nonatomic, copy) NSString * paper_title;

@property (nonatomic, copy) NSString * exam_id;
@property (nonatomic, copy) NSString * points;
@end

@interface WYACourseCatalogChaptersModel : NSObject



@property (nonatomic, copy) NSString * chapter_id;

@property (nonatomic, copy) NSString * chapter_title;
@property (nonatomic, copy) NSString * group_id;
@property (nonatomic, copy) NSString * video_size;
@property (nonatomic, copy) NSString * video_url;
@property (nonatomic, copy) NSString * video_length;
@property (nonatomic, copy) NSString * process;
@property (nonatomic, assign) NSInteger is_completed;
@property (nonatomic, assign) NSInteger can_play;
//@property (nonatomic, assign) NSInteger chapterProcess;
//@property (nonatomic, copy) NSString * download_status;
//@property (nonatomic, copy) NSString * download_status_id;

@property (nonatomic, strong) WYACourseCatalogChapterPaperModel * chapter_paper;
@end

@interface WYACourseCatalogGroupPaperModel : NSObject

@property (nonatomic, copy) NSString * paper_id;

@property (nonatomic, copy) NSString * paper_title;

@property (nonatomic, copy) NSString * exam_id;
@property (nonatomic, copy) NSString * points;
@end

@interface WYACourseCatalogGroupsModel : NSObject

@property (nonatomic, assign) BOOL flag;

@property (nonatomic, strong) NSMutableArray * chapters;

@property (nonatomic, copy) NSString * group_id;

@property (nonatomic, copy) NSString * group_title;

@property (nonatomic, strong) WYACourseCatalogGroupPaperModel * group_paper;

@end


@interface WYACourseCatalogCoursePaperModel : NSObject

@property (nonatomic, copy) NSString * paper_id;

@property (nonatomic, copy) NSString * paper_title;

@property (nonatomic, copy) NSString * exam_id;
@property (nonatomic, copy) NSString * points;

@end

@interface WYACourseCatalogModel : NSObject

@property (nonatomic, strong) NSMutableArray * groups;

@property (nonatomic, strong) WYACourseCatalogCoursePaperModel * course_paper;
@end
