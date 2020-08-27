//
//  WYAMineTableView.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/8.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMineTableView.h"
#import "WYAMineTableViewCell.h"
#import "WYAMineCellViewModel.h"

#define MINE_CELL_ID @"WYAMineTableViewCell"

@interface WYAMineTableView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) NSMutableArray * dataSources;
@end

@implementation WYAMineTableView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor WYAJHLightGreyColor];
        [self registerClass:[WYAMineTableViewCell class] forCellReuseIdentifier:MINE_CELL_ID];
        self.scrollEnabled = NO;
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSelectionStyleNone;
        self.tableFooterView = [[UIView alloc]init];
    }
    return self;
}

- (NSArray *)dataSources
{
    if (_dataSources == nil) {
        _dataSources = [NSMutableArray arrayWithArray: [WYAMineCellViewModel mineCellDataSourcesArray]];
    }
    return _dataSources;
}
#pragma mark ====== UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataSources objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSources.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYAMineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:MINE_CELL_ID];
    if (cell == nil) {
        cell = [[WYAMineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MINE_CELL_ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellModel = [self.dataSources[indexPath.section] objectAtIndex:indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 11*Size_ratio;
    }
    return 6.f*Size_ratio;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   WYAMineCellModel * model = [self.dataSources[indexPath.section] objectAtIndex:indexPath.row];
    NSInteger indexCell = 0;
    if ([model.titleText isEqualToString:@"我的收藏"]) {
        indexCell = 0;
    }
    if ([model.titleText isEqualToString:@"我的关注"]) {
        indexCell = 1;
    }
    if ([model.titleText isEqualToString:@"我的下载"]) {
        indexCell = 2;
    }
    if ([model.titleText isEqualToString:@"意见反馈"]) {
        indexCell = 3;
    }
    if ([model.titleText isEqualToString:@"设置"]) {
        indexCell = 4;
    }
    NSLog(@"%@",model.titleText);
    if (self.mineDelegate && [self.mineDelegate respondsToSelector:@selector(WYAMineTableViewDidSelectCell:)]) {
        [self.mineDelegate WYAMineTableViewDidSelectCell:indexCell];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 6.f)];
    view.backgroundColor = [UIColor WYAJHLightGreyColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f*Size_ratio;
}
@end
