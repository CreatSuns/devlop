//
//  WYAFinishDownloadCell.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/27.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAFinishDownloadCell.h"
#import "WYALocalDownloadModel.h"

@interface WYAFinishDownloadCell ()



@property (nonatomic, strong) UIImageView * imgView;

@property (nonatomic, strong) UILabel * titleLabel;

@property (nonatomic, strong) UILabel * fileSizeLabel;

@property (nonatomic, strong) WYALocalDownloadModel * localModel;

@end

@implementation WYAFinishDownloadCell

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setImage:[UIImage imageNamed:@"box_normal"] forState:UIControlStateNormal];
        [_button setImage:[UIImage imageNamed:@"box_seleted"] forState:UIControlStateSelected];
        _button.selected = NO;
        _button.hidden = YES;
        [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
    }
    return _imgView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor WYAJHCourseCatalogCellTextColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UILabel *)fileSizeLabel{
    if (!_fileSizeLabel) {
        _fileSizeLabel = [[UILabel alloc]init];
        _fileSizeLabel.textColor = [UIColor WYAJHSegNoSelectColor];
        _fileSizeLabel.font = [UIFont systemFontOfSize:10.f];
        _fileSizeLabel.text = @"未知大小";
    }
    return _fileSizeLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.button];
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.fileSizeLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSUserDefaults * us = [NSUserDefaults standardUserDefaults];
    BOOL key = [us boolForKey:@"finishEdit"];
    if (key == NO) {
        self.button.hidden = YES;
    }else{
        self.button.hidden = NO;
    }
    [self.button mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(14.f);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
    
    [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        if (key == NO) {
            make.left.mas_equalTo(self.contentView.mas_left).with.offset(10.f);
        }else{
            make.left.mas_equalTo(self.button.mas_right).with.offset(15.f);
            
        }
        make.size.mas_equalTo(CGSizeMake(16.f, 16.f));
    }];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.imgView.mas_right).with.offset(9.f);
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(12.f);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(-12.f);
    }];
    
    
    [self.fileSizeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right);
        make.bottom.mas_equalTo(self.titleLabel.mas_bottom);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-14.f);
        make.width.mas_lessThanOrEqualTo(60.f);
    }];
    
    
}

- (void)setModel:(WYALocalDownloadModel *)model{
    if (model) {
        self.localModel = model;
        if ([model.fileNumber isEqualToString:VideoType]) {
            //视频图标
            self.imgView.image = [UIImage imageNamed:@"播放_black_icon"];
        }else if ([model.fileNumber isEqualToString:classType]) {
            //课件图标
            NSString * string = [model.fileUrl pathExtension];
            NSLog(@"string==%@",string);
            if ([string isEqualToString:@"docx"]) {
                self.imgView.image = [UIImage imageNamed:@"word"];
            }else if ([string isEqualToString:@"pdf"]) {
                self.imgView.image = [UIImage imageNamed:@"PPT"];
            }else if ([string isEqualToString:@"xlsx"]) {
                self.imgView.image = [UIImage imageNamed:@"excel"];
            }
        }
        self.titleLabel.text = model.videoName;
//        if ([model.fileNumber isEqualToString:@""]) {
//            <#statements#>
//        }
        unsigned long long size = 0;
        NSLog(@"fileUrl==%@",model.fileLocalurl);
        size = [model.fileLocalurl fileSize];
        NSString * sizeText;
        if (size >= pow(10, 9)) { // size >= 1GB
            sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
        } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
            sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
        } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
            sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
        } else { // 1KB > size
            sizeText = [NSString stringWithFormat:@"%zdB", size];
        }
        self.fileSizeLabel.text = [NSString stringWithFormat:@"%@",sizeText];
        [self layoutIfNeeded];
    }
}

- (void)buttonClick:(UIButton *)button{
    button.selected = !button.selected;
    if (self.buttonSelect) {
        self.buttonSelect(button.selected, self.localModel);
    }
}

//- (void)setCanEdit:(BOOL)canEdit{
//
//    if (canEdit) {
//
//        self.button.hidden = NO;
//        [self layoutIfNeeded];
//    }else{
//
//        self.button.hidden = YES;
//        [self layoutIfNeeded];
//    }
//}

- (void)setSelectCell:(BOOL)selectCell{
    if (selectCell) {
        self.button.selected = YES;
        if (self.buttonSelect) {
            self.buttonSelect(self.button.selected, self.localModel);
        }
        
    }else{
        self.button.selected = NO;
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
