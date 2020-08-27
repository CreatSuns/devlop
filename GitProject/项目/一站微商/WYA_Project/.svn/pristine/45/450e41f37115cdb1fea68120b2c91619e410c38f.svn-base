//
//  WYAChooseDownloadCell.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/23.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAChooseDownloadCell.h"
#import "WYALocalDownloadModel.h"
#import "SODownloader+WYAVideoDownload.h"

static void * kStateContext = &kStateContext;

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
        _downloadStateLabel.font = [UIFont systemFontOfSize:10];
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
        make.width.mas_lessThanOrEqualTo(60.f);
    }];
}

#pragma mark Private method
- (void)updateState:(SODownloadState)state {
    switch (state) {
        case SODownloadStateWait:
            self.stateString = @"等待中";
            break;
        case SODownloadStatePaused:
            self.stateString = @"已暂停";
            break;
        case SODownloadStateError:
            self.stateString = @"失败";
            break;
        case SODownloadStateLoading:
            self.stateString = @"下载中";
            break;
        case SODownloadStateProcess:
            self.stateString = @"处理中";
            break;
        case SODownloadStateComplete:
            self.stateString = @"已下载";
            break;
        default:
            
            break;
    }
}

#pragma mark KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (context == kStateContext) {
        SODownloadState oldState = [change[NSKeyValueChangeOldKey]integerValue];
        SODownloadState newState = [change[NSKeyValueChangeNewKey]integerValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateState:newState];
            
        });
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark Setter
- (void)setModel:(WYAChooseChapterModel *)model{
    _model = model;

    self.titleLabel.text = checkString(_model.chapter_title);
    if (_model.can_download) {
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }else{
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor WYAJHLightGreyColor];
        self.contentView.userInteractionEnabled = NO;
    }
    
    [self layoutIfNeeded];
}

- (void)setDownArray:(NSArray *)downArray{
    _downArray = downArray;
    
    for (WYALocalDownloadModel * loModel in downArray) {
        if ([loModel.fileID isEqualToString:_model.chapter_id] && [loModel.fileNumber isEqualToString:@"2"]) {
            self.localModel = loModel;
        }else{
            self.localModel = nil;
        }
    }
}

- (void)setLocalArray:(NSArray *)localArray{
    if (localArray) {
        for (WYALocalDownloadModel * localModel in localArray) {
            if ([_model.chapter_id isEqualToString:localModel.fileID] && [localModel.fileNumber isEqualToString:@"2"]) {
                switch (localModel.fileState) {
                    case 0:
                        self.isDeleteVideo = YES;
                        break;
                    case 1:
                        self.stateString = @"等待下载";
                        break;
                    case 2:
                        
                        self.stateString = @"下载中";
                        break;
                    case 3:
                        
                        self.stateString = @"暂停下载";
                        break;
                    case 4:
                        
                        self.stateString = @"已下载";
                        
                        break;
                    case 5:
                        
                        self.stateString = @"下载失败";
                        [[SODownloader videoDownloader] cancelItem:localModel];
                        break;
                    default:
                        break;
                }
            }
        }
    }
}

- (void)setStateString:(NSString *)stateString{
    _stateString = stateString;
    if (stateString) {
        self.downloadStateLabel.text = stateString;
        if ([stateString isEqualToString:@"下载失败"] || [stateString isEqualToString:@"失败"]) {
            self.fileTypeLabel.textColor = [UIColor WYAJHCourseCatalogCellTextColor];
            self.fileTypeLabel.layer.borderColor = [UIColor WYAJHCourseCatalogCellTextColor].CGColor;
            self.titleLabel.textColor = [UIColor WYAJHCourseCatalogCellTextColor];
            self.downloadStateLabel.textColor = [UIColor WYAJHCourseCatalogCellTextColor];
            self.selectionStyle = UITableViewCellSelectionStyleGray;
            self.contentView.userInteractionEnabled = YES;
        }else{
            self.chooseButton.selected = YES;
            self.fileTypeLabel.textColor = [UIColor WYAJHStoneGrayColor];
            self.fileTypeLabel.layer.borderColor = [UIColor WYAJHStoneGrayColor].CGColor;
            self.titleLabel.textColor = [UIColor WYAJHStoneGrayColor];
            self.downloadStateLabel.textColor = [UIColor WYAJHStoneGrayColor];
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            self.contentView.userInteractionEnabled = NO;
        }
        
        
        
    }
}

- (void)setIsDeleteVideo:(BOOL)isDeleteVideo{
    if (isDeleteVideo == YES) {
        self.downloadStateLabel.text = nil;
        self.chooseButton.selected = NO;
        self.fileTypeLabel.textColor = [UIColor WYAJHCourseCatalogCellTextColor];
        self.fileTypeLabel.layer.borderColor = [UIColor WYAJHCourseCatalogCellTextColor].CGColor;
        self.titleLabel.textColor = [UIColor WYAJHCourseCatalogCellTextColor];
        self.downloadStateLabel.textColor = [UIColor WYAJHCourseCatalogCellTextColor];
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.contentView.userInteractionEnabled = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}



@end
