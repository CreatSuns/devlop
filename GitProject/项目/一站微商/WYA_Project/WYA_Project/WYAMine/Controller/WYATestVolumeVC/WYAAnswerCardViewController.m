//
//  WYAAnswerCardViewController.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/17.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//测试题中的答题卡

#import "WYAAnswerCardViewController.h"
#import "WYAAnswerCardCollectionViewCell.h"
#import "WYAAnswerCardHeaderView.h"
#import "WYATestVolumeViewController.h"
#import "WYATestVolumeNetRequest.h"
#import "WYAJHAnswerModel.h"
#import "WYAReportViewController.h"// 答题报告

#define AnswerCardCellID @"WYAAnswerCardCollectionViewCell"
#define AnswerHeaderView @"WYAAnswerCardHeaderView"
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
@interface WYAAnswerCardViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic, strong) UICollectionView * collectionView;
@property(nonatomic, strong) WYATestVolumeNetRequest * netRequest;
@property(nonatomic, strong) NSMutableArray * allAnswerArray;
@property(nonatomic, copy) NSString * endAnswer;
@end

@implementation WYAAnswerCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"答题卡";
    _allAnswerArray = [NSMutableArray array];
    _dataSources = [NSMutableArray array];
    [self requestAllQuestionNum];
    self.view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.collectionView];
    [self addNavRightButtonWithTitle:@"交卷" TitleColor:nil];
    [self requestAllQuestionNum];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)rightBarButtonItemClicked:(UIButton *)sender
{
    [super rightBarButtonItemClicked:sender];
    [_allAnswerArray removeAllObjects];
    JQFMDB * db = [JQFMDB shareDatabase];
//    NSDictionary * dict = [self.dataSources[3] lastObject];
    for (int i = 0; i<[self.answerCount intValue]; i++) {
        // 查询条件
        NSString * searchString = [NSString stringWithFormat:@"where question_number = '%d'",i+1];
        //查询结果
        NSArray * answerArr = [db jq_lookupTable:ANSWE_DataBase dicOrModel:[WYAJHAnswerModel class] whereFormat:searchString];
        // 判断这个数组是否存在，查到说明这个题目选择过没查到就是没有
        if (answerArr.count==0) {
            // 加入一个空数据
            NSDictionary * dic = [NSDictionary dictionaryWithObject:@"" forKey:[NSString stringWithFormat:@"%d",i+1]];
            [_allAnswerArray addObject:dic];
        }else{
            WYAJHAnswerModel * model = answerArr[0];
            if (model.answerString != nil) {
                NSDictionary * dic = [NSDictionary dictionaryWithObject:model.answerString forKey:[NSString stringWithFormat:@"%d",i+1]];
                [_allAnswerArray addObject:dic];
            }
        }
    }
#pragma mark ==== 是否确定交卷
    NSString * answerString = @"";
    if (_allAnswerArray && _allAnswerArray.count != 0) {
        for (int i = 0 ;i<_allAnswerArray.count;i++) {
            if (i<_allAnswerArray.count) {
                NSDictionary * dict = _allAnswerArray[i];
                NSString * key = [[dict allKeys] firstObject];
                NSString * value = [[dict allValues] firstObject];
                answerString = [answerString stringByAppendingFormat:@"{\"%@\":\"%@\"},",key,value];
            }else
            {
                NSDictionary * dict = _allAnswerArray[i];
                NSString * key = [[dict allKeys] firstObject];
                NSString * value = [[dict allValues] firstObject];
                answerString = [answerString stringByAppendingFormat:@"{\"%@\":\"%@\"}",key,value];
                
            }
        }
    }else{
        for (int i = 1; i<[self.answerCount intValue]+1; i++) {
            if (i<[self.answerCount intValue]+1) {
                NSString * key = [NSString stringWithFormat:@"%d",i];
                NSString * value = @"";
                answerString = [answerString stringByAppendingFormat:@"{\"%@\":\"%@\"},",key,value];
            }else
            {
                NSString * key = [NSString stringWithFormat:@"%d",i];
                NSString * value = @"";
                answerString = [answerString stringByAppendingFormat:@"{\"%@\":\"%@\"}",key,value];
            }
            
            }
    }
    NSString * cutAnswerString = [answerString substringToIndex:[answerString length] - 1];
    _endAnswer = [NSString stringWithFormat:@"[%@]",cutAnswerString];
    [self showAlertControllerWithLeftTitle:@"再查一下" topTitle:@"要不要检查一遍再交卷？" rightTitle:@"确认提交"];

}
#pragma mark ====== netReqyest
- (WYATestVolumeNetRequest *)netRequest
{
    if (_netRequest == nil) {
        _netRequest = [[WYATestVolumeNetRequest alloc]init];
    }
    return _netRequest;
}
- (void)requestAllQuestionNum
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"paper_id"] = self.paper_id;
    [self.netRequest testAllQuestionNumWithParams:dic Success:^(id data) {
        self.dataSources = data;
        [self.collectionView reloadData];
        NSLog(@"%@",data);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}

#pragma mark ====== creat CollectionView
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
    
    NSDictionary * cellLabelDic = [self.dataSources[indexPath.section] objectAtIndex:indexPath.row];
    cell.cardLabel.text = [[cellLabelDic allKeys] firstObject];
    cell.cardLabel.textColor = [UIColor WYAJHBlackTextColor];
    cell.cardLabel.backgroundColor = [UIColor whiteColor];

    NSString * isSelected = [[cellLabelDic allValues] firstObject];
    if ([isSelected isEqualToString:@"YES"]) {
        cell.cardLabel.backgroundColor = [UIColor WYAJHBaseGreenColor];
        cell.cardLabel.textColor = [UIColor whiteColor];
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WYAAnswerCardCollectionViewCell * cell = (WYAAnswerCardCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"第%ld组第%ld行被点击",indexPath.section,indexPath.row+1);
    WYATestVolumeViewController * vc = [[WYATestVolumeViewController alloc]init];
    vc.paper_id = self.paper_id;
    vc.question_number = cell.cardLabel.text;//题号
    vc.pushFromWhere = WYATestPushForAnswerCardController;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ====== 弹框
- (void)showAlertControllerWithLeftTitle:(NSString *)leftTitle topTitle:(NSString *)topTitle rightTitle:(NSString *)rightTitle
{
    WYAJHTools * tools = [[WYAJHTools alloc]init];
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:topTitle
                                                                              message:nil
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:leftTitle
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             
                                                             
                                                             
                                                         }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:rightTitle
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         
                                                         [self rightAlertokAction:rightTitle];
                                                     }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}
