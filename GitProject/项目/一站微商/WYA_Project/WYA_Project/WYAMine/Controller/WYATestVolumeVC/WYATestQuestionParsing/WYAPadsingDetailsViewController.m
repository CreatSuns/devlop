//
//  WYAPadsingDetailsViewController.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/20.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//错误全部解析

#import "WYAPadsingDetailsViewController.h"
#import "WYATestBottomView.h" //底部进度条
#import "WYAPadsingDetailsCell.h"
#import "WYATestVolumeNetRequest.h"
#import "WYACardParsingListModel.h"
#import "WYAPadsingCardViewController.h"// 错题分析里的答题卡
// 答题报告界面
#import "WYAReportViewController.h"

#import "WYATestCaseHeaderView.h"//案例分析的头部

#import "WYATestVolimeBottomView.h"//错题解析的底部


#define PadsingDetailsCell @"PadsingDetailsCell"

@interface WYAPadsingDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,WYATestBottomViewDelegate>
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
@property(nonatomic, strong) WYATestVolimeBottomView * tableBottomView;//错题分析的底部视图

@end

@implementation WYAPadsingDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _answerArray = [NSMutableArray array];
    _currentPage = 1;
    [self addCustomNavLeftButton];
    self.title = self.navTitle;
    _dataSources = [NSMutableArray array];
    if ([self.navTitle isEqualToString:@"错题解析"]) {
        [self requestErrorQuestionList];
    }else if([self.navTitle isEqualToString:@"全部解析"])
    {
        [self requestAllQuestionList];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.testVolumeTableView];
    [self addBottomView];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ====== rightSubmitEvent

- (void)goBack:(UIButton *)sender{
    [super goBack:sender];
     // 返回到答题详细报告界面
}
#pragma mark ====== netRequest
- (WYATestVolumeNetRequest *)netRequest
{
    if (_netRequest == nil) {
        _netRequest = [[WYATestVolumeNetRequest alloc]init];
    }
    return _netRequest;
}
- (void)requestAllQuestionList
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"paper_id"] = self.paper_id;
    dic[@"question_number"] = [NSString stringWithFormat:@"%d",_currentPage];
    dic[@"exam_time"] = self.examTime;
    [self.netRequest testQuestionAllAnalysisWithParams:dic Success:^(id data) {
        [self.dataSources removeAllObjects];
        [self.dataSources addObject:data];
        WYACardParsingListModel * model = data;
        if (![model.caseTopic isEqualToString:@"【案例分析题】暂无数据"]){
            [self addCaseHeaderViewWith:model.caseTopic];
        }else
        {
            self.testVolumeTableView.tableHeaderView = nil;
        }
        [self addtableBottomViewWith:model];
        [self.testVolumeTableView reloadData];
        self.bottomView.pageNum = @[model.questionNum,model.count];
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
- (void)requestErrorQuestionList
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"paper_id"] = self.paper_id;
    dic[@"question_number"] = [NSString stringWithFormat:@"%d",_currentPage];
    dic[@"exam_time"] = self.examTime;
    [self.netRequest testQuestionErrorAnalysisWithParams:dic Success:^(id data) {
        [self.dataSources removeAllObjects];
        [self.dataSources addObject:data];
        WYACardParsingListModel * model = data;
        if (![model.caseTopic isEqualToString:@"【案例分析题】暂无数据"]){
            [self addCaseHeaderViewWith:model.caseTopic];
        }else
        {
            self.testVolumeTableView.tableHeaderView = nil;
        }
        [self addtableBottomViewWith:model];
        [self.testVolumeTableView reloadData];
        self.bottomView.pageNum = @[[NSString stringWithFormat:@"%d",_currentPage],model.count];
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
#pragma mark ====== creatView
- (void)addtableBottomViewWith:(WYACardParsingListModel *)model
{
   
        CGFloat height = [WYAJHTools heightOfConttent:model.analysis fontSize:13*Size_ratio maxWidth:ScreenWidth-16*Size_ratio];
        _tableBottomView = [[WYATestVolimeBottomView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, height + 100*Size_ratio)];
    _tableBottomView.model = model;
    self.testVolumeTableView.tableFooterView = _tableBottomView;

}
- (void)addCaseHeaderViewWith:(NSString *)contString
{
#pragma mark ========= 根据返回的案例文字计算高度
    CGFloat height = [WYAJHTools heightOfConttent:contString fontSize:15.f*Size_ratio maxWidth:ScreenWidth-10*Size_ratio];
    _caseHeaderView = [[WYATestCaseHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, height)];
    _caseHeaderView.content = contString;
    self.testVolumeTableView.tableHeaderView = _caseHeaderView;
    
}
// 最底部进度
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
    _bottomView = [[WYATestBottomView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 49.f)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    _bottomView.delegate = self;
    [_myBottomView addSubview:_bottomView];
}
- (UITableView *)testVolumeTableView
{
    if (_testVolumeTableView == nil) {
        _testVolumeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49-69*Size_ratio) style:UITableViewStylePlain];
        _testVolumeTableView.delegate = self;
        _testVolumeTableView.dataSource = self;
        _testVolumeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
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
    return self.dataSources.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYAPadsingDetailsCell *  cell = [[WYAPadsingDetailsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PadsingDetailsCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.listModel = [self.dataSources lastObject];
        return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [WYAPadsingDetailsCell cellHeightWithModel:[self.dataSources lastObject]];
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    if(recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        WYACardParsingListModel * model = [self.dataSources lastObject];
        if (_currentPage < [model.count intValue]) {
            _currentPage++;
            // 更换tableView的数据刷新
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
            dict[[NSString stringWithFormat:@"%d",_currentPage]] = @"";
            [_answerArray addObject:dict];
            [self.dataSources removeAllObjects];
            if ([self.navTitle isEqualToString:@"错题解析"]) {
                [self requestErrorQuestionList];
            }else if([self.navTitle isEqualToString:@"全部解析"])
            {
                [self requestAllQuestionList];
            }

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
            if ([self.navTitle isEqualToString:@"错题解析"]) {
                [self requestErrorQuestionList];
            }else if([self.navTitle isEqualToString:@"全部解析"])
            {
                [self requestAllQuestionList];
            }
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
    WYAPadsingCardViewController * vc = [[WYAPadsingCardViewController alloc]init];
    vc.paper_id = self.paper_id;
    vc.examTime = self.examTime;
    vc.itemNum = self.itemNum;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
