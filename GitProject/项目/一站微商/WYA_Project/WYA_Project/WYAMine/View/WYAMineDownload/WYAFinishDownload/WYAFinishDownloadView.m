//
//  WYAFinishDownloadView.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/27.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAFinishDownloadView.h"
#import "WYAFinishDownloadCell.h"
#import "WYANowDownloadEditView.h"

static NSString * downloadCell = @"downloadCell";

@interface WYAFinishDownloadView ()<UITableViewDelegate,UITableViewDataSource, NowDownloadEditDelegate>

@property (nonatomic, strong) UITableView * table;

@property (nonatomic, strong) UILabel * memoryLabel;

@property (nonatomic, strong) NSMutableArray * dataSource;

@property (nonatomic, assign) BOOL edit;
@property (nonatomic, assign) BOOL allSelected;
@property (nonatomic, strong) WYANowDownloadEditView * editView;

@property (nonatomic, strong) NSMutableArray * cellModel;

@end

@implementation WYAFinishDownloadView


- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;

        [_table registerClass:[WYAFinishDownloadCell class] forCellReuseIdentifier:downloadCell];
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
        _cellModel = [NSMutableArray new];
    }
    return _cellModel;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.table];
        [self addSubview:self.memoryLabel];
        [self addSubview:self.editView];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(downloadSizeClick:) name:DOWNLOADSIZE object:nil];
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
    WYAFinishDownloadCell * cell = [tableView dequeueReusableCellWithIdentifier:downloadCell forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    
    WeakSelf(weakSelf);
    cell.buttonSelect = ^(BOOL seletState, WYALocalDownloadModel * model) {
        StrongSelf(strongSwlf);
        if (seletState) {
            [strongSwlf.cellModel addObject:model];
            if (strongSwlf.cellModel.count == strongSwlf.dataSource.count) {
                strongSwlf.editView.allSelectButton.selected = YES;
            }
            
            [strongSwlf.editView.deleteButton setTitle:[NSString stringWithFormat:@"删除(%ld)",strongSwlf.cellModel.count] forState:UIControlStateNormal];
        }else{
            [strongSwlf.cellModel removeObject:model];
            strongSwlf.editView.allSelectButton.selected = NO;
            [strongSwlf.editView.deleteButton setTitle:[NSString stringWithFormat:@"删除(%ld)",strongSwlf.cellModel.count] forState:UIControlStateNormal];
        }
    };
    cell.selectCell = self.allSelected;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44.f)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20.f, 0, 200, 44.f)];
    label.textColor = [UIColor WYAJHBlackTextColor];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentLeft;
    label.text = self.title;
    [view addSubview:label];
    
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Right arrow"]];
    imageView.frame = CGRectMake(ScreenWidth-40, 14, 16, 16);
    [view addSubview:imageView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = view.frame;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSUserDefaults * us = [NSUserDefaults standardUserDefaults];
    BOOL edit = [us boolForKey:@"finishEdit"];
    if (edit == YES) {
        return;
    }
    WYALocalDownloadModel * model = self.dataSource[indexPath.row];
    if (self.goWatch) {
        self.goWatch(model);
    }
}

- (void)buttonClick:(UIButton *)button{
    if (self.goDetailVC) {
        self.goDetailVC();
    }
}

- (void)setDatas:(NSMutableArray *)datas{
    if (datas) {
        [self.dataSource removeAllObjects];
        self.dataSource = datas;
        [self.table reloadData];
    }
}

- (void)setCanEdit:(BOOL)canEdit{
    _canEdit = canEdit;
    [self.table reloadData];
    if (_canEdit) {
        self.memoryLabel.hidden = YES;
        self.editView.hidden = NO;
        self.editView.allSelectButton.selected = NO;
        [self.editView.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [self.cellModel removeAllObjects];
    }else{
        self.memoryLabel.hidden = NO;
        self.editView.hidden = YES;
        [self.editView.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [self.cellModel removeAllObjects];
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

- (void)deleteSeleted{
    if (self.deleteAction) {
        self.deleteAction(self.cellModel);
    }
    self.editView.allSelectButton.selected = YES;
    [self.editView.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:DOWNLOADSIZE object:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
