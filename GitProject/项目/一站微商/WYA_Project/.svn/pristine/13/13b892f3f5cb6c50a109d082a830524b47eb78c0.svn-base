//
//  WYAMineInfoCell.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/20.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMineInfoCell.h"

@interface WYAMineInfoCell ()

@property (nonatomic, strong) UILabel * titleLabel;



@property (nonatomic, strong) UILabel * userInfoLabel;


@end

@implementation WYAMineInfoCell

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor WYAJHLightBlackTextColor];
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.layer.cornerRadius = 19.f;
        _imgView.layer.masksToBounds = YES;
    }
    return _imgView;
}

- (UILabel *)userInfoLabel{
    if (!_userInfoLabel) {
        _userInfoLabel = [[UILabel alloc]init];
        _userInfoLabel.textColor = [UIColor WYAJHSettingGrayTextColor];
        _userInfoLabel.font = [UIFont systemFontOfSize:12.f];
        _userInfoLabel.textAlignment = NSTextAlignmentRight;
    }
    return _userInfoLabel;
}

- (UIImageView *)rightArrowImageView{
    if (!_rightArrowImageView) {
        _rightArrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Right arrow"]];
    }
    return _rightArrowImageView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.userInfoLabel];
        [self.contentView addSubview:self.rightArrowImageView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(11.f * Size_ratio);
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(16.f);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(-16.f);
    }];
    
    [self.rightArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-10.f);
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(16.f, 16.f));
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
        make.right.mas_equalTo(self.rightArrowImageView.mas_left).with.offset(-5.f);
        make.size.mas_equalTo(CGSizeMake(38.f, 38.f));
        make.left.mas_equalTo(self.titleLabel.mas_right).with.offset(50.f);
    }];
    
    [self.userInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
        make.right.mas_equalTo(self.rightArrowImageView.mas_left).with.offset(-5.f);
        make.left.mas_equalTo(self.titleLabel.mas_right);
    }];
    
}

-(void)setModel:(WYAMineInfoModel *)model{
    if (model) {
        self.titleLabel.text = model.title;
        if (model.headImageString) {
            self.userInfoLabel.hidden = YES;
            [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.headImageString] placeholderImage:nil];
        }else{
            self.imgView.hidden = YES;
            self.userInfoLabel.text = model.subtitle;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
