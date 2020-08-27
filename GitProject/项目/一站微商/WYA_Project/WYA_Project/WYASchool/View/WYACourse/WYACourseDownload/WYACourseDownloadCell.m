//
//  WYACourseDownloadCell.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/14.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYACourseDownloadCell.h"
#import "WYACourseDownloadModel.h"
#import "WYALocalDownloadModel.h"
@interface WYACourseDownloadCell ()

@property (nonatomic, strong) UIImageView * fileIcon;

@property (nonatomic, strong) UILabel * fileNameLabel;

@end

@implementation WYACourseDownloadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (UIImageView *)fileIcon{
    if (!_fileIcon) {
        _fileIcon = [[UIImageView alloc]init];
    }
    return _fileIcon;
}

- (UILabel *)fileNameLabel{
    if (!_fileNameLabel) {
        _fileNameLabel = [[UILabel alloc]init];
        _fileNameLabel.textColor = [UIColor WYAJHCourseCatalogCellTextColor];
        _fileNameLabel.font = [UIFont systemFontOfSize:14];
        _fileNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _fileNameLabel;
}

- (UIImageView *)downloadIcon{
    if (!_downloadIcon) {
        _downloadIcon = [[UIImageView alloc]init];
    }
    return _downloadIcon;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.separatorInset = UIEdgeInsetsMake(0, 10.f, 0, 10.f);

        [self.contentView addSubview:self.fileIcon];
        [self.contentView addSubview:self.fileNameLabel];
        [self.contentView addSubview:self.downloadIcon];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.fileIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(21.f);
        make.size.mas_equalTo(CGSizeMake(16.f, 14.f));
    }];
    
    [self.fileNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(16.f);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(-13.f);
        make.left.mas_equalTo(self.fileIcon.mas_right).mas_equalTo(10.f);
    }];
    
    [self.downloadIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-11.f);
        make.size.mas_equalTo(CGSizeMake(19.f, 19.f));
        make.left.mas_equalTo(self.fileNameLabel.mas_right);
    }];
}

- (void)setModel:(WYACourseDownloadModel *)model{
    if (model) {
        
        _model = model;
        NSString * string = [model.courseware_url pathExtension];
        NSLog(@"string==%@",string);
        if ([string isEqualToString:@"docx"] || [string isEqualToString:@"doc"]) {
            self.fileIcon.image = [UIImage imageNamed:@"word"];
        }else if ([string isEqualToString:@"pdf"]) {
            self.fileIcon.image = [UIImage imageNamed:@"PPT"];
        }else if ([string isEqualToString:@"xlsx"]||[string isEqualToString:@"xls"]) {
            self.fileIcon.image = [UIImage imageNamed:@"excel"];
        }
        
        JQFMDB * fmdb = [JQFMDB shareDatabase:FileDownload_DataBase path:[NSString downloadFilePath]];
        NSArray * arr = [fmdb jq_lookupTable:self.name dicOrModel:[WYALocalDownloadModel class] whereFormat:nil];
        for (WYALocalDownloadModel * localModel in arr) {
            if ([localModel.fileNumber isEqualToString:@"3"] && [localModel.fileID isEqualToString:model.chapter_id]) {
                
                self.downloadIcon.image = [UIImage imageNamed:@"完成"];
            }
        }
        self.fileNameLabel.text = model.courseware_title;
        
        
        if (model.courseware_title) {
            NSString * filePath = [[NSString downloadVideoPath] stringByAppendingPathComponent:model.courseware_title];
            NSFileManager * fileManager = [NSFileManager defaultManager];
            if ([fileManager fileExistsAtPath:filePath]){
                self.downloadIcon.image = [UIImage imageNamed:@"完成"];
                model.flag = YES;
                return;
            }
        }
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
