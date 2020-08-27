//
//  WYALowerLeverTestScoresVC.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/18.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYALowerLeverTestScoresVC.h"
#import "WYATestScoresNetRequest.h"
#import "WYAMineTestScoresModel.h"
#import "WYAMyCouresTableNoDataView.h"
#import "WYALowLeverTestScoresCell.h"
#import "WYATestPaperVC.h"
static NSString * WYALowLeverTestScores = @"WYALowLeverTestScores";

@interface WYALowerLeverTestScoresVC ()

@property (nonatomic, strong) WYATestScoresNetRequest * netRequest;

@property (nonatomic, strong) NSMutableArray * dataSourse;

@property (nonatomic, strong) WYAMyCouresTableNoDataView * noDataView;

@end

@implementation WYALowerLeverTestScoresVC

-(WYATestScoresNetRequest *)netRequest{
    if (!_netRequest) {
        _netRequest = [[WYATestScoresNetRequest alloc]init];
    }
    return _netRequest;
}

- (NSMutableArray *)dataSourse{
    if (!_dataSourse) {
        _dataSourse = [NSMutableArray new];
    }
    return _dataSourse;
}

- (WYAMyCouresTableNoDataView *)noDataView{
    if (!_noDataView) {
        _noDataView = [[WYAMyCouresTableNoDataView alloc]init];
        _noDataView.errorMessageLabel.text = @"亲！还没有测试成绩哦~";
//        _noDataView.errorMessageLabel.text = @"";
        
    }
    return _noDataView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.tableView registerClass:[WYALowLeverTestScoresCell class] forCellReuseIdentifier:WYALowLeverTestScores];
    [self loadLowLevelTestScoresData];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadLowLevelTestScoresData{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * roleID = [userDefaults objectForKey:@"role_id"];
    if (![roleID isEqualToString:@"1"]) {
        [dic setObject:@"0" forKey:@"is_mine"];
    }
    
    [self.netRequest loadTestScoresWithParams:nil Success:^(id data) {
        WYAMineTestScoresModel * model = (WYAMineTestScoresModel *)data;
        self.dataSourse = [model.list mutableCopy];
        self.replacePlaceholdView = self.noDataView;
        
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourse.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WYALowLeverTestScoresCell * cell = [tableView dequeueReusableCellWithIdentifier:WYALowLeverTestScores forIndexPath:indexPath];
    cell.model = self.dataSourse[indexPath.row];
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 92.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WYAMineTestScoresListModel * model = (WYAMineTestScoresListModel *)self.dataSourse[indexPath.row];
    
    WYATestPaperVC * paper = [[WYATestPaperVC alloc]init];
    paper.level = secondary;
    paper.courseID = model.course_id;
    paper.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:paper animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