// 弹框的确定按钮的点击事件
- (void)rightAlertokAction:(NSString *)title
{
        // 拿到数据提交到服务器
                    NSString * overTime = [WYAJHTools getNowTimeTimestampForSeconds];
                    NSString * beginTime = [[NSUserDefaults standardUserDefaults]objectForKey:@"beginTime"];
                    NSInteger times = [overTime integerValue] - [beginTime integerValue];
                    NSString * timeString = [NSString stringWithFormat:@"%ld",times];
                    NSMutableDictionary * params = [NSMutableDictionary dictionary];
                    params[@"paper_id"] = self.paper_id;
                    params[@"time"] = timeString;
                    params[@"comment"] = _endAnswer;
                    [self.netRequest submitTestQuestionListWithParams:params Success:^(id data) {
                        NSLog(@"%@",data);
                        if ([data[@"status"] intValue] == 1) {
                            JQFMDB * fmdb = [JQFMDB shareDatabase];
                            [fmdb jq_deleteTable:ANSWE_DataBase];
                            WYAReportViewController * vc = [[WYAReportViewController alloc]init];
                            vc.paper_id = self.paper_id;
                            vc.isShowTestBtn = YES;
                            if (_answerWherePush == WYAAnswerCardPushForCourseController) {
                                vc.reportPushType = WYAReportPushForCourseController;
                            }if (_answerWherePush == WYAAnswerCardPushForPaperContorller) {
                                vc.reportPushType = WYAReportPushForPaperContorller;
                            }
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
                    }];
}
@end
