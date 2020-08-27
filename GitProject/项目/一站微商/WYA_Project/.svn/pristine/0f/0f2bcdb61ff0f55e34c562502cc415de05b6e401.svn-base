//
//  WYANowDownloadCell.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/25.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYANowDownloadCell.h"
#import "WYALocalDownloadModel.h"


static void * kStateContext = &kStateContext;
static void * kProgressContext = &kProgressContext;
static void * kSpeedContext = &kSpeedContext;

@interface WYANowDownloadCell ()

@property (nonatomic, strong) UILabel * titleLabel;

@property (nonatomic, strong) UILabel * fileSizeLabel;

@property (nonatomic, strong) UIButton * button;

@property (nonatomic, strong) WYALocalDownloadModel * localModel;

@end

@implementation WYANowDownloadCell

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor WYAJHCourseCatalogCellTextColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UIProgressView *)progress{
    if (!_progress) {
        _progress = [[UIProgressView alloc]init];
        _progress.progressTintColor = [UIColor WYAJHBaseBlueColor];
        _progress.trackTintColor = [UIColor WYAJHLightGreyColor];
        _progress.progress = 0.f;
    }
    return _progress;
}

- (UILabel *)downloadSpeedLabel{
    if (!_downloadSpeedLabel) {
        _downloadSpeedLabel = [[UILabel alloc]init];
        _downloadSpeedLabel.textColor = [UIColor WYAJHSegNoSelectColor];
        _downloadSpeedLabel.font = [UIFont systemFontOfSize:10.f];
        _downloadSpeedLabel.text = @"0kb/s";
    }
    return _downloadSpeedLabel;
}

- (UILabel *)downloadNowSizeLabel{
    if (!_downloadNowSizeLabel) {
        _downloadNowSizeLabel = [[UILabel alloc]init];
        _downloadNowSizeLabel.textColor = [UIColor WYAJHSegNoSelectColor];
        _downloadNowSizeLabel.font = [UIFont systemFontOfSize:10.f];
        _downloadNowSizeLabel.text = @"0M";
        _downloadNowSizeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _downloadNowSizeLabel;
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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.button];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.progress];
        [self.contentView addSubview:self.downloadSpeedLabel];
        [self.contentView addSubview:self.downloadNowSizeLabel];
        [self.contentView addSubview:self.fileSizeLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.button mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(11.f);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];

    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (self.button.hidden) {
            make.left.mas_equalTo(self.contentView.mas_left).with.offset(10.f);
        }else{
            make.left.mas_equalTo(self.button.mas_right).with.offset(15.f);
        }
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(12.f);
        make.right.mas_equalTo(self.contentView.mas_right);
    }];
    
    [self.progress mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-11.f);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(10.f);
        make.height.mas_equalTo(6.f);
    }];
    
    [self.downloadSpeedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.progress.mas_bottom).with.offset(6.f);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(-10.f);
    }];
    
    [self.fileSizeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.downloadSpeedLabel.mas_centerY);
        make.right.mas_equalTo(self.progress.mas_right);
        make.width.mas_lessThanOrEqualTo(60.f);
    }];
    
    [self.downloadNowSizeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.downloadSpeedLabel.mas_centerY);
        make.right.mas_equalTo(self.fileSizeLabel.mas_left).with.offset(-5.f);
        make.width.mas_lessThanOrEqualTo(65.f);
    }];
}

- (void)configureMusic:(WYALocalDownloadModel *)model {
    self.progress.progress = model.so_downloadProgress;
    self.titleLabel.text = model.videoName;
    self.fileSizeLabel.text = model.fileSize;
    self.fileSizeLabel.text = [NSString stringWithFormat:@"/%.1fM",[model.fileSize floatValue]];
    self.model = model;
    //    self.backgroundColor = [UIColor whiteColor];
}

