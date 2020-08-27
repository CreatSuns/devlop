//
//  WYANewCourseVC.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/10.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYANewCourseVC.h"
#import "WYANewCourseNetRequest.h"
#import "WYANewCourseModel.h"
#import "WYANewCourseCell.h"
#import "WYACourseDetailVC.h"
static NSString * Cell = @"WYANewCourseCell";

@interface WYANewCourseVC ()

@property (nonatomic, strong) WYANewCourseNetRequest * netRequest;

@property (nonatomic, strong) NSArray * thisMonthNewCourses;

@property (nonatomic, strong) NSArray * lastMonthNewCourses;

@end

@implementation WYANewCourseVC

-(WYANewCourseNetRequest *)netRequest{
    if (!_netRequest) {
        _netRequest = [[WYANewCourseNetRequest alloc]init];
    }
    return _netRequest;
}

-(NSArray *)thisMonthNewCourses{
    if (!_thisMonthNewCourses) {
        _thisMonthNewCourses = [NSArray new];
    }
    return _thisMonthNewCourses;
}

-(NSArray *)lastMonthNewCourses{
    if (!_lastMonthNewCourses) {
        _lastMonthNewCourses = [NSArray new];
    }
    return _lastMonthNewCourses;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor WYAJHLightGreyColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"新课上架";
    
    [self.tableView registerClass:[WYANewCourseCell class] forCellReuseIdentifier:Cell];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadData];
    
//    self.tableView.backgroundColor = [UIColor WYAJHLightGreyColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)loadData{
    [self.netRequest loadNewCourseWithParams:nil Success:^(id data) {
        WYANewCourseModel * model = (WYANewCourseModel *)data;
        self.thisMonthNewCourses = model.list.this_month;
        self.lastMonthNewCourses = model.list.last_month;
        [self.tableView cyl_reloadData];
        
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
        [self.tableView cyl_reloadData];
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.thisMonthNewCourses.count;
    }else{
        return self.lastMonthNewCourses.count;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WYANewCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell forIndexPath:indexPath];
    
    // Configure the cell...
    if (indexPath.section == 0) {
        cell.thisModel = self.thisMonthNewCourses[indexPath.row];
    }else{
        cell.lastModel = self.lastMonthNewCourses[indexPath.row];
    }
    return cell;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSUInteger thisMonth = [NSDate month:[NSDate date]];
    NSString * thisMonthString = [NSString upperCaseNumber:thisMonth];
    NSString * lastMonthString;
    if (thisMonth == 1) {
        lastMonthString = @"十二";
    }else{
        lastMonthString = [NSString upperCaseNumber:thisMonth-1];
    }
    
    UIView * view = [[UIView alloc]init];
    
    view.backgroundColor = [UIColor WYAJHLightGreyColor];
    
    UILabel * label = [[UILabel alloc]init];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:13*Size_ratio];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor WYAJHDarkgGreyColor];
    label.layer.cornerRadius = 12.5*Size_ratio;
    label.layer.masksToBounds = YES;
    
    if (section == 0) {
        if (self.thisMonthNewCourses.count>0) {
            view.frame = CGRectMake(0, 0, tableView.width, 45.f*Size_ratio);
            label.text = [NSString stringWithFormat:@"%@月新上架",thisMonthString];
            label.frame = CGRectMake((ScreenWidth-94*Size_ratio)/2, 10.f*Size_ratio, 94.f*Size_ratio, 25.f*Size_ratio);
            [view addSubview:label];
        }else{
            view.frame = CGRectMake(0, 0, tableView.width, 0);
        }
    }else{
        if (self.lastMonthNewCourses.count>0) {
            view.frame = CGRectMake(0, 0, tableView.width, 45.f*Size_ratio);
            label.text = [NSString stringWithFormat:@"%@月新上架",lastMonthString];
            label.frame = CGRectMake((ScreenWidth-94*Size_ratio)/2, 10.f*Size_ratio, 94.f*Size_ratio, 25.f*Size_ratio);
            [view addSubview:label];
        }else{
            view.frame = CGRectMake(0, 0, tableView.width, 0);
        }
    }
    
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        if (self.thisMonthNewCourses.count>0) {
            return 45.f*Size_ratio;
        }
    }else{
        if (self.lastMonthNewCourses.count>0) {
            return 45.f*Size_ratio;
        }
    }
    return .01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 117.f*Size_ratio;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WYACourseDetailVC * detail = [[WYACourseDetailVC alloc]init];
    if (indexPath.section == 0) {
        ThisMonth * model = (ThisMonth *)self.thisMonthNewCourses[indexPath.row];
        detail.courseID = model.course_id;
        detail.course_id = model.course_id;
        detail.img_url = model.img_url;
        detail.course_title = model.title;
    }else if (indexPath.section == 1) {
        LastMonth * model = (LastMonth *)self.lastMonthNewCourses[indexPath.row];
        detail.courseID = model.course_id;
        detail.course_id = model.course_id;
        detail.img_url = model.img_url;
        detail.course_title = model.title;
    }
    detail.titleColorSelected= [UIColor WYAJHBasePurpleColor];
    detail.titleColorNormal = [UIColor WYAJHBlackTextColor];
    detail.menuHeight = 40.f;
    detail.menuViewStyle = WMMenuViewStyleLine;
    detail.progressColor = [UIColor WYAJHBasePurpleColor];
    detail.automaticallyCalculatesItemWidths = YES;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
