//
//  WYACourseCatalogHeadView.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/13.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAChooseDownloadHeadView.h"

@interface WYAChooseDownloadHeadView()

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIImageView *arrowImageView;

@end

@implementation WYAChooseDownloadHeadView

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor WYAJHCourseCatalogCellTextColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

- (UIImageView *)arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]init];
        _arrowImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _arrowImageView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent)];
        
        [self.contentView addGestureRecognizer:tapGestureRecognizer];
        
        self.contentView.backgroundColor = [UIColor WYAJHLightGreyColor];
        [self.contentView addSubview:self.titleLabel];
        [self.arrowImageView sizeToFit];
        [self.contentView addSubview:self.arrowImageView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(12);
        make.top.bottom.mas_equalTo(self.contentView);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).with.offset(-10);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_lessThanOrEqualTo(20);
        make.height.mas_lessThanOrEqualTo(20);
    }];
}

#pragma mark Action
- (void)tapEvent
{
    self.model.flag = !self.model.flag;
    if (!self.model.flag) {
        
        self.arrowImageView.image = [UIImage imageNamed:@"down_black_icon"];
        
    }else{
        self.arrowImageView.image = [UIImage imageNamed:@"up_black_icon"];
        
        //            self.arrowImageView.transform = CGAffineTransformMakeScale(0.98, 0.98);
    }
    
    if (self.HeaderClickedBack) {
        
        self.HeaderClickedBack(self.model.flag);
    }
    
}

#pragma mark Setter
- (void)setModel:(WYAChooseGroupModel *)model{
    _model = model;
    if (_model) {
        
        self.titleLabel.text = _model.group_title;
        if (_model.flag) {
            self.arrowImageView.image = [UIImage imageNamed:@"up_black_icon"];
        }else{
            self.arrowImageView.image = [UIImage imageNamed:@"down_black_icon"];
        }
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
