//
//  WYAChooseDownloadBottomView.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/24.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAChooseDownloadBottomView.h"
#import <AFNetworkReachabilityManager.h>

@interface WYAChooseDownloadBottomView ()

@end

@implementation WYAChooseDownloadBottomView

- (UIButton *)chooseButton{
    if (!_chooseButton) {
        _chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _chooseButton.selected = NO;
        [_chooseButton setImage:[UIImage imageNamed:@"box_normal"] forState:UIControlStateNormal];
        [_chooseButton setImage:[UIImage imageNamed:@"box_seleted"] forState:UIControlStateSelected];
        [_chooseButton setTitle:@"全选" forState:UIControlStateNormal];
        [_chooseButton setTitleColor:[UIColor WYAJHLightBlackTextColor] forState:UIControlStateNormal];
        _chooseButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [_chooseButton addTarget:self action:@selector(chooserClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseButton;
}

- (UIButton *)downloadButton{
    if (!_downloadButton) {
        _downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_downloadButton setTitle:@"确定下载" forState:UIControlStateNormal];
        [_downloadButton setBackgroundColor:[UIColor WYAJHStoneGrayColor]];
        _downloadButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [_downloadButton addTarget:self action:@selector(downloadButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _downloadButton.enabled = NO;
    }
    return _downloadButton;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor WYAJHLightGreyColor];
        [self addSubview:self.chooseButton];
        [self addSubview:self.downloadButton];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.chooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self.mas_left).with.offset(5.f);
        make.width.mas_greaterThanOrEqualTo(70.f);
    }];
    
    [self.downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(self);
        make.width.mas_equalTo(109.f);
    }];
}

#pragma mark Action
- (void)chooserClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(seletedAllAction)]) {
        [self.delegate seletedAllAction];
    }
}

- (void)downloadButtonClick:(UIButton *)sender{
    AFNetworkReachabilityManager * manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown) {
            
        }else if (status == AFNetworkReachabilityStatusNotReachable) {
            
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
            NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
            
            if ([ud boolForKey:AllowDataConnectionAndDownload]) {
                [self downloadAction];
            }else{
                self.showAlert();
            }
        }else if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
            [self downloadAction];
        }
    }];
    // 开始监控
    [manager startMonitoring];
}

- (void)downloadAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(startDownload)]) {
        [self.delegate startDownload];
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
