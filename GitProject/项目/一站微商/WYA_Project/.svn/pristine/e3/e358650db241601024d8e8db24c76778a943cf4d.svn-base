//
//  WYAMineDownloadView.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/20.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMineDownloadView.h"
#import "WYAMineDownloadModel.h"
#import "WYAMineVideoDownloadCell.h"
#import "WYAMineArticleDownloadCell.h"
#import "WYALocalDownloadModel.h"
#import "WYATableNameModel.h"
#import "SODownloader+WYAVideoDownload.h"
static NSString * systemCell = @"systemCell";
static NSString * videoCell = @"videoCell";
static NSString * articleCell = @"articleCell";

@interface WYAMineDownloadView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * dataSource;

@property (nonatomic, strong) UILabel * memoryLabel;

@property (nonatomic, strong) WYAMineDownloadModel * downloadModel;

@property (nonatomic, assign) NSUInteger downloadCount;

@end

@implementation WYAMineDownloadView

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:systemCell];
        [_tableView registerClass:[WYAMineVideoDownloadCell class] forCellReuseIdentifier:videoCell];
        [_tableView registerClass:[WYAMineArticleDownloadCell class] forCellReuseIdentifier:articleCell];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 100;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UILabel *)memoryLabel{
    if (!_memoryLabel) {
        _memoryLabel = [[UILabel alloc]init];
        _memoryLabel.backgroundColor = [UIColor WYAJHLightGreyColor];
        [WYAJHTools fileSizeWithFilePath:[NSString downloadVideoPath]];
        NSString * allSize = [NSString stringWithFormat:@"%2.fG",[WYAJHTools getDivceAvailableSize]];
        NSAttributedString * string = [WYAJHTools AttribytedStringWithstr:[NSString stringWithFormat:@"已下载%@，可用空间%@",
                                                                           @"0KB",
                                                                           allSize]
                                                                changeStr:@[@"0KB",
                                                                            allSize]
                                                   NSAttributedStringKeys:@[NSForegroundColorAttributeName,NSFontAttributeName]
                                                        NSAttributedValue:@[[UIColor WYAJHBaseBlueColor],[UIFont systemFontOfSize:14]]];
        _memoryLabel.attributedText = string;
        _memoryLabel.font = [UIFont systemFontOfSize:14];
        _memoryLabel.textAlignment = NSTextAlignmentCenter;
        _memoryLabel.hidden = NO;
    }
    return _memoryLabel;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.tableView];
        [self addSubview:self.memoryLabel];
//        self.downloadCount = 0;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(downloadSizeClick:) name:DOWNLOADSIZE object:nil];
        
        _table = self.tableView;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self);
    }];
    
    [self.memoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.top.mas_equalTo(self.tableView.mas_bottom);
        make.height.mas_equalTo(24.f);
    }];
}

-(void)headRefresh{
    
}

- (void)downloadSizeClick:(NSNotification *)not{
//    NSUserDefaults * us = [NSUserDefaults standardUserDefaults];
//    NSString * userSize = [us objectForKey:@"VideoSize"];
    NSString * userSize = not.userInfo[@"size"];
    NSString * allSize = [NSString stringWithFormat:@"%2.fG",[WYAJHTools getDivceAvailableSize]];
    if (!userSize || userSize == nil || [userSize isEqualToString:@""] || !allSize || allSize == nil) {
        self.memoryLabel.attributedText = nil;
    }else{
        NSAttributedString * string = [WYAJHTools AttribytedStringWithstr:[NSString stringWithFormat:@"已下载%@，可用空间%@",
                                                                           userSize,
                                                                           allSize]
                                                                changeStr:@[userSize,
                                                                            allSize]
                                                   NSAttributedStringKeys:@[NSForegroundColorAttributeName,NSFontAttributeName]
                                                        NSAttributedValue:@[[UIColor WYAJHBaseBlueColor],[UIFont systemFontOfSize:14]]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.memoryLabel.attributedText = string;
        });
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-  (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:systemCell forIndexPath:indexPath];
        cell.imageView.image = [UIImage imageNamed:@"download"];
        cell.textLabel.text = [NSString stringWithFormat:@"剩余%ld个任务",[[SODownloader videoDownloader] downloadArray].count];
        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Right arrow"]];
        return cell;
    }else{
        
        WYAMineVideoDownloadCell * cell = [tableView dequeueReusableCellWithIdentifier:videoCell forIndexPath:indexPath];
        cell.model = self.dataSource[indexPath.row];
        return cell;
    }
//    else if ([obj.fileNumber isEqualToString:@"3"]) {
//        WYAMineArticleDownloadCell * cell = [tableView dequeueReusableCellWithIdentifier:articleCell forIndexPath:indexPath];
//        cell.model = (WYAArticleDownloadModel *)obj;
//        return cell;
//    }else{
//        return nil;
//    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 35.f)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(17.f, 11.f, ScreenWidth-17.f, 25.f)];
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor WYAJHBlackTextColor];
    label.font = [UIFont systemFontOfSize:15.f];
    label.textAlignment = NSTextAlignmentLeft;
    if (section == 0) {
        label.text = @"正在下载";
    }else{
        label.text = @"已完成";
    }
    [backgroundView addSubview:label];
    return backgroundView;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5.f)];
    view.backgroundColor = [UIColor WYAJHLightGreyColor];
    if (section == 0) {
        return view;
    }
    return nil;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
//        return 44.f;
//    }else{
//        return UITableViewAutomaticDimension;
//    }
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 5.f;
    }else{
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectRow) {
        if (indexPath.section == 0) {
            self.selectRow(indexPath, nil, nil);
        }else{
            id obj = self.dataSource[indexPath.row];
            if ([obj isKindOfClass:[WYATableNameModel class]]) {
                WYATableNameModel * model = (WYATableNameModel *)obj;
                self.selectRow(indexPath, model.course_title, model.course_id);
            }
        }
        
        
    }
}

- (void)setModel:(WYAMineDownloadModel *)model{
    if (model) {
        self.downloadModel = model;
        [self.dataSource addObjectsFromArray:model.video_download];
        [self.dataSource addObjectsFromArray:model.article_download];
        [self.tableView reloadData];
    }
}

- (void)setNowDownloadCount:(NSUInteger)nowDownloadCount{
    self.downloadCount = nowDownloadCount;
    [self.tableView reloadData];
}

- (void)setFinishDownloadArray:(NSArray *)finishDownloadArray{
    if (finishDownloadArray) {
        self.dataSource = [finishDownloadArray mutableCopy];
        [self.tableView reloadData];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
