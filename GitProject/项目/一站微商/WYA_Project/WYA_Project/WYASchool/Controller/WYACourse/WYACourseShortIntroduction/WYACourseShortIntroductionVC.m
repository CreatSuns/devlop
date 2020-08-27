//
//  WYACourseShortIntroductionV.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/5/2.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYACourseShortIntroductionVC.h"
#import "WYACourseShoreIntroductionHeaderView.h"
#import "UIView+WYALayout.h"

@interface WYACourseShortIntroductionVC ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>

@property(nonatomic, strong)UITableView * tableView;

@property(nonatomic, strong)WYACourseShoreIntroductionHeaderView * headerView;

@property(nonatomic, strong)UIWebView * webView;

@end

static CGFloat webViewHeight;

@implementation WYACourseShortIntroductionVC

- (void)dealloc
{
    self.webView.delegate = nil;
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    webViewHeight = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = self.headerView;
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ====== creatUI
- (UITableView * )tableView
{
    if (_tableView == nil) {
        CGFloat playerViewY = WYAiPhoneX ? WYAStatusBarHeight : 0;
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - WYABottomHeight - playerViewY - 210*Size_ratio - 40)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
- (WYACourseShoreIntroductionHeaderView *)headerView
{
    if (_headerView == nil) {
        CGFloat norWidth = ScreenWidth-16*Size_ratio;
        CGFloat titleHeight = [WYAJHTools heightOfConttent:checkString(_model.course_title) fontSize:16*Size_ratio maxWidth:norWidth];
        CGFloat introductionHeight = [WYAJHTools heightOfConttent:checkString(_model.introduction) fontSize:15*Size_ratio maxWidth:295*Size_ratio];
        CGFloat height = 130*Size_ratio + titleHeight + introductionHeight;
        _headerView = [[WYACourseShoreIntroductionHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, height)];
        _headerView.model = self.model;
    }
    return _headerView;
}
- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.tableView.cmam_height-self.headerView.cmam_height)];
        _webView.scrollView.scrollEnabled = NO;
        _webView.delegate = self;
        [_webView loadHTMLString:self.model.cDescription.html baseURL:nil];
        [_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _webView;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell addSubview:self.webView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return webViewHeight;
}
// 监听scrolleView的contentSize修改webView的实际高度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGSize fitSize = [self.webView sizeThatFits:CGSizeZero];
        webViewHeight = fitSize.height;
        self.webView.cmam_height = webViewHeight;
        [self.tableView reloadData];
    }
}
// 修改webView内容文字大小
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '80%'"];
}


@end
