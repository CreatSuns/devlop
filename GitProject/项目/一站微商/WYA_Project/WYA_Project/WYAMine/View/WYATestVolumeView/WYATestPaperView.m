//
//  WYATestPaperView.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/18.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYATestPaperView.h"

#import "WYATestPaperSelectorView.h"
#import "WYATestPaperCell.h"
#import "WYATestPaperCollectionHeadView.h"
#import "WYATestPaperPeopleAndChapterModel.h"
#import "WYATestPaperModel.h"

static NSString * collectionCell = @"collectionCell";
static NSString * tableViewCell = @"tableViewCell";
static NSString * collectionHead = @"collectionHead";

@interface WYATestPaperView ()<UICollectionViewDelegate, UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,seletorDelegete>

@property (strong, nonatomic) WYATestPaperSelectorView * selectorView;

@property (strong, nonatomic) UICollectionView * collectionView;

@property (nonatomic, strong) UIView * showView;

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * tableArray;

@property (nonatomic, strong) WYATestPaperPeopleAndChapterModel * selectorModel;

@property (nonatomic, strong) WYATestPaperModel * model;
@end

@implementation WYATestPaperView

- (WYATestPaperSelectorView *)selectorView{
    if (!_selectorView) {
        _selectorView = [[WYATestPaperSelectorView alloc]init];
        _selectorView.delegate = self;
    }
    return _selectorView;
}

- (UIView *)showView{
    if (!_showView) {
        _showView = [[UIView alloc]init];
        _showView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
        _showView.hidden = YES;
    }
    return _showView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableViewCell];
    }
    return _tableView;
    
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 30*Size_ratio;
        layout.minimumInteritemSpacing = 14*Size_ratio;
        layout.itemSize = CGSizeMake((ScreenWidth-90*Size_ratio)/2, 205*Size_ratio);
        layout.headerReferenceSize = CGSizeMake(ScreenWidth, 40.f*Size_ratio);
        layout.sectionInset = UIEdgeInsetsMake(14*Size_ratio, 30*Size_ratio, 14*Size_ratio, 30*Size_ratio);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor WYAJHLightGreyColor];
        [_collectionView registerClass:[WYATestPaperCell class] forCellWithReuseIdentifier:collectionCell];
        [_collectionView registerClass:[WYATestPaperCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHead];
    }
    return _collectionView;
}

- (NSMutableArray *)tableArray{
    if (!_tableArray) {
        _tableArray = [NSMutableArray new];
    }
    return _tableArray;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.selectorView];
        [self addSubview:self.collectionView];
        [self addSubview:self.showView];
        [self.showView addSubview:self.tableView];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.selectorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self);
        make.height.mas_equalTo(39.f*Size_ratio);//修改高度约束
    }];
    
    [self.showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.top.mas_equalTo(self.selectorView.mas_bottom);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.showView);
        make.height.mas_equalTo(200);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.top.mas_equalTo(self.selectorView.mas_bottom);
    }];
   
    
}
#pragma make UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return self.model? self.model.list.count !=0 & self.model.list != nil? self.model.list.count:0:0;
    if (self.model) {
        return self.model.list.count;
    }else if(self.array){
        return self.array.count;
    }else{
        return 0;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return self.model? self.model.list.count !=0 & self.model.list != nil? self.model.list[:0:0:0;
    if (self.model) {
        WYATestPaperListModel * list = (WYATestPaperListModel *)self.model.list[section];
        return list.user.count;
    }else if(self.array){
        NSArray * subArray = self.array[section];
        return subArray.count;
    }else{
        return 0;
    }
    
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WYATestPaperCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    if (self.model) {
        WYATestPaperListModel * list = (WYATestPaperListModel *)self.model.list[indexPath.section];
        cell.chapterNumberLabel.text = list.group_name;
        cell.topicNumberLabel.text = [NSString stringWithFormat:@"本卷共%d题",list.count];
        cell.model = list.user[indexPath.row];
    }else if (self.array) {
        NSArray * subArray = self.array[indexPath.section];
        cell.mainModel = subArray[indexPath.row];
    }
    
    return cell;
}

/** 头部/底部*/
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        // 头部
        WYATestPaperCollectionHeadView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:collectionHead forIndexPath:indexPath];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40*Size_ratio)];
        label.font = [UIFont systemFontOfSize:17*Size_ratio];
        label.textColor = [UIColor WYAJHgrayTextColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor WYAJHLightGreyColor];
        if (self.model) {
            WYATestPaperListModel * listModel = (WYATestPaperListModel *)self.model.list[indexPath.section];
            label.text = checkString(listModel.group_name);
        }else if (self.array){
            NSArray * arr = self.array[indexPath.section];
            WYALevelPaperListModel * model = arr[indexPath.row];
            label.text  = model.group_name;
        }
        
        
        [view addSubview:label];
        return view;
        
    }else{
        return nil;
    }
}

