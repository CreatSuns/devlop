//
//  WYACourseCatalogModel.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/13.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYACourseCatalogModel.h"

@implementation WYACourseCatalogChapterPaperModel

@end

@implementation WYACourseCatalogGroupPaperModel

@end

@implementation WYACourseCatalogChaptersModel
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"chapter_paper":[WYACourseCatalogChapterPaperModel class]};
}
//+ (NSDictionary *)modelCustomPropertyMapper {
//    return@{@"chapterProcess" :@"process"};
//}

@end

@implementation WYACourseCatalogGroupsModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"chapters" : [WYACourseCatalogChaptersModel class],
             @"group_paper":[WYACourseCatalogGroupPaperModel class]
             };
}



@end

@implementation WYACourseCatalogCoursePaperModel

@end

@implementation WYACourseCatalogModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"groups" : [WYACourseCatalogGroupsModel class],
             @"course_paper" : [WYACourseCatalogCoursePaperModel class],
             };
}

@end
