//
//  WYAMineArticleDownloadCell.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/23.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMineArticleDownloadCell.h"
#import "WYAMineDownloadModel.h"
@interface WYAMineArticleDownloadCell ()

@property (nonatomic, strong) UIImageView * fileTypeImageView;

@property (nonatomic, strong) UILabel * titleLabel;

@property (nonatomic, strong) UILabel * sizeLabel;

@property (nonatomic, strong) UIImageView * rightArrowImageView;
@property (nonatomic, strong) UIView * line;
@end

@implementation WYAMineArticleDownloadCell

- (UIImageView *)fileTypeImageView{
    if (!_fileTypeImageView) {
        _fileTypeImageView = [[UIImageView alloc]init];
    }
    return _fileTypeImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor WYAJHCourseCatalogCellTextColor];
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}



- (UILabel *)sizeLabel{
    if (!_sizeLabel) {
        _sizeLabel = [[UILabel alloc]init];
        _sizeLabel.textColor = [UIColor WYAJHSegNoSelectColor];
        _sizeLabel.font = [UIFont systemFontOfSize:10.f];
        _sizeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _sizeLabel;
}

- (UIImageView *)rightArrowImageView{
    if (!_rightArrowImageView) {
        _rightArrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Right arrow"]];
    }
    return _rightArrowImageView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.fileTypeImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.sizeLabel];
        [self.contentView addSubview:self.rightArrowImageView];
        
        self.line = [[UIView alloc]init];
        self.line.backgroundColor = [UIColor WYAJHDarkgGreyColor];
        [self.contentView addSubview:self.line];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.fileTypeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.contentView.mas_right).with.offset(50.f);
        make.size.mas_equalTo(CGSizeMake(18.f, 18.f));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.fileTypeImageView.mas_right).with.offset(9.f * Size_ratio);
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(15.f);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(-12.f);
    }];
    
    [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.fileTypeImageView.mas_centerY);
        make.right.mas_equalTo(self.rightArrowImageView.mas_left).with.offset(-5.f);
        make.left.mas_equalTo(self.titleLabel.mas_right);
    }];
    
    [self.rightArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-10.f);
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(16.f, 16.f));
    }];
    
    [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(15.f);
        make.right.mas_equalTo(self.titleLabel.mas_right);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
}

- (void)setModel:(WYAArticleDownloadModel *)model{
    if (model) {
        //[self.fileTypeImageView sd_setImageWithURL:[NSURL URLWithString:[checkString(model.)]] placeholderImage:<#(UIImage *)#>]
        self.titleLabel.text = checkString(model.title);
        self.sizeLabel.text = checkString(model.size);
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
