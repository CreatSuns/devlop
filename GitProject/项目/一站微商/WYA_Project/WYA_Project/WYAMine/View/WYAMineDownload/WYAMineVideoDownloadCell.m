//
//  WYAMineVideoDownloadCell.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/23.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMineVideoDownloadCell.h"
#import "WYATableNameModel.h"
#import "WYALocalDownloadModel.h"
@interface WYAMineVideoDownloadCell ()

@property (nonatomic, strong) JQFMDB * fmdb;

/**
 图片
 */
@property (nonatomic, strong) UIImageView * imgView;

/**
 标题
 */
@property (nonatomic, strong) UILabel * titleLabel;

/**
 个数
 */
@property (nonatomic, strong) UILabel * countLabel;

@property (nonatomic, strong) UIImageView * rightImageView;

@property (nonatomic, strong) UIView * line;

@end

@implementation WYAMineVideoDownloadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (JQFMDB *)fmdb{
    if (!_fmdb) {
        _fmdb = [JQFMDB shareDatabase:FileDownload_DataBase path:[NSString downloadFilePath]];
    }
    return _fmdb;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imgView = [[UIImageView alloc]init];
        self.imgView.layer.cornerRadius = 5.0f;
        self.imgView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.imgView];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textColor = [UIColor WYAJHBlackTextColor];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.titleLabel];
        
        self.countLabel = [[UILabel alloc]init];
        self.countLabel.font = [UIFont systemFontOfSize:10];
        self.countLabel.textColor = [UIColor WYAJHSegNoSelectColor];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.countLabel];
        
        self.rightImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Right arrow"]];
        [self.contentView addSubview:self.rightImageView];
        
        self.line = [[UIView alloc]init];
        self.line.backgroundColor = [UIColor WYAJHDarkgGreyColor];
        [self.contentView addSubview:self.line];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(15.f);
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(13.f);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(-13.f);
        make.width.mas_equalTo(134.f);
        make.height.mas_lessThanOrEqualTo(81.f);
    }];
    
    [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).mas_equalTo(-10.f);
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_top).with.offset(2.f);
        make.left.mas_equalTo(self.imgView.mas_right).with.offset(8.f);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-27.f);
    }];
    
    [self.countLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.bottom.mas_equalTo(self.imgView.mas_bottom).with.offset(-3.f);
        make.right.mas_equalTo(self.titleLabel.mas_right);
    }];
    
    [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imgView.mas_left);
        make.right.mas_equalTo(self.titleLabel.mas_right);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)setModel:(WYATableNameModel *)model{
    if (model) {
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:[checkString(model.course_image_url) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"notSearch"]];
        self.titleLabel.text = checkString(model.course_title);
        
        NSArray * arr = [self.fmdb jq_lookupTable:model.tableName dicOrModel:[WYALocalDownloadModel class] whereFormat:@"WHERE fileState = 4"];
        
        unsigned long long size = 0;
        for (WYALocalDownloadModel * model in arr) {

            size += [model.fileLocalurl fileSize];
        }
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
        self.countLabel.text = [NSString stringWithFormat:@"%ld个|%@",arr.count,sizeText];
        [self layoutIfNeeded];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
