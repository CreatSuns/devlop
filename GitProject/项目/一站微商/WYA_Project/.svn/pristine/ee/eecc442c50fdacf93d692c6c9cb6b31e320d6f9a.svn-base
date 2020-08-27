//
//  WYAReportViewController.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/19.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//答题报告

#import "WYAReportViewController.h"
#import "WYAPadsingCardViewController.h"
#import "WYAJHPieModel.h"
#import "WYAJHPieChart.h"
#import "WYACardReportContentView.h"
#import "UIView+WYALayout.h"
#import "WYATestVolumeViewController.h"
#import "WYATestPaperVC.h"
#import "WYATestVolumeNetRequest.h"
#import "WYACardParsingModel.h"
#import "WYACourseDetailVC.h"

@interface WYAReportViewController ()
@property(nonatomic, strong) WYATestVolumeNetRequest * netRequest;
@property(nonatomic, strong) WYAJHPieChart * cardReportView;
@property(nonatomic, strong) WYACardReportContentView * cardReportContentView;
@property(nonatomic, strong) UIButton * againTestBtn;
@property(nonatomic, strong) UISegmentedControl * segmentControll;
@property(nonatomic, strong) NSMutableArray * cardDataArray;
@end

@implementation WYAReportViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestCardReportInfo];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    _cardDataArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addNavRightButtonWithImageNamed:@"答题报告"];
    [self addCustomNavLeftButton];
    self.title = @"答题报告";
    [self.view addSubview:self.cardReportView];
    [self.view addSubview:self.cardReportContentView];
