//
//  WYACourseCatalogCell.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/13.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYACourseCatalogCell.h"
#import "WYACourseCatalogModel.h"

@interface WYACourseCatalogCell ()

@property (nonatomic, strong) UIView * titleView;

@property (nonatomic, strong) UILabel * videoLabel;





@property (nonatomic, strong) UIView * paperView;

@property (nonatomic, strong) UIImageView * paperImageView;

@property (nonatomic, strong) UILabel * paperLabel;

@property (nonatomic, strong) UILabel * scoreLabel;
@end

@implementation WYACourseCatalogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (UIView *)titleView{
    if (!_titleView) {
        _titleView = [[UIView alloc]init];
        _titleView.backgroundColor = [UIColor whiteColor];
    }
    return _titleView;
}

- (UILabel *)videoLabel{
    if (!_videoLabel) {
        _videoLabel = [[UILabel alloc]init];
        _videoLabel.text = @"视频";
        _videoLabel.font = [UIFont systemFontOfSize:8];
        _videoLabel.textColor = [UIColor WYAJHCourseCatalogCellTextColor];
        _videoLabel.textAlignment = NSTextAlignmentCenter;
        _videoLabel.layer.cornerRadius = 3;
        _videoLabel.layer.masksToBounds = YES;
        _videoLabel.layer.borderWidth = 0.5;
        _videoLabel.layer.borderColor = [UIColor WYAJHCourseCatalogCellTextColor].CGColor;
    }
    return _videoLabel;
}

- (UILabel *)videoTitleLabel{
    if (!_videoTitleLabel) {
        _videoTitleLabel = [[UILabel alloc]init];
        _videoTitleLabel.font = [UIFont systemFontOfSize:14];
        
        _videoTitleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _videoTitleLabel;
}

- (UILabel *)downloadlabel{
    if (!_downloadlabel) {
        _downloadlabel = [[UILabel alloc]init];
        _downloadlabel.font = [UIFont systemFontOfSize:10];
        _downloadlabel.textColor = [UIColor WYAJHSegNoSelectColor];
        _downloadlabel.textAlignment = NSTextAlignmentCenter;
    }
    return _downloadlabel;
}

- (UIView *)paperView{
    if (!_paperView) {
        _paperView = [[UIView alloc]init];
        _paperView.backgroundColor = [UIColor whiteColor];
    }
    return _paperView;
}

- (UIImageView *)paperImageView{
    if (!_paperImageView) {
        _paperImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"考试成绩"]];
//        _paperImageView.backgroundColor = [UIColor redColor];
    }
    return _paperImageView;
}

- (UILabel *)paperLabel{
    if (!_paperLabel) {
        _paperLabel = [[UILabel alloc]init];
        _paperLabel.font = [UIFont systemFontOfSize:12];
        _paperLabel.textColor = [UIColor WYAJHTabBarNormalColor];
        _paperLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _paperLabel;
}

- (UILabel *)scoreLabel{
    if (!_scoreLabel) {
        _scoreLabel = [[UILabel alloc]init];
        _scoreLabel.font = [UIFont systemFontOfSize:10];
        _scoreLabel.textColor = [UIColor WYAJHBaseRedColor];
        _scoreLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _scoreLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleView];
        [self.titleView addSubview:self.videoLabel];
        [self.titleView addSubview:self.videoTitleLabel];
        [self.titleView addSubview:self.downloadlabel];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(watchVideoClick)];
        [self.titleView addGestureRecognizer:tap];
        
        [self.contentView addSubview:self.paperView];
        [self.paperView addSubview:self.paperImageView];
        [self.paperView addSubview:self.paperLabel];
        [self.paperView addSubview:self.scoreLabel];
        
        UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(testPaperClick)];
        
        [self.paperView addGestureRecognizer:tap1];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_lessThanOrEqualTo(@80.f);
//        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    
    [self.videoLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleView.mas_left).with.offset(12.f);
        make.centerY.mas_equalTo(self.videoTitleLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(25.f, 15.f));
    }];
    
    [self.videoTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleView.mas_top).with.offset(16.f);
        make.left.mas_equalTo(self.videoLabel.mas_right).with.offset(12.f);
        make.bottom.mas_equalTo(self.titleView.mas_bottom).with.offset(-6.f);
