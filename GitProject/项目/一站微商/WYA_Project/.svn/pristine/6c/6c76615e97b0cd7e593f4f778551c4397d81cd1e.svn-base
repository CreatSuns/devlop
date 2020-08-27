//
//  WYANowDownloadView.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/25.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYANowDownloadView.h"
#import "WYANowDownloadCell.h"
#import "WYANowDownloadEditView.h"
#import "WYALocalDownloadModel.h"

#import "SODownloader+WYAVideoDownload.h"

static void * kDownloaderKVOContext = &kDownloaderKVOContext;

static NSString * downloadCell = @"downloadCell";

@interface WYANowDownloadView () <UITableViewDelegate,UITableViewDataSource, NowDownloadEditDelegate,NowDownloadCellDelegate>

@property (nonatomic, strong) UITableView * table;

@property (nonatomic, strong) UILabel * memoryLabel;

@property (nonatomic, strong) NSMutableArray * dataSource;

@property (nonatomic, assign) BOOL edit;
@property (nonatomic, assign) BOOL allSelected;
@property (nonatomic, strong) WYANowDownloadEditView * editView;

@property (nonatomic, assign) BOOL downloadState;

@property (nonatomic, strong) NSMutableArray * cellModel;

@end

@implementation WYANowDownloadView

- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.tableHeaderView = [[UIView alloc]init];
        _table.tableFooterView = [[UIView alloc]init];
        [_table registerClass:[WYANowDownloadCell class] forCellReuseIdentifier:downloadCell];
    }
    return _table;
}

- (UILabel *)memoryLabel{
    if (!_memoryLabel) {
        _memoryLabel = [[UILabel alloc]init];
        _memoryLabel.backgroundColor = [UIColor WYAJHLightGreyColor];
        [WYAJHTools fileSizeWithFilePath:[NSString downloadVideoPath]];
        NSString * allSize = [NSString stringWithFormat:@"%2.fG",[WYAJHTools getDivceAvailableSize]];
        NSUserDefaults * us = [NSUserDefaults standardUserDefaults];
        NSString * userSize = [us objectForKey:@"VideoSize"];
        NSAttributedString * string = [WYAJHTools AttribytedStringWithstr:[NSString stringWithFormat:@"已下载%@，可用空间%@",
                                                                           userSize,
                                                                           allSize]
                                                                changeStr:@[userSize,
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

- (WYANowDownloadEditView *)editView{
    if (!_editView) {
        _editView = [[WYANowDownloadEditView alloc]init];
        _editView.hidden = YES;
        _editView.delegate = self;
    }
    return _editView;
}

- (NSMutableArray *)cellModel{
    if (!_cellModel) {
        _cellModel = [NSMutableArray arrayWithCapacity:0];
    }
    return _cellModel;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.table];
        [self addSubview:self.memoryLabel];
        [self addSubview:self.editView];
        _tableView = self.table;
        NSUserDefaults * us = [NSUserDefaults standardUserDefaults];
        BOOL didKillAPP = [us boolForKey:WYADIDKILLAPP];
        if (didKillAPP) {
            _downloadState = didKillAPP;
        }

        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(downloadSizeClick:) name:DOWNLOADSIZE object:nil];
        [[SODownloader videoDownloader]addObserver:self forKeyPath:SODownloaderDownloadArrayObserveKeyPath options:NSKeyValueObservingOptionNew context:kDownloaderKVOContext];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    [self.memoryLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).with.offset(WYABottomHeight);
        make.height.mas_equalTo(24.f);
    }];
    
    [self.editView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).with.offset(WYABottomHeight);
        make.height.mas_equalTo(48.f);
    }];
    
    [self.table mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self);
        if (self.memoryLabel.hidden) {
            make.bottom.mas_equalTo(self.editView.mas_top);
        }else if (self.editView.hidden) {
            make.bottom.mas_equalTo(self.memoryLabel.mas_top);
        }else{
            make.bottom.mas_equalTo(self.mas_bottom);
        }
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WYANowDownloadCell * cell = [[WYANowDownloadCell alloc]initWithStyle:0 reuseIdentifier:@"aaa"];
    
    [cell configureMusic:self.dataSource[indexPath.row]];
    cell.canEdit = self.edit;
    cell.delegate = self;
    cell.selectCell = self.allSelected;
    WeakSelf(weakSelf);
//    cell.buttonXZ = ^(BOOL seletState, WYALocalDownloadModel *model) {
//        
//    };
//    cell.aaa = ^(BOOL seletState, WYALocalDownloadModel *model) {
//        if (seletState) {
//            [weakSelf.cellModel addObject:model];
//        }else{
//            [weakSelf.cellModel removeObject:model];
//        }
//    };
    
    return cell;
}

