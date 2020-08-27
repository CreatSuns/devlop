//
//  WYATestVolumeViewController.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/13.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYATestVolumeViewController.h"
#import "WYATestBottomView.h"
#import "WYATestSingleSelectedTableViewCell.h"
#import "WYATestDoubleSelectedTableViewCell.h"
#import "WYATestVolumeNetRequest.h"
#import "WYATestQuestionListModel.h"
#import "WYAAnswerCardViewController.h"
#import "WYAJHAnswerModel.h"
#import "WYATestPaperVC.h"
#import "WYAReportViewController.h"
#import "WYATestCaseHeaderView.h"
#import "WYACourseDetailVC.h"
#import "WYATestVolimeBottomView.h"


#define SINGSELECTED_CELLID @"SINGSELECTED_CELLID"

@interface WYATestVolumeViewController ()<UITableViewDelegate,UITableViewDataSource,WYATestBottomViewDelegate>
@property(nonatomic, strong) UITableView * testVolumeTableView;
@property(nonatomic, strong) NSMutableArray * dataSources;
@property(nonatomic, strong) NSMutableArray * allDataArray;
@property(nonatomic, strong) UIView * myBottomView;
@property(nonatomic, strong) WYATestBottomView * bottomView;
@property(nonatomic, strong) UISwipeGestureRecognizer * rightRecognizer;
@property(nonatomic, strong) UISwipeGestureRecognizer * leftRecognizer;
@property(nonatomic, strong) WYATestVolumeNetRequest * netRequest;
@property(nonatomic, strong) WYATestCaseHeaderView * caseHeaderView;
@property(nonatomic, strong) NSMutableArray * answerArray;// 全部答案
@property(nonatomic, assign) int currentPage;//当前页数
@property(nonatomic, copy) NSString * endAnswer;
@end

