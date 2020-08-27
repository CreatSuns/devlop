//
//  WYAArticleDetailsVC.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/10.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAArticleDetailsVC.h"
#import <WebKit/WebKit.h>
#import "WYAArticleNetRequest.h"
#import "WYAArticleDetailModel.h"
#import "WYAArticleDetailsHeaderView.h"
#import "WYAArticleDetailsBottomView.h"
#import "UIView+WYALayout.h"
#import "WYAArticleNetRequest.h"
@interface WYAArticleDetailsVC ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate,WYAArticleDetailsBottomViewDelegate>
@property(nonatomic, strong) WYAArticleNetRequest * netRequest;
@property(nonatomic, strong) WYAArticleDetailModel * model;
@property(nonatomic, strong) UIWebView * webView;
@property(nonatomic, strong) UITableView * contentTableView;
@property(nonatomic, strong) WYAArticleDetailsHeaderView * headerView;
@property(nonatomic, strong) WYAArticleDetailsBottomView * botomView;
@property(nonatomic, strong) UIView * myBottomView;
@end

@implementation WYAArticleDetailsVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contentTableView];
    [self loadNetDataShowView];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)dealloc
{
    self.webView.delegate = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addBottomView:(WYAArticleDetailModel *)model
{
    _myBottomView = [[UIView alloc]init];
    [self.view addSubview:_myBottomView];
    [_myBottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(WYATabBarHeight);
    }];
    self.botomView.model = model;
    [_myBottomView addSubview:self.botomView];
}
#pragma mark ====== netRequest
- (WYAArticleNetRequest *)netRequest{
    if(_netRequest == nil){
        _netRequest = [[WYAArticleNetRequest alloc]init];
    }
    return _netRequest;
}
- (void)loadNetDataShowView{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"article_id"] = _article_id;
    [self.netRequest loadArticlDetailWithParams:dic Success:^(id data) {
        _model = data;
        [self addBottomView:_model];
        self.title = @"文章详情";
        self.contentTableView.tableHeaderView = self.headerView;
        self.headerView.model = _model;
        [MBProgressHUD showMessage:@"正在加载" ToView:self.view];
        [self.webView loadHTMLString:_model.content baseURL:nil];
        [self.contentTableView reloadData];
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        [MBProgressHUD showError:@"加载失败，请重试" ToView:self.view];
        [MBProgressHUD hideHUDForView:self.view];
        
    }];
}
#pragma mark ====== CreateUI
- (WYAArticleDetailsBottomView *)botomView
{
    if (_botomView == nil) {
        _botomView = [[WYAArticleDetailsBottomView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WYATabBarHeight)];
        _botomView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _botomView.delegate = self;
    }
    return _botomView;
}
- (WYAArticleDetailsHeaderView *)headerView
{
    if (_headerView == nil) {
        CGFloat titleHeight = [WYAJHTools heightOfConttent:_model.article_title fontSize:20*Size_ratio maxWidth:ScreenWidth-20*Size_ratio];
        _headerView = [[WYAArticleDetailsHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, titleHeight+45*Size_ratio)];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}
- (UITableView *)contentTableView
{
    if (_contentTableView == nil) {
        _contentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-WYATopHeight)];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.scrollEnabled = NO;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _contentTableView;
}
- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(10*Size_ratio,0, ScreenWidth-20*Size_ratio, ScreenHeight-self.headerView.frame.size.height-WYATopHeight-WYATabBarHeight)];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scalesPageToFit = YES;
        _webView.delegate = self;
    }
    return _webView;
}
#pragma mark ======UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //字体大小
    [MBProgressHUD hideHUDForView:self.view];

    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '200%'"];
//       [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'red'"];
}

#pragma mark ====== UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    if (_model) {
        [cell addSubview:self.webView];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _model==nil ? 0 : ScreenHeight - self.headerView.frame.size.height-WYATopHeight-WYATabBarHeight;
}
#pragma mark======
- (void)bottomViewFocusSelected:(UIImageView *)sender
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"teacher_id"] = _model.teacher_id;
    [self.netRequest focusTeacherWithParams:dict Success:^(id data) {
        NSLog(@"%@",data);
        if([data[@"msg"]isEqualToString:@"关注成功！"])
        {
            sender.image = [UIImage imageNamed:@"文章详情关注"];
            [WYAShowMessageView showToastBWithMessage:@"关注成功"];
        }else
        {
            sender.image = [UIImage imageNamed:@"我的关注-1"];
            [WYAShowMessageView showToastBWithMessage:@"取消关注成功"];

        }
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
- (void)bottomViewThumSelected:(UIImageView *)sender
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"article_id"] = self.article_id;
    [self.netRequest thumArticlDetailWithParams:dict Success:^(id data) {
        NSLog(@"%@",data);
        if([data[@"msg"]isEqualToString:@"点赞成功！"])
        {
            sender.image = [UIImage imageNamed:@"点赞已选"];
            [WYAShowMessageView showToastBWithMessage:@"已点赞"];

            
        }else
        {
            sender.image = [UIImage imageNamed:@"文章详情点赞"];
            [WYAShowMessageView showToastBWithMessage:@"已取消"];

        }
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
- (void)bottomViewCollectionSelected:(UIImageView *)sender
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"article_id"] = self.article_id;
    [self.netRequest collectionArticlDetailWithParams:dict Success:^(id data) {
        NSLog(@"%@",data);
        if([data[@"msg"]isEqualToString:@"收藏成功！"])
        {
            sender.image = [UIImage imageNamed:@"文章详情已收藏"];
            [WYAShowMessageView showToastBWithMessage:@"已收藏"];

        }else
        {
            sender.image = [UIImage imageNamed:@"文章详情收藏"];
            [WYAShowMessageView showToastBWithMessage:@"取消收藏"];

        }
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
@end
