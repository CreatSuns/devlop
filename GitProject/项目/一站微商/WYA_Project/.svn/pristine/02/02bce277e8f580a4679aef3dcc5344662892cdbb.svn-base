//
//  WYATestPaperPeopleAndChapterModel.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/18.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYATestPaperPeopleAndChapterModel.h"

@implementation WYATestPaperPeopleModel

@end


@implementation WYATestPaperChapterModel

@end

@implementation WYATestPaperPeopleAndChapterModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic{
    if (!dic[@"group_name"]) {
        return NO;
    }
    if (!dic[@"user"]) {
        return NO;
    }
    return YES;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"group_name" : [WYATestPaperChapterModel class],
             @"user" : [WYATestPaperPeopleModel class],
             };
}

@end
