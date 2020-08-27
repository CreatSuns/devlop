//
//  WYAMAinPaperCollectionView.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/27.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMAinPaperCollectionView.h"
#import "WYATestPaperCell.h"
#import "WYATestPaperCollectionHeadView.h"
#import "WYAMainPaperListModel.h"
static NSString * collectionCell = @"collectionCell";
static NSString * collectionHead = @"collectionHead";
@interface WYAMAinPaperCollectionView()<UICollectionViewDelegate, UICollectionViewDataSource>

@end
@implementation WYAMAinPaperCollectionView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor WYAJHLightGreyColor];
        [self registerClass:[WYATestPaperCell class] forCellWithReuseIdentifier:collectionCell];
        [self registerClass:[WYATestPaperCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHead];
    }
    return self;
}
-(void)setMyDataSources:(NSMutableArray *)myDataSources{
        _myDataSources = [NSMutableArray array];
        _myDataSources = myDataSources;
    [self reloadData];
}

#pragma make UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.myDataSources.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray * array = self.myDataSources[section];
    return array.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WYATestPaperCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    WYAMainPaperListModel * model = [self.myDataSources[indexPath.section] objectAtIndex:indexPath.row];
    cell.chapterNumberLabel.text = model.paper_name;
    cell.topicNumberLabel.text = [NSString stringWithFormat:@"本卷共%@题",model.count];
    cell.paperMainModel = model;
    return cell;
}

/** 头部/底部*/
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        // 头部
        WYATestPaperCollectionHeadView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:collectionHead forIndexPath:indexPath];
        WYAMainPaperListModel * listModel = [self.myDataSources[indexPath.section] objectAtIndex:indexPath.row];
//        view.title = listModel.group_name;
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40*Size_ratio)];
        label.font = [UIFont systemFontOfSize:17*Size_ratio];
        label.textColor = [UIColor WYAJHgrayTextColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor WYAJHLightGreyColor];
        label.text = listModel.group_name;
        [view addSubview:label];
        return view;
        
    }else{
        return nil;
    }
}

#pragma mark  UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.mainPaperDelegate&&[self.mainPaperDelegate respondsToSelector:@selector(mainPaperView:didSelectItemAtIndexPath:)]) {
        [self.mainPaperDelegate mainPaperView:self didSelectItemAtIndexPath:indexPath];
    }
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
@end
