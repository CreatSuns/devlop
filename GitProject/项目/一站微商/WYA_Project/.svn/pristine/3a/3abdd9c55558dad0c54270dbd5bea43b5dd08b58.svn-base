//
//  WYAAnswerCardViewController.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/17.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//答题报告进入的答题卡

#import "WYAPadsingCardViewController.h"
#import "WYAAnswerCardCollectionViewCell.h"
#import "WYAAnswerCardHeaderView.h"
#import "WYATestVolumeViewController.h"
#import "WYATestVolumeNetRequest.h"
#import "WYAJHAnswerModel.h"
#import "WYACardReportBottomView.h"
#import "UIView+WYALayout.h"
#import "WYAPadsingDetailsViewController.h"


#define AnswerCardCellID @"WYAAnswerCardCollectionViewCell"
#define AnswerHeaderView @"WYAAnswerCardHeaderView"


@interface WYAPadsingCardViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,WYACardReportBottomViewdelegate>
@property(nonatomic, strong) UICollectionView * collectionView;
@property(nonatomic, strong) WYATestVolumeNetRequest * netRequest;
@property(nonatomic, strong) WYACardReportBottomView * bottomView;
@property(nonatomic, strong) UIView * myBottomView;
@end

@implementation WYAPadsingCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"答题卡";
    _dataSources = [NSMutableArray array];
    [self requestAllQuestionNum];
    self.view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.collectionView];
    if ([self.isShowBottomItem isEqualToString:@"1"]) {
        [self addBottomView];
    }else{
        [self addToastBottomView];
    }
//    根据测试次数判断是否展示重新测试功能
    if ([self.itemNum integerValue]!=3) {
        [self addNavRightButtonWithTitle:@"重新测试" TitleColor:nil];
    }

    [self requestAllQuestionNum];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)rightBarButtonItemClicked:(UIButton *)sender
{
    [super rightBarButtonItemClicked:sender];
       // 进入测试题界面
    WYATestVolumeViewController * vc = [[WYATestVolumeViewController alloc]init];
    vc.pushFromWhere = WYATestPushForReportVc;
    vc.paper_id = self.paper_id;
    JQFMDB * db = [JQFMDB shareDatabase];
    [db jq_deleteAllDataFromTable:ANSWE_DataBase];
    [self.navigationController pushViewController:vc animated:YES];
    // 获取进入时间
    NSString * currentSceonds = [WYAJHTools getNowTimeTimestampForSeconds];
    [[NSUserDefaults standardUserDefaults] setObject:currentSceonds forKey:@"beginTime"];
}
#pragma mark ====== netRequest
- (WYATestVolumeNetRequest *)netRequest
{
    if (_netRequest == nil) {
        _netRequest = [[WYATestVolumeNetRequest alloc]init];
    }
    return _netRequest;
}
// 所有题目
- (void)requestAllQuestionNum
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"paper_id"] = self.paper_id;
    dic[@"exam_time"] = self.examTime;
    dic[@"status"] = @"2";
    [self.netRequest testQuestionDeatiledReportWithParams:dic Success:^(id data) {
        self.dataSources = data;
        [self.collectionView reloadData];
        NSLog(@"%@",data);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}

#pragma mark ====== creat CollectionView
- (void)addToastBottomView{
    UILabel * toastLabel= [[UILabel alloc]init];
    [self.view addSubview:toastLabel];
    [toastLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(WYATabBarHeight);
    }];
    toastLabel.text = [NSString stringWithFormat:@"成绩大于等于%@分或第三次可看详细解析",self.passScore];
    toastLabel.backgroundColor = [UIColor WYAJHLightGreyColor];
    toastLabel.textColor = [UIColor WYAJHgrayTextColor];
    toastLabel.font = [UIFont systemFontOfSize:13*Size_ratio];
    toastLabel.textAlignment = NSTextAlignmentCenter;
}
- (void)addBottomView
{
    _myBottomView = [[UIView alloc]init];
    [self.view addSubview:_myBottomView];
    [_myBottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(WYATabBarHeight);
    }];
    _bottomView = [[WYACardReportBottomView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,WYATabBarHeight)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    _bottomView.isShowWrongTopicBtn = self.isLookErrorQuestion;
    _bottomView.delegate = self;
    [_myBottomView addSubview:_bottomView];
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //横向最小距离
        layout.minimumInteritemSpacing = 24*Size_ratio;
        //代表的是纵向的空间间隔
        layout.minimumLineSpacing=30*Size_ratio;
        
        layout.itemSize = CGSizeMake(44.5*Size_ratio, 44.5*Size_ratio);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.headerReferenceSize = CGSizeMake(ScreenWidth, 36*Size_ratio);
        
        layout.sectionInset = UIEdgeInsetsMake(10*Size_ratio, 10*Size_ratio, 10*Size_ratio, 10*Size_ratio);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-44-WYAStatusBarHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
#pragma mark ====== 注册单元格
        [_collectionView registerClass:[WYAAnswerCardCollectionViewCell class] forCellWithReuseIdentifier:AnswerCardCellID];
#pragma mark ====== 注册头部视图
        [_collectionView registerClass:[WYAAnswerCardHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:AnswerHeaderView];
    }
    return _collectionView;
}
#pragma mark UICollectionViewDataSource
//有多少个Section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataSources.count;
}

//设置每个分区的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataSources[section] count];
}

//设置返回每个item的属性必须实现）
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WYAAnswerCardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AnswerCardCellID forIndexPath:indexPath];
    
   NSArray * dataArray = [self.dataSources[indexPath.section] objectAtIndex:indexPath.row];
    cell.cardLabel.text = [dataArray firstObject];
    cell.cardLabel.textColor = [UIColor WYAJHBlackTextColor];
    cell.cardLabel.backgroundColor = [UIColor whiteColor];
    
    NSString * isSelected = [dataArray lastObject];
    if ([isSelected isEqualToString:@"1"]) {
        cell.cardLabel.backgroundColor = [UIColor WYAJHCardPurpleColor];
        cell.cardLabel.textColor = [UIColor WYAJHBasePurpleColor];
    }else if ([isSelected isEqualToString:@"0"])
    {
        cell.cardLabel.backgroundColor = [UIColor WYAJHCardRedColor];
        cell.cardLabel.textColor = [UIColor WYAJHBaseRedColor];
    }
    return cell;
}

//对头视图或者尾视图进行设置
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        identifier = AnswerHeaderView;
        WYAAnswerCardHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:AnswerHeaderView forIndexPath:indexPath];
        NSString * string ;
        switch (indexPath.section) {
            case 0:
                string = @"   单选题";
                break;
            case 1:
                string = @"   多选题";
                break;
            case 2:
                string = @"   判断选题";
                break;
            case 3:
                string = @"   案例分析题";
                break;
                
            default:
                break;
        }
        view.headerLabel.text = string;
        return view;
    }
    return nil;
}
#pragma mark WYACardReportBottomViewdelegate
- (void)lookWrongTopicPadsing:(UIButton *)sender
{
    if (self.isLookErrorQuestion) {
        WYAPadsingDetailsViewController * vc = [[WYAPadsingDetailsViewController alloc]init];
        vc.navTitle = @"错题解析";
        vc.paper_id = self.paper_id;
        vc.examTime = self.examTime;
        vc.itemNum = self.itemNum;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)lookAllTopicPadsing:(UIButton *)sender
{
    WYAPadsingDetailsViewController * vc = [[WYAPadsingDetailsViewController alloc]init];
    vc.navTitle = @"全部解析";
    vc.paper_id = self.paper_id;
    vc.examTime = self.examTime;
    vc.itemNum = self.itemNum;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