// 添加滑动手势
   UISwipeGestureRecognizer * recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:recognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)goBack:(UIButton *)sender
{
    if (_reportPushType == WYAReportPushForPaperContorller) {
        for (UIViewController * vc  in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[WYATestPaperVC class]]) {
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
    }else if (_reportPushType == WYAReportPushForCourseController){
        for (UIViewController * vc  in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[WYACourseDetailVC class]]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:TESTCOMPLETED object:nil];
                [self.navigationController popToViewController:vc animated:YES];
            }
            
        }
    }
  
}
#pragma mark ====== netRequest
- (WYATestVolumeNetRequest *)netRequest
{
    if (_netRequest == nil) {
        _netRequest = [[WYATestVolumeNetRequest alloc]init];
    }
    return _netRequest;
}
- (void)requestCardReportInfo
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"paper_id"] = self.paper_id;
    dic[@"status"] = @"1";
    [self.netRequest testQuestionReportWithParams:dic Success:^(id data) {
        self.cardDataArray = data;
        if (self.cardDataArray&&self.cardDataArray.count!=0) {
    
        WYACardParsingModel * model = self.cardDataArray[0];
        // 选择器的选项确定
        if ([model.itemsNum intValue] > 1) {
            NSArray * itemArray = [model.itemsNum intValue] > 2? @[@"第一次",@"第二次",@"第三次"]:@[@"第一次",@"第二次"];
            [self addSegmentControllWith:itemArray];
        }
        // 是否显示测试按钮
        if ([model.itemsNum intValue] < 3||self.isShowTestBtn) {
        [self.view addSubview:self.againTestBtn];
        }
        [self refreshUIWithModel:model];
        }
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
#pragma mark ====== event
- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    if(recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"swipe left");
        if (self.segmentControll.selectedSegmentIndex < self.cardDataArray.count-1) {
            WYACardParsingModel * model = self.cardDataArray[self.segmentControll.selectedSegmentIndex];
            
            WYAPadsingCardViewController * vc = [[WYAPadsingCardViewController alloc]init];
            vc.paper_id = self.paper_id;
            vc.itemNum = model.itemsNum;
            vc.passScore = model.pass_point;
            vc.myScore = model.score;
            vc.examTime = [NSString stringWithFormat:@"%ld",self.segmentControll.selectedSegmentIndex+1];
            if (model.pass_point && ![model.pass_point isEqualToString:@"暂无数据"]&&![model.pass_point isEqualToString:@"0"]) {
                if ([model.score integerValue] >= [model.pass_point integerValue]||[model.itemsNum integerValue]==3) {
                    vc.isShowBottomItem = @"1";
                }else
                {
                    vc.isShowBottomItem = @"0";
                }
            }else
            {
                vc.isShowBottomItem = @"1";
            }
            if ([model.score integerValue] != 100) {
                vc.isLookErrorQuestion = YES;
            }
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (void)rightBarButtonItemClicked:(UIButton *)sender
{
    WYACardParsingModel * model = self.cardDataArray[self.segmentControll.selectedSegmentIndex];

    WYAPadsingCardViewController * vc = [[WYAPadsingCardViewController alloc]init];
    vc.paper_id = self.paper_id;
    vc.itemNum = model.itemsNum;
    vc.passScore = model.pass_point;
    vc.myScore = model.score;
    vc.examTime = [NSString stringWithFormat:@"%ld",self.segmentControll.selectedSegmentIndex+1];
    if (model.pass_point && ![model.pass_point isEqualToString:@"暂无数据"]&&![model.pass_point isEqualToString:@"0"]) {
        if ([model.score integerValue] >= [model.pass_point integerValue]||[model.itemsNum integerValue]==3) {
            vc.isShowBottomItem = @"1";
        }else
        {
            vc.isShowBottomItem = @"0";
        }
    }else
    {
         vc.isShowBottomItem = @"1";
    }
    if ([model.score integerValue] != 100) {
        vc.isLookErrorQuestion = YES;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)change:(UISegmentedControl *)sender{
    WYACardParsingModel * model ;
    if (sender.selectedSegmentIndex == 0) {
        model = self.cardDataArray[sender.selectedSegmentIndex];
    }else if (sender.selectedSegmentIndex == 1){
        
        model = self.cardDataArray[sender.selectedSegmentIndex];

    }else if (sender.selectedSegmentIndex == 2){
        model = self.cardDataArray[sender.selectedSegmentIndex];

    }
    [self refreshUIWithModel:model];
}

- (void)aginTestBtnClicked:(UIButton *)sender
{
    // 进入测试题界面
    WYATestVolumeViewController * vc = [[WYATestVolumeViewController alloc]init];
    if (self.reportPushType == WYAReportPushForPaperContorller) {
        vc.pushFromWhere = WYATestPushForReportVc;
    }else
    {
        vc.pushFromWhere = WYATestPushForCourseController;
    }
    vc.paper_id = self.paper_id;
    JQFMDB * db = [JQFMDB shareDatabase];
    [db jq_deleteAllDataFromTable:ANSWE_DataBase];
    [self.navigationController pushViewController:vc animated:YES];
    // 获取进入时间
    NSString * currentSceonds = [WYAJHTools getNowTimeTimestampForSeconds];
    [[NSUserDefaults standardUserDefaults] setObject:currentSceonds forKey:@"beginTime"];
}
#pragma mark ====== creat UI
- (UIButton *)againTestBtn
{
    if (_againTestBtn == nil) {
        _againTestBtn = [[UIButton alloc]initWithFrame:CGRectMake(0.5*(ScreenWidth-100*Size_ratio), self.cardReportView.cmam_bottom + 50*Size_ratio , 100*Size_ratio, 31*Size_ratio)];
        [_againTestBtn setTitle:@"重新测试" forState:UIControlStateNormal];
        [_againTestBtn setTitleColor:[UIColor WYAJHBasePurpleColor] forState:UIControlStateNormal];
        [_againTestBtn setTitleColor:[UIColor WYAJHgrayTextColor] forState:UIControlStateHighlighted];
        _againTestBtn.layer.cornerRadius = 8*Size_ratio;
        _againTestBtn.layer.borderColor = [UIColor WYAJHBasePurpleColor].CGColor;
        _againTestBtn.layer.borderWidth = 0.5;
        _againTestBtn.layer.masksToBounds = YES;
        _againTestBtn.titleLabel.font = [UIFont systemFontOfSize:15*Size_ratio];
        [_againTestBtn addTarget:self action:@selector(aginTestBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _againTestBtn;
}

- (void)addSegmentControllWith:(NSArray *)items
{
    _segmentControll = [[UISegmentedControl alloc]initWithItems:items];
    _segmentControll.frame = CGRectMake(35*Size_ratio, 20*Size_ratio, ScreenWidth-70*Size_ratio,44*Size_ratio);
    _segmentControll.selectedSegmentIndex = 0;
    _segmentControll.backgroundColor = [UIColor whiteColor];
    _segmentControll.layer.masksToBounds = YES;
    _segmentControll.layer.cornerRadius = 8*Size_ratio;
    _segmentControll.layer.borderWidth = 0.5*Size_ratio;                 
    _segmentControll.layer.borderColor = [UIColor WYAJHBasePurpleColor].CGColor;
    _segmentControll.tintColor = [UIColor WYAJHBasePurpleColor];
    [self.view addSubview:_segmentControll];
    //添加事件
    [_segmentControll addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
}

- (WYACardReportContentView *)cardReportContentView
{
    if (_cardReportContentView == nil) {
        _cardReportContentView = [[WYACardReportContentView alloc]initWithFrame:CGRectMake(0, 80*Size_ratio, ScreenWidth, 85*Size_ratio)];
        _cardReportContentView.backgroundColor = [UIColor whiteColor];
    }
    return _cardReportContentView;
}

- (WYAJHPieChart *)cardReportView
{
    if (_cardReportView == nil) {
        _cardReportView = [[WYAJHPieChart alloc]initWithFrame:CGRectMake(0, 0.5*(ScreenHeight-WYATopHeight- 49-300*Size_ratio), ScreenWidth, 300*Size_ratio)];
    }
    return _cardReportView;
}

#pragma mark ====== 刷新UI
- (void)refreshUIWithModel:(WYACardParsingModel *)model{
    // 圆形百分比绘制
    WYAJHPieModel *model1 = [[WYAJHPieModel alloc] init];
    CGFloat score = [model.score floatValue];
    CGFloat rate = (100-score)/100;
    model1.rate = rate;
    model1.name = @"错误";
    model1.value = 423651.23;
    
    WYAJHPieModel *model2 = [[WYAJHPieModel alloc] init];
    model2.rate = score/100;
    model2.name = @"正确";
    model2.value = 423651.23;
    NSArray * dataArray = @[model1, model2];
    self.cardReportView.dataArray = dataArray;
    [self.cardReportView draw];
    self.cardReportContentView.scoreStr = [NSString stringWithFormat:@"%@分",model.score];
    self.cardReportContentView.useTimeStr =[NSString stringWithFormat:@"用时:%@",model.use_time];
}
@end