#pragma mark  UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * string = @"";
    NSString * title = @"";
    if (self.model) {
        WYATestPaperListModel * listModel = (WYATestPaperListModel *)self.model.list[indexPath.section];
        string = listModel.paper_id;
        WYATestPaperUserModel * userModel = (WYATestPaperUserModel *)listModel.user[indexPath.item];
        title = userModel.score;
    }else if (self.array) {
        NSArray * arr = self.array[indexPath.section];
        WYALevelPaperListModel * model = (WYALevelPaperListModel *)arr[indexPath.row];
        string = model.paper_id;
        title = model.score;
    }
    
    if ([title isEqualToString:@"未开始"] || [title isEqualToString:@"开始"]) {
        [WYAShowMessageView showToastAWithMessage:@"该成员没有测试成绩无法查看"];
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionCellDidSelectedWithString:)]) {
        [self.delegate collectionCellDidSelectedWithString:string];
    }
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma make  seletorDelegete
- (void)selectedChapterWithButton:(UIButton *)sender{
    //点击了全部章节
    if (!sender.selected) {
        self.showView.hidden = YES;
        return;
    }
    
    if (self.selectorModel.group_name.count!= 0 && self.selectorModel.group_name != nil) {
        self.showView.hidden = NO;
        [self.tableArray removeAllObjects];
        self.tableArray = [self.selectorModel.group_name mutableCopy];
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(self.showView);
            make.height.mas_equalTo(44.f*self.tableArray.count >(ScreenHeight-WYATopHeight-39.f) ? ScreenHeight-WYATopHeight-39.f :44.f*self.tableArray.count);
        }];
        [self.tableView reloadData];
    }else
    {
        self.showView.hidden = YES;
    }
    
    
}

- (void)selectedPeopleWithButton:(UIButton *)sender{
    //点击了全部人员
    if (!sender.selected) {
        self.showView.hidden = YES;
        return;
    }
    if (self.selectorModel.user.count!= 0 && self.selectorModel.user != nil) {
        self.showView.hidden = NO;
        [self.tableArray removeAllObjects];
        self.tableArray = [self.selectorModel.user mutableCopy];

        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(self.showView);
            make.height.mas_equalTo(44.f*self.tableArray.count >(ScreenHeight-WYATopHeight-39.f) ? ScreenHeight-WYATopHeight-39.f :44.f*self.tableArray.count);
        }];
        [self.tableView reloadData];
    }else
    {
        self.showView.hidden = YES;
    }
}

#pragma make UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:tableViewCell forIndexPath:indexPath];
    id obj = self.tableArray[indexPath.row];
    if ([obj isKindOfClass:[WYATestPaperChapterModel class]]) {
        WYATestPaperChapterModel * chapterModel = (WYATestPaperChapterModel *)obj;
        cell.textLabel.text = chapterModel.label;
    }else if ([obj isKindOfClass:[WYATestPaperPeopleModel class]]) {
        WYATestPaperPeopleModel * peopleModel = (WYATestPaperPeopleModel *)obj;
        cell.textLabel.text = peopleModel.label;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14*Size_ratio];//给cell的文字添加字体大小限制

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}

#pragma make UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id obj = self.tableArray[indexPath.row];
    WYATestPaperChapterModel * chapterModel;
    WYATestPaperPeopleModel * peopleModel;
    if ([obj isKindOfClass:[WYATestPaperChapterModel class]]) {
        chapterModel = (WYATestPaperChapterModel *)obj;
        self.selectorView.chapterName = chapterModel.label;
    }else if ([obj isKindOfClass:[WYATestPaperPeopleModel class]]) {
        peopleModel = (WYATestPaperPeopleModel *)obj;
        self.selectorView.peopleName = peopleModel.label;
    }
    self.showView.hidden = YES;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchTestPaperWithChapter:People:)]) {
        [self.delegate searchTestPaperWithChapter:chapterModel.value People:peopleModel.value];
    }
    
}

-(void)setPeopleAndChapterModel:(WYATestPaperPeopleAndChapterModel *)peopleAndChapterModel{
    if (peopleAndChapterModel) {
        self.selectorModel = peopleAndChapterModel;
    }
}

- (void)setNeedSelector:(BOOL)needSelector{
    if (!needSelector) {
        self.selectorView.hidden = YES;

        [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
}

- (void)setTestPaperModel:(WYATestPaperModel *)testPaperModel{
    if (!_testPaperModel) {
        self.model = testPaperModel;
        [self.collectionView reloadData];
    }
}

- (void)setArray:(NSMutableArray *)array{
    _array = array;
    if (_array) {
        self.model = nil;
        [self.collectionView reloadData];
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