/// 实现这个代理方法是为了当一个cell在界面消失时，移除cell对music模型的kvo。
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    WYANowDownloadCell *musicCell = (WYANowDownloadCell *)cell;
    [musicCell configureMusic:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    _downloadState = !_downloadState;
    WYANowDownloadCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    WYALocalDownloadModel * model = self.dataSource[indexPath.row];
    switch (model.so_downloadState) {
        case SODownloadStateError:
        {
            [[SODownloader videoDownloader]resumeItem:model];
        }
            break;
        case SODownloadStatePaused:
        {
            [[SODownloader videoDownloader]resumeItem:model];
        }
            break;
        case SODownloadStateNormal:
        {
            [[SODownloader videoDownloader]downloadItem:model];
        }
            break;
        case SODownloadStateLoading:
        {
            [[SODownloader videoDownloader]pauseItem:model];
        }
            break;
        case SODownloadStateWait:
        {
            [[SODownloader videoDownloader]pauseItem:model];
        }
            break;
            
        default:
            break;
    }
}

- (void)selectCellWithState:(BOOL)state Model:(WYALocalDownloadModel *)model{
    if (state) {
        [self.cellModel addObject:model];
        if (self.cellModel.count == self.dataSource.count) {
            if (self.cellModel.count == self.dataSource.count) {
                self.editView.allSelectButton.selected = YES;
            }
            
            [self.editView.deleteButton setTitle:[NSString stringWithFormat:@"删除(%ld)",self.cellModel.count] forState:UIControlStateNormal];
        }
    }else{
        [self.cellModel removeObject:model];
        self.editView.allSelectButton.selected = NO;
        [self.editView.deleteButton setTitle:[NSString stringWithFormat:@"删除(%ld)",self.cellModel.count] forState:UIControlStateNormal];
    }
}

- (void)setDatas:(NSArray *)datas{
    if (datas) {
        self.dataSource = [datas mutableCopy];
        [self.tableView reloadData];
//        NSArray * models = [NSArray arrayWithArray:datas];
//        if (self.dataSource.count == models.count) {
//            for (WYALocalDownloadModel * model in models) {
//                for (WYALocalDownloadModel * cellModel in self.dataSource) {
//                    if ([model.fileName isEqualToString:cellModel.fileName]) {
//                        NSUInteger index = [self.dataSource indexOfObject:cellModel];
////                        [self.dataSource replaceObjectAtIndex:index withObject:model];
//                        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
//                        WYANowDownloadCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
//                        cell.model = model;
//
//                    }
//                }
//            }
//
//        }else{
//            self.dataSource = [models mutableCopy];
//            [self.tableView reloadData];
//
//        }
        
        
        
    }
}

- (void)setCanEdit:(BOOL)canEdit{
    self.edit = canEdit;
     [self.table reloadData];
    if (canEdit) {
        self.memoryLabel.hidden = YES;
        self.editView.hidden = NO;
        self.editView.allSelectButton.selected = NO;
        [self.editView.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    }else{
        self.memoryLabel.hidden = NO;
        self.editView.hidden = YES;
        self.editView.allSelectButton.selected = NO;
        [self.editView.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    }
    
    [self layoutIfNeeded];
}

- (void)allSeletedWithSeleted:(BOOL)seleted{
    if (seleted) {
        self.allSelected = YES;
        [self.editView.deleteButton setTitle:[NSString stringWithFormat:@"删除(%ld)",self.dataSource.count] forState:UIControlStateNormal];
    }else{
        self.allSelected = NO;
        [self.cellModel removeAllObjects];
        [self.editView.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    }
    
    [self.table reloadData];
    
}

- (void)deleteSeleted{
    if (self.deleteAction) {
        self.deleteAction(self.cellModel);
    }
    self.editView.allSelectButton.selected = YES;
    [self.editView.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
}

#pragma mark - KVO
/**
 *  当“已下载”列表发生变化时，这个方法会执行，这里用于通知界面进行刷新
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (context == kDownloaderKVOContext) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSInteger kind = [change[NSKeyValueChangeKindKey] integerValue];
            NSIndexSet *indexSet = change[NSKeyValueChangeIndexesKey];
            NSArray *news = change[NSKeyValueChangeNewKey];
            
            switch (kind) {
                case NSKeyValueChangeInsertion:     // 插入，代表新的下载完成任务
                {
                    NSInteger index = [indexSet firstIndex];
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
                    NSMutableArray *temp = [self.dataSource mutableCopy];
                    [temp insertObject:[news lastObject] atIndex:index];
                    self.dataSource = temp;
                    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
                    break;
                case NSKeyValueChangeRemoval:       // 移除
                {
                    NSMutableArray *temp = [self.dataSource mutableCopy];
                    [temp removeObjectsAtIndexes:indexSet];
                    self.dataSource = temp;
                    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:indexSet.count];
                    [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
                        [indexPaths addObject:[NSIndexPath indexPathForRow:idx inSection:0]];
                    }];
                    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
                }
                    break;
                default:
                    // 其实这里可以不做任何判断，直接调用[tableView reloadData]会更简单些，上面的分支用于展示对已下载列表的变化进行更精细的处理
                    [self.tableView reloadData];
                    break;
            }
        });
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:DOWNLOADSIZE object:nil];
    [self.tableView.visibleCells makeObjectsPerformSelector:@selector(configureMusic:) withObject:nil];
    [[SODownloader videoDownloader]removeObserver:self forKeyPath:SODownloaderDownloadArrayObserveKeyPath];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
