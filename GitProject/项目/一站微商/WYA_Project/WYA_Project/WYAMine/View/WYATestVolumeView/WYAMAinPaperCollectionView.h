//
//  WYAMAinPaperCollectionView.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/27.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//主账号的测试试卷

#import <UIKit/UIKit.h>
@class WYAMAinPaperCollectionView;
@protocol WYAMAinPaperCollectionViewDelegate <NSObject>
- (void)mainPaperView:(WYAMAinPaperCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end
@interface WYAMAinPaperCollectionView : UICollectionView
@property(nonatomic, strong) NSMutableArray * myDataSources;
@property(nonatomic, weak) id <WYAMAinPaperCollectionViewDelegate> mainPaperDelegate;
@end
