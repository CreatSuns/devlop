//
//  WYAMainPaperListModel.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/27.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMainPaperListModel.h"

@implementation WYAMainPaperListModel
+ (NSMutableArray *)mainPaperListModelWith:(id)respone
{
    NSMutableArray * returnArray = [NSMutableArray array];
    NSMutableArray * saveSectionArray = [NSMutableArray array];
    NSDictionary * dataDic = respone[@"data"];
    NSArray * listArray = dataDic[@"list"];
    if (listArray&&listArray.count!=0) {
        NSString * tempStr = [listArray[0] objectForKey:@"group_name"];
        NSString * oldGroupName = [tempStr isEqualToString:@""]?@"第一章":tempStr;
        for (int i = 0;i<listArray.count;i++) {
            NSDictionary * dict = listArray[i];
            NSString * groupName = [dict[@"group_name"] isEqualToString:@""] ? @"第一章":dict[@"group_name"];
            if ([groupName isEqualToString:oldGroupName]) {
                WYAMainPaperListModel * model = [[WYAMainPaperListModel alloc]init];
                model.paper_id = checkString(dict[@"paper_id"]);
                model.chapter_id = checkString(dict[@"chapter_id"]);
                model.group_id = checkString(dict[@"group_id"]);
                model.count = checkString(dict[@"count"]);
                model.paper_name = checkString(dict[@"paper_name"]);
                model.score = checkString(dict[@"score"]);
                model.group_name = groupName;
                [saveSectionArray addObject:model];
                if (i == listArray.count-1) {
                    [returnArray addObject:saveSectionArray];
                }
            }else
            {
                NSArray * tempArray = [saveSectionArray copy];
                [returnArray addObject:tempArray];
                [saveSectionArray removeAllObjects];
                WYAMainPaperListModel * model = [[WYAMainPaperListModel alloc]init];
                model.paper_id = checkString(dict[@"paper_id"]);
                model.chapter_id = checkString(dict[@"chapter_id"]);
                model.group_id = checkString(dict[@"group_id"]);
                model.count = checkString(dict[@"count"]);
                model.paper_name = checkString(dict[@"paper_name"]);
                model.score = checkString(dict[@"score"]);
                model.group_name = groupName;
                [saveSectionArray addObject:model];
                if (i==listArray.count-1) {
                    [returnArray addObject:saveSectionArray];
                }
            }
            oldGroupName = groupName;
        }
        
    }
    
    return returnArray;
}
@end