//        make.height.mas_greaterThanOrEqualTo(@18.f);
    }];
    
    [self.downloadlabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.titleView.mas_right).with.offset(-9.f);
        make.centerY.mas_equalTo(self.videoTitleLabel.mas_centerY);
        make.left.mas_equalTo(self.videoTitleLabel.mas_right);
        make.height.mas_equalTo(@10.f);
        make.width.mas_lessThanOrEqualTo(@50.f);
    }];

    [self.paperView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleView.mas_bottom);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
//        make.height.mas_greaterThanOrEqualTo(@18.f);
    }];
    
    [self.paperImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.paperView.mas_left).with.offset(53.f);
        make.centerY.mas_equalTo(self.paperLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(12.f, 12.f));
    }];
    
    [self.paperLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.paperImageView.mas_right).with.offset(4.f);
        make.top.mas_equalTo(self.paperView.mas_top).with.offset(6.f);
        make.bottom.mas_equalTo(self.paperView.mas_bottom).with.offset(-6.f);
    }];
    
    [self.scoreLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.paperView.mas_right).with.offset(-9.f);
        make.centerY.mas_equalTo(self.paperLabel.mas_centerY);
        make.left.mas_equalTo(self.paperLabel.mas_right);
        make.height.mas_equalTo(@10.f);
        make.width.mas_lessThanOrEqualTo(@50.f);
    }];
    
}

- (void)setModel:(WYACourseCatalogChaptersModel *)model{
    _model = model;
    if (model) {
        self.videoTitleLabel.text = checkString(model.chapter_title);

        if ([model.process integerValue] == 0) {
            self.videoTitleLabel.textColor = [UIColor WYAJHCourseCatalogCellTextColor];
        }else{
            self.videoTitleLabel.textColor = [UIColor WYAJHSegNoSelectColor];
        }
        
        
        if (model.chapter_paper) {
            if (!model.chapter_paper.paper_title) {
                self.paperView.hidden = YES;
                self.paperImageView.image = nil;
            }else{
                self.paperImageView.image = [UIImage imageNamed:@"考试成绩"];
                self.paperLabel.text = model.chapter_paper.paper_title;
                if (model.chapter_paper.points) {
                    self.scoreLabel.text = [NSString stringWithFormat:@"%@分",model.chapter_paper.points];
                }
                
            }
        }else{
            self.paperView.hidden = YES;
            self.paperImageView.image = nil;
        }
        
        
        [self layoutIfNeeded];
    }
}

-(void)setPushModel:(WYACourseCatalogChaptersModel *)pushModel{
    _pushModel = pushModel;
    if (pushModel) {
        if ([self.pushModel.chapter_id isEqualToString:self.model.chapter_id]) {
            self.videoTitleLabel.textColor = [UIColor WYAJHBasePurpleColor];
        }
    }
}

- (void)setCurrentModel:(WYACourseCatalogChaptersModel *)currentModel{
    _currentModel = currentModel;
    if (currentModel) {
        if ([_currentModel.chapter_id isEqualToString:self.model.chapter_id]) {
            self.videoTitleLabel.textColor = [UIColor WYAJHBasePurpleColor];
        }
    }
}

+ (CGFloat)cellHeight:(WYACourseCatalogChaptersModel *)model{
    CGFloat height = 54*heightScale;
    if (model) {
        if (model.chapter_paper) {
            height += 30*heightScale;
        }
    }
    return height;
}

- (void)watchVideoClick{
    NSLog(@"观看视频");
    if (self.model) {
        
        if (self.model.can_play) {
            //可以观看
            if (self.canWatchVideo) {
                self.canWatchVideo(self.model);
            }
            
        }else{
            [WYAShowMessageView showToastAWithMessage:@"您有未参加过的测试或未看完的视频"];
        }
    }
    
}

- (void)testPaperClick{
    NSLog(@"测试卷");
    if (self.model.chapter_paper) {
        
        if (self.model.chapter_paper.points) {
            //有成绩证明考过
            self.testPaper(ChapterWatchTestPaper, self.model.chapter_paper.paper_id);

           
        }else{
            self.testPaper(ChapterNeedTestPaper, self.model.chapter_paper.paper_id);

        }
    }else{
        [WYAShowMessageView showToastAWithMessage:@"您有未参加过的测试或未看完的视频"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
