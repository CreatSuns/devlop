//
//  WYANowDownloadEditView.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/27.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYANowDownloadEditView.h"

@interface WYANowDownloadEditView ()



@end

@implementation WYANowDownloadEditView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIButton *)allSelectButton{
    if (!_allSelectButton) {
        _allSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allSelectButton setTitle:@"全选" forState:UIControlStateNormal];
        [_allSelectButton setTitle:@"取消全选" forState:UIControlStateSelected];
        [_allSelectButton setTitleColor:[UIColor WYAJHLightBlackTextColor] forState:UIControlStateNormal];
        [_allSelectButton addTarget:self action:@selector(allSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allSelectButton;
}

- (UIButton *)deleteButton{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor WYAJHBaseRedColor] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor WYAJHLightGreyColor];
        [self addSubview:self.allSelectButton];
        [self addSubview:self.deleteButton];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.allSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self);
        make.width.mas_equalTo(ScreenWidth/2);
    }];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(self);
        make.width.mas_equalTo(ScreenWidth/2);
    }];
}

- (void)allSelectAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(allSeletedWithSeleted:)]) {
        [self.delegate allSeletedWithSeleted:sender.selected];
    }
}

- (void)deleteAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteSeleted)]) {
        [self.delegate deleteSeleted];
    }
}

@end
