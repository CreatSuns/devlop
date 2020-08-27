//
//  WYAChooseDownloadVC.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/23.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAChooseDownloadVC.h"
#import "WYAChooseDownloadCell.h"
#import "WYAChooseDownloadHeadView.h"
#import "WYAChooseDownloadBottomView.h"

#import "WYAChooseDownloadNetRequest.h"
#import "WYAChooseDownloadMolde.h"

#import "WYAMineDownloadVC.h"

#import "WYALocalDownloadModel.h"

#import "SODownloader+WYAVideoDownload.h"

@interface WYAChooseDownloadVC ()<UITableViewDataSource, UITableViewDelegate, ChooseDownloadDelegate>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) WYAChooseDownloadBottomView * bottomView;

@property (nonatomic, strong) WYAChooseDownloadNetRequest * netRequest;

/**
 存放需要下载的Model
 */
@property (nonatomic, strong) NSMutableArray * downloadArray;

/**
 只是用来记录获取了多少条数据
 */
@property (nonatomic, strong) NSMutableArray * recordArray;

/**
 判断是否全部选中
 */
@property (nonatomic, assign) BOOL isAllSelected;

/**
 存储由本地model去替换请求数据的数组
 */
@property (nonatomic, strong) NSMutableArray * modelArray;

@property (nonatomic, strong) WYAChooseDownloadMolde * downloadModel;

@end

@implementation WYAChooseDownloadVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.tableView) {
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择下载";
    [self configView];
    
    [self loadChapterDownloadData];
    
    [self addNotice];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WYADOWNLOADBUTTONCHANGERCOLOR object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- Lazy
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];
        [_tableView registerClass:[WYAChooseDownloadCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[WYAChooseDownloadHeadView class] forHeaderFooterViewReuseIdentifier:@"head"];
    }
    return _tableView;
}

- (WYAChooseDownloadBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[WYAChooseDownloadBottomView alloc]init];
        _bottomView.delegate = self;
        WeakSelf(weakSelf);
        _bottomView.showAlert = ^{
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"你在当前在3G/4G网络下，下载或观看视频会消耗较多流量，系统已自动暂停，你可在设置界面开启。" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * knowAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:knowAction];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        };
        
    }
    return _bottomView;
}

- (WYAChooseDownloadNetRequest *)netRequest{
    if (!_netRequest) {
        _netRequest = [[WYAChooseDownloadNetRequest alloc]init];
    }
    return _netRequest;
}

- (NSMutableArray *)downloadArray{
    if (!_downloadArray) {
        _downloadArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _downloadArray;
}

- (NSMutableArray *)recordArray{
    if (!_recordArray) {
        _recordArray = [NSMutableArray array];
    }
    return _recordArray;
}

- (NSMutableArray *)modelArray{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

#pragma mark --- Private method
- (void)configView{
    self.isAllSelected = NO;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-WYABottomHeight);
        make.height.mas_equalTo(44.f);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
    }];
    
    if ([self.skip isEqualToString:@"1"]) {
        //允许乱序播放
        self.bottomView.chooseButton.hidden = NO;
    }else{
        self.bottomView.chooseButton.hidden = YES;
    }
    
    [self addNavRightButtonWithTitle:@"下载管理" TitleColor:[UIColor WYAJHBaseBlueColor]];
}

