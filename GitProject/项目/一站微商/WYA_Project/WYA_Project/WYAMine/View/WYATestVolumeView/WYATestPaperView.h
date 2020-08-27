//
//  WYATestPaperView.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/18.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WYATestPaperPeopleAndChapterModel;
@class WYATestPaperModel;


@protocol TestPaperDelegate <NSObject>

/**
 检索条件事件

 @param chapter 章节
 @param people 人员
 */
- (void)searchTestPaperWithChapter:(NSString *)chapter People:(NSString *)people;

/**
 点击collectionCell触发事件

 @param userID userID
 */
- (void)collectionCellDidSelectedWithString:(NSString *)userID;

@end

@interface WYATestPaperView : UIView

@property (nonatomic, strong) WYATestPaperPeopleAndChapterModel * peopleAndChapterModel;
@property (nonatomic, strong) WYATestPaperModel * testPaperModel;
@property (nonatomic, strong) NSMutableArray * array;

@property (nonatomic, weak) id<TestPaperDelegate> delegate;

@property (nonatomic, assign) BOOL needSelector;



@end
