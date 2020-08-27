//
//  WYAChooseDownloadCell.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/23.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAChooseDownloadCell.h"

@interface WYAChooseDownloadCell ()



@property (nonatomic, strong) UILabel * fileTypeLabel;

@property (nonatomic, strong) UILabel * titleLabel;

@property (nonatomic, strong) UILabel * downloadStateLabel;

@end

@implementation WYAChooseDownloadCell

- (UIButton *)chooseButton{
    if (!_chooseButton) {
        _chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _chooseButton.selected = NO;
        [_chooseButton setImage:[UIImage imageNamed:@"box_normal"] forState:UIControlStateNormal];
        [_chooseButton setImage:[UIImage imageNamed:@"box_seleted"] forState:UIControlStateSelected];

//        [_chooseButton addTarget:self action:@selector(chooserClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseButton;
}

- (UILabel *)fileTypeLabel{
    if (!_fileTypeLabel) {
        _fileTypeLabel = [[UILabel alloc]init];
        _fileTypeLabel.text = @"视频";
        _fileTypeLabel.font = [UIFont systemFontOfSize:8];
        _fileTypeLabel.textColor = [UIColor WYAJHCourseCatalogCellTextColor];
        _fileTypeLabel.textAlignment = NSTextAlignmentCenter;
        _fileTypeLabel.layer.cornerRadius = 3;
        _fileTypeLabel.layer.masksToBounds = YES;
        _fileTypeLabel.layer.borderWidth = 0.5;
        _fileTypeLabel.layer.borderColor = [UIColor WYAJHCourseCatalogCellTextColor].CGColor;
    }
    return _fileTypeLabel;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor WYAJHCourseCatalogCellTextColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UILabel *)downloadStateLabel{
    if (!_downloadStateLabel) {
        _downloadStateLabel = [[UILabel alloc]init];
        _downloadStateLabel.font = [UIFont systemFontOfSize:14];
        _downloadStateLabel.textColor = [UIColor WYAJHCourseCatalogCellTextColor];
    }
    return _downloadStateLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.chooseButton];
        [self.contentView addSubview:self.fileTypeLabel];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.downloadStateLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.chooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(14.f);
        make.size.mas_equalTo(CGSizeMake(16.f, 16.f));
    }];
    
    [self.fileTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.chooseButton.mas_right).with.offset(18.f);
        make.size.mas_equalTo(CGSizeMake(25.f, 15.f));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.fileTypeLabel.mas_right).with.offset(12.f);
        
    }];
    [self.downloadStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.titleLabel.mas_bottom);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-11.f);
        make.left.mas_equalTo(self.titleLabel.mas_right);
        make.width.mas_equalTo(40.f);
    }];
}

- (void)setupCell
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)loadContent
{
    WYAChooseChapterModel * model = (WYAChooseChapterModel *)self.data;
    self.titleLabel.text = checkString(model.chapter_title);
    
    [self layoutIfNeeded];
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:12 options:UIViewAnimationOptionCurveLinear animations:^{
        if (highlighted) {
            self.textLabel.transform = CGAffineTransformMakeScale(0.98, 0.98);
        } else {
            self.textLabel.transform = CGAffineTransformIdentity;
        }
    } completion:nil];
}

- (void)chooserClick:(UIButton *)sender{


}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (self.downloadSelector) {
        self.downloadSelector((WYAChooseChapterModel *)self.data);
    }
}

@end