- (void)rightBarButtonItemClicked:(UIButton *)sender{
    WYAMineDownloadVC * vc = [[WYAMineDownloadVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addNotice{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeDownloadButonBackgroundColor:) name:WYADOWNLOADBUTTONCHANGERCOLOR object:nil];
    
}

#pragma mark --- NSNotification
- (void)changeDownloadButonBackgroundColor:(NSNotification *)not{
    NSMutableArray * array1 = (NSMutableArray *)not.userInfo[@"array"];
    if (array1.count>0) {
        [self.bottomView.downloadButton setBackgroundColor:[UIColor WYAJHBaseBlueColor]];
        self.bottomView.downloadButton.enabled = YES;
    }else{
        [self.bottomView.downloadButton setBackgroundColor:[UIColor WYAJHStoneGrayColor]];
    }
    
    if (array1.count == self.recordArray.count && array1.count > 0 && self.recordArray.count > 0) {
        self.bottomView.chooseButton.selected = YES;
    }else{
        self.bottomView.chooseButton.selected = NO;
    }
}

#pragma mark --- loadData
- (void)loadChapterDownloadData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * params = [NSMutableDictionary new];
    [params setObject:checkString(self.courseID) forKey:@"course_id"];
    
    [self.netRequest loadChapterDownloadWithParams:params Success:^(id data) {
        if (!data) return;
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.downloadArray removeAllObjects];
        [self.modelArray removeAllObjects];
        [self.recordArray removeAllObjects];
        
        WYAChooseDownloadMolde * model = (WYAChooseDownloadMolde *)data;
        self.downloadModel = model;
        
        for (NSUInteger section = 0; section < model.data.count; section++) {
            NSMutableArray *items = [NSMutableArray array];
            WYAChooseGroupModel * groupsModel = model.data[section];
            for (NSUInteger i = 0; i < groupsModel.chapters.count; i++) {
                WYAChooseChapterModel * chapterModel = groupsModel.chapters[i];
                
                [items addObject:chapterModel];
                [self.recordArray addObject:chapterModel];
                
            }
            [self.modelArray addObject:items];
            
        }
        [self.tableView reloadData];
        
        
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

#pragma mark --- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.downloadModel.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    WYAChooseGroupModel * groupModel = self.downloadModel.data[section];
    return groupModel.flag ? groupModel.chapters.count : 0 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WYAChooseDownloadCell * cell = [[WYAChooseDownloadCell alloc]initWithStyle:0 reuseIdentifier:@"cel"];
    WYAChooseGroupModel * groupModel = self.downloadModel.data[indexPath.section];
    WYAChooseChapterModel * chapterModel = groupModel.chapters[indexPath.row];
    
    cell.model = chapterModel;
    cell.localArray = [self.netRequest findLocalArrayModelWithTableName:self.course_name];
    cell.downArray = [[SODownloader videoDownloader] downloadArray];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WYAChooseDownloadCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    WYAChooseGroupModel * groupModel = self.downloadModel.data[indexPath.section];
    WYAChooseChapterModel * chapterModel = groupModel.chapters[indexPath.row];
    if (chapterModel.can_download != 1) {
        [WYAShowMessageView showToastAWithMessage:@"该视频暂不能被下载"];
        return;
    }
    if (!cell.stateString || [cell.stateString isEqualToString:@"下载失败"] || [cell.stateString isEqualToString:@"失败"]) {
        cell.chooseButton.selected = !cell.chooseButton.selected;
        if (cell.chooseButton.selected) {
            if ([cell.stateString isEqualToString:@"下载失败"] || [cell.stateString isEqualToString:@"失败"] ) {
                cell.model.download_status = @"yes";
            }
            [self.downloadArray addObject:cell.model];
        }else{
            [self.downloadArray removeObject:cell.model];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:WYADOWNLOADBUTTONCHANGERCOLOR object:nil userInfo:@{@"array":self.downloadArray}];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    WYAChooseDownloadHeadView * headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    headView.model = self.downloadModel.data[section];
    headView.HeaderClickedBack = ^(BOOL isExpand){
        
        [tableView reloadSections:[[NSIndexSet alloc] initWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    return headView;
}

/// 实现这个代理方法是为了当一个cell在界面消失时，移除cell对music模型的kvo。
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    WYAChooseDownloadCell *musicCell = (WYAChooseDownloadCell *)cell;
    musicCell.localModel = nil;
}

#pragma mark --- ChooseDownloadDelegate
- (void)seletedAllAction{
    
    if ([self.skip isEqualToString:@"2"])
    {
        //不允许乱序播放
        [WYAShowMessageView showToastAWithMessage:@"请单节下载观看视频"];
        return;
    }
    
    [self.downloadArray removeAllObjects];
    
    if (self.isAllSelected == NO) {
        self.isAllSelected = YES;
        
        for (int i = 0; i < self.modelArray.count; i++) {
            NSMutableArray * array = self.modelArray[i];
            for (int j = 0; j < array.count; j++) {
                id obj = array[j];
                if ([obj isKindOfClass: [WYAChooseChapterModel class]]) {
                    WYAChooseChapterModel * chapter = (WYAChooseChapterModel *)obj;
                    if (chapter.can_download) {
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
                        WYAChooseDownloadCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
                        cell.chooseButton.selected = YES;
                        [self.downloadArray addObject:chapter];
                    }
                }
                
            }
            
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:WYADOWNLOADBUTTONCHANGERCOLOR object:nil userInfo:@{@"array":self.downloadArray}];
    }
    else
    {
        self.isAllSelected = NO;
        
        for (int i = 0; i < self.modelArray.count; i++)
        {
            NSMutableArray * group = self.modelArray[i];
            for (int j = 0; j < group.count; j++)
            {
                id obj = group[j];
                
                if ([obj isKindOfClass:[WYAChooseChapterModel class]])
                {
                    
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
                    WYAChooseDownloadCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
                    cell.chooseButton.selected = NO;
                }
                
            }
            
        }
    }
}

- (void)startDownload{
    
    if (self.bottomView.downloadButton.enabled)
    {
        if (self.downloadArray.count == 0)
        {
            [WYAShowMessageView showToastAWithMessage:@"暂无下载任务"];
            return;
        }
        
        [self.netRequest startDownloadFileWithfileArray:self.downloadArray CourseID:self.courseID TableName:self.course_name GroupName:nil];
        [self.tableView reloadData];
        [self.downloadArray removeAllObjects];
        [self.bottomView.downloadButton setBackgroundColor:[UIColor WYAJHStoneGrayColor]];
        self.bottomView.downloadButton.enabled = NO;
        
    }
    
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
