//
//  WYAAttentionViewController.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/12.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAAttentionViewController.h"
#import "WYAAttentionTableViewCell.h"
#import "WYAAttentionNetRequest.h"
#import "WYALecturerDetailsNetRequest.h"
#import "WYALecturerPersonalVC.h"
#import "WYAAttentionModel.h"
#define ATTEN_CELL_ID @"ATTEN_CELL_ID"

@interface WYAAttentionViewController ()<UITableViewDelegate,UITableViewDataSource,WYAAttentionTableViewCellDelegate>
@property(nonatomic, strong) UITableView * attentionTableView;
@property(nonatomic, strong) NSMutableArray * dataSources;
@property(nonatomic, strong) WYAAttentionNetRequest * netRequest;
@property(nonatomic, strong) WYALecturerDetailsNetRequest * attentionNetRequest;

@end

@implementation WYAAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的关注";
    [self.view addSubview:self.attentionTableView];
//    [self responeData];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    [self refreshNewData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ====== creatUI
- (UITableView *)attentionTableView
{
    if(_attentionTableView == nil){
        _attentionTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight- 64)];
        [_attentionTableView registerClass:[WYAAttentionTableViewCell class] forCellReuseIdentifier:ATTEN_CELL_ID];
        _attentionTableView.showsVerticalScrollIndicator = NO;
        _attentionTableView.delegate = self;
        _attentionTableView.dataSource = self;
        _attentionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _attentionTableView.backgroundColor = [UIColor WYAJHLightGreyColor];

    }
    return _attentionTableView;
}
- (NSMutableArray *)dataSources
{
    if(_dataSources == nil)
    {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}
#pragma mark ======= netRequest
#pragma mark ====== netRequest
- (WYALecturerDetailsNetRequest *)attentionNetRequest
{
    if (_attentionNetRequest == nil) {
        _attentionNetRequest = [[WYALecturerDetailsNetRequest alloc]init];
    }
    return _attentionNetRequest;
}
- (void)responeData
{
    [self.netRequest mineAttentionWithParams:[NSMutableDictionary dictionary] Success:^(id data) {
        self.dataSources = data;
        [self.attentionTableView reloadData];
        [self.attentionTableView.mj_header endRefreshing];

    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        [self.attentionTableView.mj_header endRefreshing];

    }];
}
- (WYAAttentionNetRequest *)netRequest{
    if (_netRequest == nil) {
        _netRequest = [[WYAAttentionNetRequest alloc]init];
    }
    return _netRequest;
}
- (void)refreshNewData
{
    __weak typeof(self) weakSelf = self;
    self.attentionTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf responeData];
        
    }];
    [self.attentionTableView.mj_header beginRefreshing];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.attentionTableView.mj_header.automaticallyChangeAlpha = YES;
}

#pragma mark ====== UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSources count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYAAttentionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ATTEN_CELL_ID];
    if (cell == nil) {
        cell = [[WYAAttentionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ATTEN_CELL_ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataSources[indexPath.row];
    cell.delegate = self;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 81.f*Size_ratio;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WYAAttentionModel * model = self.dataSources[indexPath.row];
    WYALecturerPersonalVC * lecturerPersonalVC = [[WYALecturerPersonalVC alloc]init];
    lecturerPersonalVC.hidesBottomBarWhenPushed = YES;
    lecturerPersonalVC.teacher_id = model.teacher_id;
    lecturerPersonalVC.teacher_name = model.teacher_name;
    [self.navigationController pushViewController:lecturerPersonalVC animated:YES];
}
#pragma mark ====== WYAAttentionTableViewCellDelegate
- (void)attentionButtonClicked:(WYAAttentionTableViewCell *)tager
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    NSString * btnText= tager.attentionBtn.titleLabel.text;
    dic[@"teacher_id"] = tager.model.teacher_id;
    if ([btnText isEqualToString:@"已关注"]) {
        [self.netRequest cancleAttentionWithParams:dic Success:^(id data) {
                 [WYAShowMessageView showToastAWithMessage:@"取消关注成功"];
                [tager.attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
                tager.attentionBtn.backgroundColor = [UIColor whiteColor];
                [tager.attentionBtn setTitleColor:[UIColor WYAJHBasePurpleColor] forState:UIControlStateNormal];
                tager.attentionBtn.layer.borderColor = [UIColor WYAJHBasePurpleColor].CGColor;
                tager.attentionBtn.titleLabel.font = [UIFont systemFontOfSize:13.f*Size_ratio];
                tager.attentionBtn.layer.borderWidth = 0.5;
                tager.attentionBtn.layer.cornerRadius = 10.f*Size_ratio;
                tager.attentionBtn.layer.masksToBounds = YES;
        } Fail:^(NetRequestCode netCode, NSString *errorDes) {
            
        }];
    }else{
        [self.attentionNetRequest lecturerAttentionWithParams:dic Success:^(id data) {
             [WYAShowMessageView showToastAWithMessage:@"关注成功"];
            [tager.attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
            tager.attentionBtn.backgroundColor = [UIColor WYAJHBasePurpleColor];
            [tager.attentionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            tager.attentionBtn.layer.borderColor = [UIColor clearColor].CGColor;
            tager.attentionBtn.titleLabel.font = [UIFont systemFontOfSize:13.f*Size_ratio];
            tager.attentionBtn.layer.borderWidth = 0.f;
            tager.attentionBtn.layer.cornerRadius = 10.f*Size_ratio;
            tager.attentionBtn.layer.masksToBounds = YES;
        } Fail:^(NetRequestCode netCode, NSString *errorDes) {
            
        }];
    }
    
}

@end
