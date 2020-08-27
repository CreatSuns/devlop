//
//  WYACourseCatalogFootView.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/14.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYACourseCatalogFootView.h"
#import "WYACourseCatalogModel.h"

@interface WYACourseCatalogFootView ()

@property (nonatomic, strong) UIImageView * paperImageView;

@property (nonatomic, strong) UILabel * paperTitleLabel;

@property (nonatomic, strong) UILabel * paperPointsLabel;

@end

@implementation WYACourseCatalogFootView

- (UIImageView *)paperImageView{
    if (!_paperImageView) {
        _paperImageView = [[UIImageView alloc]init];
    }
    return _paperImageView;
}

- (UILabel *)paperTitleLabel{
    if (!_paperTitleLabel) {
        _paperTitleLabel = [[UILabel alloc]init];
        _paperTitleLabel.font = [UIFont systemFontOfSize:12];
        _paperTitleLabel.textColor = [UIColor WYAJHTabBarNormalColor];
    }
    return _paperTitleLabel;
}

- (UILabel *)paperPointsLabel{
    if (!_paperPointsLabel) {
        _paperPointsLabel = [[UILabel alloc]init];
        _paperPointsLabel.textColor = [UIColor WYAJHBaseRedColor];
        _paperPointsLabel.font = [UIFont systemFontOfSize:10];
    }
    return _paperPointsLabel;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent)];
        
        [self.contentView addGestureRecognizer:tapGestureRecognizer];
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.paperImageView];
        [self.contentView addSubview:self.paperTitleLabel];
        [self.contentView addSubview:self.paperPointsLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.paperImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(20.f);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    [self.paperTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.paperImageView.mas_right).with.offset(4.f);
    }];
    
    [self.paperPointsLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-9.f);
    }];
}

-(void)setModel:(WYACourseCatalogGroupPaperModel *)model{
    if (model) {
        _model = model;
        self.paperTitleLabel.text = checkString(_model.paper_title);
        if (model.points) {
            self.paperPointsLabel.text = [NSString stringWithFormat:@"%@分",_model.points];
            self.paperImageView.image = [UIImage imageNamed:@"考试成绩"];
        }
        
        [self layoutIfNeeded];
    }
}

- (void)tapEvent{
    if (self.model.points) {
        if (self.testPaper) {
            self.testPaper(GroupWatchTestPaper, self.model.paper_id);
        }
        
    }else{
        if (self.testPaper) {
            self.testPaper(GroupNeedTestPaper, self.model.paper_id);
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
