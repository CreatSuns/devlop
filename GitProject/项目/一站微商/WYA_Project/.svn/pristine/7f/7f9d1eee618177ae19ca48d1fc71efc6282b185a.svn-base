//
//  WYATestPaperVC.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/18.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYATestPaperVC.h"
#import "WYATestPaperView.h"
#import "WYATestPaperNetRequest.h"
#import "WYATestVolumeViewController.h"
#import "WYAReportViewController.h"
#import "WYAMAinPaperCollectionView.h"
#import "WYAMainPaperListModel.h"
@interface WYATestPaperVC ()<TestPaperDelegate,WYAMAinPaperCollectionViewDelegate>

@property (nonatomic, strong) WYATestPaperView * paperView;

@property (nonatomic, strong) WYATestPaperNetRequest * netRequest;

@property(nonatomic, strong) WYAMAinPaperCollectionView * mainPaperView;
@property(nonatomic, assign) NSInteger page;

@end

@implementation WYATestPaperVC

- (WYATestPaperView *)paperView{
    if (!_paperView) {
        _paperView = [[WYATestPaperView alloc]init];
        _paperView.delegate = self;
    }
    return _paperView;
}
- (WYAMAinPaperCollectionView *)mainPaperView{
    if (!_mainPaperView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 30*Size_ratio;
        layout.minimumInteritemSpacing = 14*Size_ratio;
        layout.itemSize = CGSizeMake((ScreenWidth-90*Size_ratio)*0.5, 205.f*Size_ratio);
        layout.headerReferenceSize = CGSizeMake(ScreenWidth, 40.f*Size_ratio);
        layout.sectionInset = UIEdgeInsetsMake(14*Size_ratio, 30*Size_ratio, 14*Size_ratio, 30*Size_ratio);
        _mainPaperView = [[WYAMAinPaperCollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-WYATopHeight) collectionViewLayout:layout];
        _mainPaperView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
        _mainPaperView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        _mainPaperView.mainPaperDelegate = self;
//        _paperView.delegate = self;
    }
    return _mainPaperView;
}
- (WYATestPaperNetRequest *)netRequest{
    if (!_netRequest) {
        _netRequest = [[WYATestPaperNetRequest alloc]init];
    }
    return _netRequest;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.translucent = YES;
    self.title = @"测试试卷";
    self.view.backgroundColor = [UIColor whiteColor];
    
    switch (self.level) {
        case main:
            self.paperView.needSelector = NO;
            [self requestMainChapterdata];
            break;
        case secondary:
            [self.view addSubview:self.paperView];
            [self.paperView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
            }];
            self.paperView.needSelector = YES;
            [self loadAllPeopleWithChapterData];
            break;
        default:
            break;
    }
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    [self searchTestPaperWithChapter:nil People:nil];
}
#pragma mark ===== WYAMAinPaperCollectionViewDelegate
- (void)mainPaperView:(WYAMAinPaperCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray * array = collectionView.myDataSources;
    WYAMainPaperListModel * model = [array[indexPath.section] objectAtIndex:indexPath.row];
    if (model.score&&![model.score isEqualToString:@"暂无数据"]&&![model.score isEqualToString:@"开始"]) {
        WYAReportViewController * vc = [[WYAReportViewController alloc]init];
        vc.isShowTestBtn = YES;
        vc.paper_id = model.paper_id;
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
            WYATestVolumeViewController * vc = [[WYATestVolumeViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.pushFromWhere = WYATestPushForPaperContorller;
            [self.navigationController pushViewController:vc animated:YES];
            vc.paper_id = model.paper_id;
            NSString * currentSceonds = [WYAJHTools getNowTimeTimestampForSeconds];
            [[NSUserDefaults standardUserDefaults] setObject:currentSceonds forKey:@"beginTime"];
    }
}
#pragma mark ===== 获取主账号的测试试卷
- (void)footRefresh{
    
    self.page ++;
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"course_id"] = self.courseID;
    dict[@"page"] = [NSString stringWithFormat:@"%ld",(long)self.page];
    dict[@"subordinate"] = @"1";
    [self.netRequest loadMainTestPaperWithParams:dict Success:^(id data) {
        NSMutableArray * array = [NSMutableArray arrayWithObject:data];
        NSArray * tempArray = [array firstObject];
        if (array&&array.count!=0&&[tempArray count] != 0){
            [self.mainPaperView.myDataSources addObjectsFromArray:data];
            [self.mainPaperView.mj_footer endRefreshing];
            [self.mainPaperView.mj_footer resetNoMoreData];
        }else
        {
            [self.mainPaperView.mj_footer endRefreshingWithNoMoreData];
        }
     
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        [self.mainPaperView.mj_footer endRefreshing];
        

    }];
    
}
- (void)headerRefresh{
    
    self.page = 1;
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"course_id"] = self.courseID;
    dict[@"page"] = [NSString stringWithFormat:@"%ld",(long)self.page];
    dict[@"subordinate"] = @"1";
    [self.netRequest loadMainTestPaperWithParams:dict Success:^(id data) {
        [self.mainPaperView.myDataSources removeAllObjects];
        self.mainPaperView.myDataSources = data;
        [self.mainPaperView.mj_header endRefreshing];
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        [self.mainPaperView.mj_header endRefreshing];
        
        
    }];
    
}
- (void)requestMainChapterdata{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"course_id"] = self.courseID;
    dict[@"subordinate"] = @"1";
    dict[@"page"] = [NSString stringWithFormat:@"%ld",(long)self.page];
    [self.netRequest loadMainTestPaperWithParams:dict Success:^(id data) {
        self.mainPaperView.myDataSources = data;
        [self.view addSubview:self.mainPaperView];
        [self.mainPaperView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
    
}
- (void)loadAllPeopleWithChapterData{
    NSMutableDictionary * params = [NSMutableDictionary new];
    [params setObject:checkString(self.courseID) forKey:@"course_id"];
    [self.netRequest loadAllPerpleAndChapterWithParmas:params Success:^(id data) {
        WYATestPaperPeopleAndChapterModel * model = (WYATestPaperPeopleAndChapterModel *)data;
        self.paperView.peopleAndChapterModel = model;
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}

- (void)searchTestPaperWithChapter:(NSString *)chapter People:(NSString *)people{
    NSMutableDictionary * params = [NSMutableDictionary new];
    [params setObject:checkString(self.courseID) forKey:@"course_id"];
    switch (self.level) {
        case main:
            [params setObject:@"1" forKey:@"subordinate"];
            break;
            
        default:
            break;
    }
    if (chapter) {
        [params setObject:chapter forKey:@"group_id"];
    }
    if (people) {
        [params setObject:people forKey:@"admin_user_id"];
    }
    
    [self.netRequest loadTestPaperWithParams:params Success:^(id data) {
        if (chapter || people) {
            self.paperView.array = data;
        }else{
            self.paperView.testPaperModel = data;
        }
        
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}

-(void)collectionCellDidSelectedWithString:(NSString *)userID{
    
        WYAReportViewController * reVc = [[WYAReportViewController alloc]init];
        reVc.paper_id = userID;
        [self.navigationController pushViewController:reVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
