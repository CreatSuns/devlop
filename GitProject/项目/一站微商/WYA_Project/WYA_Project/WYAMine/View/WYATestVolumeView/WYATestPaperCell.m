//
//  WYATestPaperCell.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/18.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYATestPaperCell.h"
#import "WYATestPaperModel.h"

@interface WYATestPaperCell ()

/**
 图片
 */
@property (nonatomic, strong)UIImageView * chapterImageView;

/**
 考试人员
 */
@property (nonatomic, strong)UILabel * userNameLabel;

/**
 分数
 */
@property (nonatomic, strong)UILabel * scoreLabel;

@end

@implementation WYATestPaperCell

-(UIImageView *)chapterImageView{
    if (!_chapterImageView) {
        _chapterImageView = [[UIImageView alloc]init];
        _chapterImageView.image = [UIImage imageNamed:@"paperImg"];
//        _chapterImageView.backgroundColor = [UIColor redColor];
    }
    return _chapterImageView;
}

- (UILabel *)userNameLabel{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc]init];
        _userNameLabel.backgroundColor = [UIColor clearColor];
        _userNameLabel.font = [UIFont systemFontOfSize:14*Size_ratio];
        _userNameLabel.textColor = [UIColor whiteColor];
        _userNameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _userNameLabel;
}

- (UILabel *)chapterNumberLabel{
    if (!_chapterNumberLabel) {
        _chapterNumberLabel = [[UILabel alloc]init];
        _chapterNumberLabel.font = [UIFont systemFontOfSize:15*Size_ratio];
        _chapterNumberLabel.textColor = [UIColor WYAJHBlackTextColor];
        _chapterNumberLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _chapterNumberLabel;
}

- (UILabel *)topicNumberLabel{
    if (!_topicNumberLabel) {
        _topicNumberLabel = [[UILabel alloc]init];
        _topicNumberLabel.font = [UIFont systemFontOfSize:13*Size_ratio];
        _topicNumberLabel.textColor = [UIColor WYAJHgrayTextColor];
        _topicNumberLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _topicNumberLabel;
}

- (UILabel *)scoreLabel{
    if (!_scoreLabel) {
        _scoreLabel = [[UILabel alloc]init];
        _scoreLabel.font = [UIFont systemFontOfSize:11*Size_ratio];
        _scoreLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _scoreLabel;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.chapterImageView];
        [self.chapterImageView addSubview:self.userNameLabel];
        [self.contentView addSubview:self.chapterNumberLabel];
        [self.contentView addSubview:self.topicNumberLabel];
        [self.contentView addSubview:self.scoreLabel];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.contentView.layer.contentsScale = [UIScreen mainScreen].scale; 
        
        self.contentView.layer.shadowOpacity = 0.75f*Size_ratio;
        
        self.contentView.layer.shadowRadius = 4.0f*Size_ratio;
        
        self.contentView.layer.shadowOffset = CGSizeMake(0,0);
        
        self.contentView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
        
        //设置缓存
        
        self.contentView.layer.shouldRasterize = YES;
        
        //设置抗锯齿边缘
        
        self.contentView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.chapterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.contentView);
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(self.chapterImageView);
    }];
    
    [self.chapterNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(6.f*Size_ratio);
        make.top.mas_equalTo(self.chapterImageView.mas_bottom).with.offset(11.f*Size_ratio);
    }];
    
    [self.topicNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.chapterNumberLabel.mas_left);
        make.top.mas_equalTo(self.chapterNumberLabel.mas_bottom).with.offset(9.f*Size_ratio);
    }];
    
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.topicNumberLabel.mas_left);
        make.top.mas_equalTo(self.topicNumberLabel.mas_bottom).with.offset(11.f*Size_ratio);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(-13.f*Size_ratio);
    }];
}

- (void)setModel:(WYATestPaperUserModel *)model{
    if (model) {
//        self.chapterImageView sd_setImageWithURL:[NSURL URLWithString:[checkString(model.)]] placeholderImage:<#(UIImage *)#>
        self.userNameLabel.text = checkString(model.contact);
        
        self.scoreLabel.text = checkString(model.score);
    }
}
- (void)setMainModel:(WYALevelPaperListModel *)mainModel
{
    if (mainModel) {
        _mainModel = mainModel;
        self.userNameLabel.text = _mainModel.contact;
        
        self.scoreLabel.text = _mainModel.score;
//        self.scoreLabel.numberOfLines = 0;
        self.scoreLabel.textColor = [UIColor WYAJHBaseRedColor];
    }
}
- (void)setPaperMainModel:(WYAMainPaperListModel *)paperMainModel
{
    if (paperMainModel) {
        _paperMainModel = paperMainModel;
        self.scoreLabel.text = _paperMainModel.score;
        self.scoreLabel.textColor = [UIColor WYAJHBaseRedColor];
    }
}
@end
