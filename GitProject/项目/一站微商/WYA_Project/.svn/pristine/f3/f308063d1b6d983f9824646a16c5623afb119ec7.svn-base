//
//  WYASearchAllViewController.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/25.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYASearchAllViewController.h"
#import "WYAArticleTableViewCell.h"
#import "WYALecturerTableViewCell.h"
#import "WYACouresListCell.h"
#import "WYAArticleDetailsVC.h"
#import "WYAArticleListModel.h"
#import "WYALecturerModel.h"
#import "WYALecturerPersonalVC.h"
#import "WYASearchCourseModel.h"
#import "WYACourseDetailVC.h"
#import "WYACouresListModel.h"

#define Article_CELL @"ArticleTableViewCell"
#define Lecturer_Cell @"LecturerTableViewCell"
#define Course_CELL @"courseTableViewCell"
@interface WYASearchAllViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView * searchAllTableView;
@end

@implementation WYASearchAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.searchAllTableView];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ====== createUI
- (UITableView *)searchAllTableView
{
    if (_searchAllTableView == nil) {
        _searchAllTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-WYANavBarHeight-WYAStatusBarHeight-WYATabBarHeight) style:UITableViewStylePlain];
        [_searchAllTableView registerClass:[WYAArticleTableViewCell class] forCellReuseIdentifier:Article_CELL];
        [_searchAllTableView registerClass:[WYALecturerTableViewCell class] forCellReuseIdentifier:Lecturer_Cell];
        [_searchAllTableView registerClass:[WYACouresListCell class] forCellReuseIdentifier:Course_CELL];
        _searchAllTableView.dataSource = self;
        _searchAllTableView.delegate = self;
       _searchAllTableView.showsVerticalScrollIndicator = NO;
    }
    return _searchAllTableView;
}
#pragma mark tableDelegate
#pragma mark ====== UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.allDataSources.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * sectionArray = self.allDataSources[section];
    if(sectionArray.count == 0){
        return 1;
    }
    return sectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray * sectionArray = self.allDataSources[indexPath.section];
    if (sectionArray.count == 0) {
        static NSString * empty = @"emptyCellId";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:empty];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:empty];
        }
        UIImageView * emptyImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 185*Size_ratio)];
        emptyImage.image = [UIImage imageNamed:@"notSearch"];
        [cell addSubview:emptyImage];
        return cell;
    }else{
    switch (indexPath.section) {
        case 0:
            {
                WYACouresListCell * cell = [tableView dequeueReusableCellWithIdentifier:Course_CELL];
                if (cell == nil) {
                    cell = [[WYACouresListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Course_CELL];
                }
                cell.model = sectionArray[indexPath.row];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            break;
        case 1:
        {
            WYAArticleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Article_CELL];
            if (cell == nil) {
                cell = [[WYAArticleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Article_CELL];
            }
            cell.cellModel = sectionArray[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }
            break;
        case 2:
        {
            WYALecturerTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Lecturer_Cell];
            if (cell == nil) {
                cell = [[WYALecturerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Lecturer_Cell];
            }
            cell.cellModel = sectionArray[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }
            break;
        default:
            break;
    }
    }
    return nil;
}
// 分组头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 35*Size_ratio)];
    label.backgroundColor = [UIColor WYAJHLightGreyColor];
    label.textColor = [UIColor WYAJHBlackTextColor];
    label.font = [UIFont systemFontOfSize:14*Size_ratio];
    NSString * textString;
    switch (section) {
        case 0:
            textString = @" 课程";
            break;
        case 1:
            textString = @" 文章";
            break;
        case 2:
            textString = @" 讲师";
            break;
        default:
            break;
    }
    label.text = textString;
    return label;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35*Size_ratio;
}
// 分组脚视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSString * textString;
    switch (section) {
        case 0:
            textString = @"查看更多课程 >>";
            break;
        case 1:
            textString = @"查看更多文章 >>";
            break;
        case 2:
            textString = @"查看更多讲师 >>";
            break;
        default:
            break;
    }
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 35*Size_ratio)];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:textString forState:UIControlStateNormal];
    [button setTitleColor:[UIColor WYAJHBaseBlueColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor WYAJHLightGreyColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:15*Size_ratio];
    [button addTarget:self action:@selector(lookMoreBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(15*Size_ratio, 0, ScreenWidth-30*Size_ratio, 1)];
    lineView.backgroundColor = [UIColor WYAJHLightGreyColor];
    [button addSubview:lineView];
    return button;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSArray * sectionArray = self.allDataSources[section];
    return sectionArray.count >= 3 ? 35*Size_ratio:0.f;
}
// cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * sectionArray = self.allDataSources[indexPath.section];
    if (sectionArray.count == 0) {
        return 185*Size_ratio;
    }else{
    switch (indexPath.section) {
        case 0:
            return indexPath.row >2?0: 107*Size_ratio;
            break;
        case 1:{
            return indexPath.row >2?0:93*Size_ratio;
        }
            break;
        case 2:
            return indexPath.row >2?0:117*Size_ratio;
            break;
        default:
            break;
    }
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    cell点击事件
    NSArray * sectionArray = self.allDataSources[indexPath.section];
    if (sectionArray.count != 0) {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section = indexPath.section;
  NSArray * sectionArray = self.allDataSources[indexPath.section];
    switch (section) {
        case 0:
            {
                // 课程
                WYASearchCourseModel * model = sectionArray[indexPath.row];
                WYACourseDetailVC * courseDetailVc = [[WYACourseDetailVC alloc]init];
                courseDetailVc.courseID = model.course_id;
                courseDetailVc.course_title = model.course_title;
                courseDetailVc.course_id = model.course_id;
                courseDetailVc.img_url = model.img_url;
                [self.navigationController pushViewController:courseDetailVc animated:YES];
                
            }
            break;
        case 1:
        {
            // 文章
            WYAArticleListModel * model = sectionArray[indexPath.row];
            WYAArticleDetailsVC * articleVc = [[WYAArticleDetailsVC alloc]init];
            articleVc.article_id = model.article_id;
            [self.navigationController pushViewController:articleVc animated:YES];
        }
            break;
            
        case 2:
        {
            // 讲师
            WYALecturerModel * model = sectionArray[indexPath.row];
            WYALecturerPersonalVC * personalVc = [[WYALecturerPersonalVC alloc]init];
            personalVc.teacher_name = model.teacher_name;
            personalVc.teacher_id = model.teacher_id;

            [self.navigationController pushViewController:personalVc animated:YES];

        }
            break;
        default:
            break;
    }
        
    }
}
#pragma mark ====== event
- (void)lookMoreBtnClicked:(UIButton *)sender
{
    // 查看更多按钮点击
  
    NSString * titleText = sender.titleLabel.text;
    NSString * index ;
    if ([titleText isEqualToString:@"查看更多课程 >>"]) {
        index = @"1";
    }else if ([titleText isEqualToString:@"查看更多文章 >>"]){
        index = @"2";
    }else if ([titleText isEqualToString:@"查看更多讲师 >>"]){
        index = @"3";
    }
      [[NSNotificationCenter defaultCenter] postNotificationName:@"SearchSelectedIndex" object:self userInfo:[NSDictionary dictionaryWithObject:index forKey:@"selectedIndex"]];
}
@end
