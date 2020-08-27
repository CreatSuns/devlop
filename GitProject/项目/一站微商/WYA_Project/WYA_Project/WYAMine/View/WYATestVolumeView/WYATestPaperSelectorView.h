//
//  WYATestPaperSelectorView.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/19.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol seletorDelegete <NSObject>

- (void)selectedChapterWithButton:(UIButton *)sender;

- (void)selectedPeopleWithButton:(UIButton *)sender;

@end

@interface WYATestPaperSelectorView : UIView

@property (nonatomic, weak)id<seletorDelegete> delegate;

@property (nonatomic, copy) NSString * peopleName;

@property (nonatomic, copy) NSString * chapterName;

@end
