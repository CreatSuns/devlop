//
//  WYALocalVideoVC.m
//  WYA_Project
//
//  Created by 李世航 on 2018/5/23.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYALocalVideoVC.h"
#import "WYAVideoControlView.h"
@interface WYALocalVideoVC ()<ZFPlayerDelegate, WYAVideoCoverViewControlDelegate>

@property (nonatomic, strong) ZFPlayerView * playerView;

@property (nonatomic, strong) ZFPlayerModel * playerModel;

@property (nonatomic, strong) WYAVideoControlView * controlView;

@end

@implementation WYALocalVideoVC

- (WYAVideoControlView *)controlView{
    if (!_controlView) {
        _controlView = [[WYAVideoControlView alloc]init];
        _controlView.videoCoverViewControlDelegate = self;
    }
    return _controlView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.playerView = [[ZFPlayerView alloc]init];
    self.playerView.backgroundColor = [UIColor WYAJHBlackTextColor];
    self.playerView.hasPreviewView = YES;
//    self.playerView.fullScreenPlay = YES;
//    self.playerView.playerPushedOrPresented = YES;
    [self.view addSubview:self.playerView];
    
    self.playerModel = [[ZFPlayerModel alloc]init];
    self.playerModel.placeholderImageURLString = [self.placeholdImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    self.playerModel.fatherView = self.view;
    NSURL * localUrl = [NSURL fileURLWithPath:[self.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    self.playerModel.videoURL = localUrl;
    self.playerView.disablePanGesture = NO;
    self.controlView.likeButton.hidden = YES;
    self.controlView.downLoadBtn.hidden = YES;
    self.controlView.playButton.selected = YES;
    self.controlView.learnView.hidden = YES;
    self.controlView.fullScreenBtn.enabled = YES;
    self.controlView.needSlider = YES;
    [self.playerView playerControlView:self.controlView playerModel:self.playerModel];
    
    self.playerView.delegate = self;
    [self.playerView autoPlayTheVideo];
    
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)zf_playerBackAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 视频暂停
 */
- (void)zf_playerVideoStop{
    self.controlView.playButton.hidden = NO;
    self.controlView.playButton.alpha = 1;
    self.controlView.playButton.selected = YES;
}

/** 控制层即将显示 */
- (void)zf_playerControlViewWillShow:(UIView *)controlView isFullscreen:(BOOL)fullscreen{
    self.controlView.playButton.hidden = NO;
}
/** 控制层即将隐藏 */
- (void)zf_playerControlViewWillHidden:(UIView *)controlView isFullscreen:(BOOL)fullscreen{
    self.controlView.playButton.hidden = YES;
}

- (void)videoPlayButtonClick:(UIButton *)sender Progress:(NSString *)progress{
    if (sender.selected) {
        [self.playerView play];
    }else{
        [self.playerView pause];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.playerView = nil;
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
