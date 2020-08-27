//
//  WYASearchModel.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/24.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYASearchModel.h"
#import "WYASearchCourseModel.h"
#import "WYAArticleListModel.h"
#import "WYALecturerModel.h"
@implementation WYASearchModel
+ (instancetype)searchModelWith:(id)respone{
    WYASearchModel * model = [[WYASearchModel alloc]init];
    NSArray * dataArray = respone[@"data"];
    NSDictionary * dataDic = dataArray[0];
    NSDictionary * articleDic = dataDic[@"article"];
    model.searchArticleArray = [NSMutableArray array];
    model.searchArticleArray = [WYAArticleListModel searchArticleModelWith:articleDic];
    NSDictionary * courseDic = dataDic[@"course"];
    model.searchCourseArray = [NSMutableArray array];
    model.searchCourseArray = [WYASearchCourseModel searchCourseModelWith:courseDic];
    NSDictionary * teacherDic = dataDic[@"teacher"];
    model.searchLectureArray = [NSMutableArray array];
    model.searchLectureArray = [WYALecturerModel searchLecturerModelWith:teacherDic];
    return model;
}
@end