- (void)setModel:(WYALocalDownloadModel *)model{
//    if (model) {
//        self.localModel = model;
//        self.titleLabel.text = model.fileName;
    
//        self.downloadSpeedLabel.text = [NSString stringWithFormat:@"%@/s",model.fileSpeed];
//        self.downloadNowSizeLabel.text = [NSString stringWithFormat:@"%.1fM",model.fileSize*model.fileProgress];
//
//    }
    if (_model) {
        [_model removeObserver:self forKeyPath:@__STRING(so_downloadState)];
        [_model removeObserver:self forKeyPath:@__STRING(so_downloadProgress)];
        [_model removeObserver:self forKeyPath:@__STRING(so_downloadSpeed)];
    }
    _model = model;
    if (_model) {
        [_model addObserver:self forKeyPath:@__STRING(so_downloadState) options:NSKeyValueObservingOptionNew context:kStateContext];
        [_model addObserver:self forKeyPath:@__STRING(so_downloadProgress) options:NSKeyValueObservingOptionNew context:kProgressContext];
        [_model addObserver:self forKeyPath:@__STRING(so_downloadSpeed) options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:kSpeedContext];
    }
}

- (void)updateState:(SODownloadState)state {
    switch (state) {
        case SODownloadStateWait:
            self.downloadSpeedLabel.text = @"等待中";
            break;
        case SODownloadStatePaused:
            self.downloadSpeedLabel.text = @"已暂停";
            break;
        case SODownloadStateError:
            self.downloadSpeedLabel.text = @"下载失败";
            break;
        case SODownloadStateLoading:
            self.downloadSpeedLabel.text = @"正在下载";
            break;
        case SODownloadStateProcess:
            
            break;
        case SODownloadStateComplete:
            self.downloadSpeedLabel.text = @"已下载";
            break;
        default:
            
            break;
    }

}

/**
 注意这个方法，当参数 music 为 nil 时，调用此方法可移除对之前设置的 music 的下载状态的观察。
 更多关于 UITableViewCell+KVO 需要注意的地方参考 SOMusicListViewController.m 文件。
 */

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (context == kStateContext) {
        SODownloadState newState = [change[NSKeyValueChangeNewKey]integerValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateState:newState];
        });
    } else if (context == kProgressContext) {
        double newProgress = [change[NSKeyValueChangeNewKey]doubleValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progress.progress = newProgress;
            self.downloadNowSizeLabel.text = [NSString stringWithFormat:@"%.1fM",[_model.fileSize floatValue]*newProgress];
        });
    } else if (context == kSpeedContext) {
        NSNumber *value = change[NSKeyValueChangeNewKey];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ((NSNull *)value == [NSNull null]) {
                self.downloadSpeedLabel.text = @"0 Byte/s";
            } else {
                NSInteger speed = [value integerValue];
                if (speed < 1024) {
                    self.downloadSpeedLabel.text = [NSString stringWithFormat:@"%li B/s", speed];
                } else if (speed < 1024 * 1024) {
                    self.downloadSpeedLabel.text = [NSString stringWithFormat:@"%li KB/s", speed / 1024];
                } else {
                    self.downloadSpeedLabel.text = [NSString stringWithFormat:@"%li MB/s", speed / 1024 / 1024];
                }
            }
        });
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


- (void)buttonClick:(UIButton *)button{
    button.selected = !button.selected;
//    if (self.buttonXZ) {
//        self.buttonXZ(button.selected, self.localModel);
//    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectCellWithState:Model:)]) {
        [self.delegate selectCellWithState:self.button.selected Model:_model];
    }
}

- (void)setCanEdit:(BOOL)canEdit{
    if (canEdit) {
        self.button.hidden = NO;
        
        [self layoutIfNeeded];
    }else{
        self.button.hidden = YES;
        
        [self layoutIfNeeded];
    }
}

- (void)setSelectCell:(BOOL)selectCell{
    if (selectCell) {
        self.button.selected = YES;
//        if (self.buttonXZ) {
//            self.buttonXZ(self.button.selected, self.localModel);
//        }
//        if (self.aaa) {
//            self.aaa(self.button.selected, self.localModel);
//        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectCellWithState:Model:)]) {
            [self.delegate selectCellWithState:self.button.selected Model:_model];
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
