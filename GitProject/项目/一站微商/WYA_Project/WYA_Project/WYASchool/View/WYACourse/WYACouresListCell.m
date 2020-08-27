//
//  WYACouresListCell.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/8.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYACouresListCell.h"
#import "WYACouresListModel.h"

@interface WYACouresListCell ()

/**
 课程图片
 */
@property (nonatomic, strong) UIImageView * imgView;

/**
 课程标题
 */
@property (nonatomic, strong) UILabel * titleLabel;

/**
 课题作者
 */
@property (nonatomic, strong) UILabel * issuerLabel;

/**
 学习人数
 */
@property (nonatomic, strong) UILabel * learnLabel;

@end

@implementation WYACouresListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
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
        self.titleLabel.numberOfLines = 2;
        [self.contentView addSubview:self.titleLabel];
        
        self.issuerLabel = [[UILabel alloc]init];
        self.issuerLabel.font = [UIFont systemFontOfSize:11];
        self.issuerLabel.textColor = [UIColor WYAJHSegNoSelectColor];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.issuerLabel];
        
        self.learnLabel = [[UILabel alloc]init];
        self.learnLabel.font = [UIFont systemFontOfSize:10];
        self.learnLabel.textColor = [UIColor WYAJHSegNoSelectColor];
        self.learnLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.learnLabel];
        
    }
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(15.f);
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(13.f);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(-13.f);
        make.width.mas_equalTo(134.f);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_top).with.offset(2.f);
        make.left.mas_equalTo(self.imgView.mas_right).with.offset(8.f);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-27.f);
    }];
    
    [self.issuerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(10.f);
        make.right.mas_equalTo(self.titleLabel.mas_right);
    }];
    
    [self.learnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.issuerLabel.mas_bottom).with.offset(8.f);
        make.right.mas_equalTo(self.titleLabel.mas_right);
    }];
}

-(void)setModel:(List *)model{
    if (model) {
        
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:[checkString(model.img_url) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"placeHoldImage"]];
        self.titleLabel.text = checkString(model.course_title);
        self.issuerLabel.text = checkString(model.teacher_name);
        self.learnLabel.text = [NSString stringWithFormat:@"%@人学过",checkString(model.learned)];
    }
}
- (void)setSearchModel:(WYASearchCourseModel *)searchModel
{
    _searchModel = searchModel;
    if (_searchModel) {
        
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:[checkString(_searchModel.img_url) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"placeHoldImage"]];
        self.titleLabel.text = checkString(_searchModel.course_title);
        self.issuerLabel.text = checkString(_searchModel.teacher_name);
        self.learnLabel.text = [NSString stringWithFormat:@"%@人学过",checkString(_searchModel.learned)];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