@implementation WYATestVolumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    _answerArray = [NSMutableArray array];
    if (_pushFromWhere == WYATestPushForAnswerCardController) {
        _currentPage = [self.question_number intValue];
    }else if(_pushFromWhere == WYATestPushForReportVc||_pushFromWhere == WYATestPushForCourseController||_pushFromWhere == WYATestPushForPaperContorller){
    _currentPage = 1;
    }
    [self addNavRightButtonWithTitle:@"交卷" TitleColor:nil];
    [self addCustomNavLeftButton];
    _dataSources = [NSMutableArray array];
    [self requestTestQuestionList];
    self.title = @"课程测试";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.testVolumeTableView];
    [self addBottomView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ====== rightSubmitEvent
- (void)rightBarButtonItemClicked:(UIButton *)sender
{
    [super rightBarButtonItemClicked:sender];
    [_answerArray removeAllObjects];
    JQFMDB * db = [JQFMDB shareDatabase];
    WYATestQuestionListModel * model = [self.dataSources firstObject];
    for (int i = 0; i<[model.count intValue]; i++) {
        // 查询条件
        NSString * searchString = [NSString stringWithFormat:@"where question_number = '%d'",i+1];
        //查询结果
        NSArray * answerArr = [db jq_lookupTable:ANSWE_DataBase dicOrModel:[WYAJHAnswerModel class] whereFormat:searchString];
        // 判断这个数组是否存在，查到说明这个题目选择过没查到就是没有
        if (answerArr.count==0) {
            // 加入一个空数据
            NSDictionary * dic = [NSDictionary dictionaryWithObject:@"" forKey:[NSString stringWithFormat:@"%d",i+1]];
            [_answerArray addObject:dic];
        }else{
            WYAJHAnswerModel * model = answerArr[0];
            if (model.answerString != nil) {
                NSDictionary * dic = [NSDictionary dictionaryWithObject:model.answerString forKey:[NSString stringWithFormat:@"%d",i+1]];
                [_answerArray addObject:dic];
            }
        }
    }
    #pragma mark ==== 是否确定交卷
    NSString * answerString = @"";
    for (int i = 0 ;i<_answerArray.count;i++) {
        if (i<_answerArray.count) {
            NSDictionary * dict = _answerArray[i];
            NSString * key = [[dict allKeys] firstObject];
            NSString * value = [[dict allValues] firstObject];
            answerString = [answerString stringByAppendingFormat:@"{\"%@\":\"%@\"},",key,value];
        }else
        {
            NSDictionary * dict = _answerArray[i];
            NSString * key = [[dict allKeys] firstObject];
            NSString * value = [[dict allValues] firstObject];
            answerString = [answerString stringByAppendingFormat:@"{\"%@\":\"%@\"}",key,value];
            
        }
    }
    NSString * cutAnswerString = [answerString substringToIndex:[answerString length] - 1];
    _endAnswer = [NSString stringWithFormat:@"[%@]",cutAnswerString];
//    NSLog(@"测试题答案%@",_endAnswer);
    [self showAlertControllerWithLeftTitle:@"再查一下" topTitle:@"要不要检查一遍再交卷？" rightTitle:@"确认提交"];

}

- (void)goBack:(UIButton *)sender{
#pragma mark ===== 试卷未提交是否继续返回，如果返回该次考试不做记录
    [self showAlertControllerWithLeftTitle:@"暂不返回" topTitle:@"试卷未提交是否继续返回，如果返回该次考试不做记录" rightTitle:@"继续返回"];
}
#pragma mark ====== netRequest
- (WYATestVolumeNetRequest *)netRequest
{
    if (_netRequest == nil) {
        _netRequest = [[WYATestVolumeNetRequest alloc]init];
    }
    return _netRequest;
}

- (void)requestTestQuestionList
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"paper_id"] = self.paper_id;
    dic[@"question_number"] = [NSString stringWithFormat:@"%d",_currentPage];
    [self.netRequest testQuestionListDataWithParams:dic Success:^(id data) {
        [self.dataSources removeAllObjects];
        [self.dataSources addObject:data];
        WYATestQuestionListModel * model = self.dataSources[0];
        if (![model.case_topic isEqualToString:@"【案例分析题】暂无数据"]){
            [self addCaseHeaderViewWith:model.case_topic];
        }else
        {
            self.testVolumeTableView.tableHeaderView = nil;
        }
        [self.testVolumeTableView reloadData];
        self.bottomView.pageNum = @[model.question_number,model.count];
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
#pragma mark ====== creatView

- (void)addCaseHeaderViewWith:(NSString *)contString
{
    #pragma mark ========= 根据返回的案例文字计算高度
    CGFloat height = [WYAJHTools heightOfConttent:contString fontSize:15.f*Size_ratio maxWidth:ScreenWidth-10*Size_ratio];
    _caseHeaderView = [[WYATestCaseHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, height)];
    _caseHeaderView.content = contString;
    self.testVolumeTableView.tableHeaderView = self.caseHeaderView;
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
    _bottomView = [[WYATestBottomView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WYATabBarHeight)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    _bottomView.delegate = self;
    [_myBottomView addSubview:_bottomView];
}
- (UITableView *)testVolumeTableView
{
    if (_testVolumeTableView == nil) {
        _testVolumeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-WYATabBarHeight-69*Size_ratio) style:UITableViewStylePlain];
        _testVolumeTableView.delegate = self;
        _testVolumeTableView.dataSource = self;
        _testVolumeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
//        _testVolumeTableView.tableFooterView = self.tableBottomView;
        
        _rightRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
        _leftRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
        [_rightRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [_leftRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
        [_testVolumeTableView addGestureRecognizer:_rightRecognizer];
        [_testVolumeTableView addGestureRecognizer:_leftRecognizer];
    }
    return _testVolumeTableView;
}

#pragma mark ====== UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WYATestQuestionListModel * model = [self.dataSources firstObject];
    if ([model.type rangeOfString:@"多选"].location == NSNotFound) {
        WYATestSingleSelectedTableViewCell *  cell = [[WYATestSingleSelectedTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SINGSELECTED_CELLID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isTouchUpInsde = WYATestTestSelected;
        cell.listModel = [self.dataSources lastObject];
        cell.paperId = self.paper_id;
        //        cell.delegate = self;
        return cell;
    } else {
        WYATestDoubleSelectedTableViewCell *  cell = [[WYATestDoubleSelectedTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SINGSELECTED_CELLID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isDoubleTouchUpInsde = WYATestTestDoubleSelected;
        cell.listModel = [self.dataSources lastObject];
        //        cell.delegate = self;
        cell.paperId = self.paper_id;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [WYATestSingleSelectedTableViewCell cellHeightWithModel:[self.dataSources lastObject]];
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    if(recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        WYATestQuestionListModel * model = [self.dataSources lastObject];
        if (_currentPage < [model.count intValue]) {
            _currentPage++;
            // 更换tableView的数据刷新
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
            dict[[NSString stringWithFormat:@"%d",_currentPage]] = @"";
            [_answerArray addObject:dict];
            [self.dataSources removeAllObjects];
            [self requestTestQuestionList];
            NSString *subtypeString;
            subtypeString = kCATransitionFromBottom;
            [self transitionWithType:@"pageCurl" WithSubtype:subtypeString ForView:self.testVolumeTableView];
        }
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        
        if(_currentPage > 0&&_currentPage!=1){
            _currentPage--;
            // 更换tableView的数据刷新 
            [self.dataSources removeAllObjects];
            [self requestTestQuestionList];
            NSString *subtypeString;
            subtypeString = kCATransitionFromLeft;
            [self transitionWithType:@"pageCurl" WithSubtype:subtypeString ForView:self.view];
        }
    }
}

- (void)transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view {
    CATransition *animation = [CATransition animation];
    animation.duration = 0.7f;
    animation.type = type;
    if (subtype != nil) {
        animation.subtype = subtype;
    }
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [view.layer addAnimation:animation forKey:@"animation"];
    [self.testVolumeTableView reloadData];
}

#pragma mark ====== WYATestBottomViewDelegate
- (void)testQuestionCardButtonClicked:(UIButton *)sender
{
    WYAAnswerCardViewController * vc = [[WYAAnswerCardViewController alloc]init];
    vc.paper_id = self.paper_id;
     WYATestQuestionListModel * model = [self.dataSources firstObject];
    vc.answerCount = model.count;
    if (self.pushFromWhere ==WYATestPushForCourseController ) {
        vc.answerWherePush = WYAAnswerCardPushForCourseController;
    }else
    {
        vc.answerWherePush = WYAAnswerCardPushForPaperContorller;
    }
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ====== 弹框
- (void)showAlertControllerWithLeftTitle:(NSString *)leftTitle topTitle:(NSString *)topTitle rightTitle:(NSString *)rightTitle
{
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
    if ([title isEqualToString:@"确认提交"]) {
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
                NSLog(@"测试题提交交卷%@",data);
                if ([data[@"status"] intValue] == 1) {
                    JQFMDB * fmdb = [JQFMDB shareDatabase];
                    [fmdb jq_deleteTable:ANSWE_DataBase];
                    WYAReportViewController * vc = [[WYAReportViewController alloc]init];
                    vc.paper_id = self.paper_id;
                    vc.isShowTestBtn = YES;
                    if (_pushFromWhere == WYATestPushForCourseController) {
                        vc.reportPushType = WYAReportPushForCourseController;
                    }if (_pushFromWhere == WYATestPushForPaperContorller) {
                        vc.reportPushType = WYAReportPushForPaperContorller;
                    }
                    [self.navigationController pushViewController:vc animated:YES];
                }
              
            } Fail:^(NetRequestCode netCode, NSString *errorDes) {

            }];
        
    }else if ([title isEqualToString:@"继续返回"]){
        JQFMDB * fmdb = [JQFMDB shareDatabase];
        [fmdb jq_deleteTable:ANSWE_DataBase];
        if (_pushFromWhere == WYATestPushForReportVc||_pushFromWhere == WYATestPushForAnswerCardController||_pushFromWhere == WYATestPushForPaperContorller) {
            for (UIViewController * vc  in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[WYATestPaperVC class]]) {
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
        }else if (_pushFromWhere == WYATestPushForCourseController){
            for (UIViewController * vc  in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[WYACourseDetailVC class]]) {
                    [self.navigationController popToViewController:vc animated:YES];
                }
                
            }
        }
    }
}
@end
