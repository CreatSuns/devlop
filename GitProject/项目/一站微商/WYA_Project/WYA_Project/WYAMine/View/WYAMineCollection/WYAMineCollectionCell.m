//
//  WYAMineCollectionCell.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/16.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMineCollectionCell.h"
#import "WYAMineCollectionCourseModel.h"
#import "WYAMineCollectionArticleModel.h"
@interface WYAMineCollectionCell ()

/**
 课程图片
 */
@property (nonatomic, strong) UIImageView * imgView;

/**
 课程标题
 */
@property (nonatomic, strong) UILabel * titleLabel;

/**
 学习进度
 */
@property (nonatomic, strong) UILabel * learnLabel;

@property (nonatomic, strong) UIButton * deleteButton;

@property (nonatomic, strong) WYAMineCollectionCourseListModel * courseListModel;

@property (nonatomic, strong) WYAMineCollectionArticleListModel * articleListModel;

@end

@implementation WYAMineCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.imgView = [[UIImageView alloc]init];
        self.imgView.layer.cornerRadius = 5.0f*Size_ratio;
        self.imgView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.imgView];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.font = [UIFont systemFontOfSize:15*Size_ratio];
        self.titleLabel.textColor = [UIColor WYAJHBlackTextColor];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.numberOfLines = 2;
        [self.contentView addSubview:self.titleLabel];
        
        self.learnLabel = [[UILabel alloc]init];
        self.learnLabel.font = [UIFont systemFontOfSize:12*Size_ratio];
        self.learnLabel.textColor = [UIColor WYAJHBaseBlueColor];
        self.learnLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.learnLabel];
        
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.deleteButton setImage:[UIImage imageNamed:@"垃圾桶"] forState:UIControlStateNormal];
        [self.deleteButton addTarget:self action:@selector(deleteButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.deleteButton];
    }
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(15.f*Size_ratio);
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(13.f*Size_ratio);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(-13.f*Size_ratio);
        make.width.mas_equalTo(134.f*Size_ratio);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_top).with.offset(2.f*Size_ratio);
        make.left.mas_equalTo(self.imgView.mas_right).with.offset(8.f*Size_ratio);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-27.f*Size_ratio);
    }];
    
    [self.learnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.bottom.mas_equalTo(self.imgView.mas_bottom).with.offset(-2.f*Size_ratio);
        make.right.mas_equalTo(self.titleLabel.mas_right);
    }];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).with.offset(-10*Size_ratio);
        make.bottom.mas_equalTo(self.imgView.mas_bottom).with.offset(0*Size_ratio);
        make.size.mas_equalTo(CGSizeMake(50*Size_ratio, 50*Size_ratio));
    }];
}

- (void)deleteButtonAction{
    if (self.courseListModel) {
        if (self.deleteButtonClick) {
            self.deleteButtonClick(self.courseListModel.course_id);
        }
    }else if (self.articleListModel) {
        if (self.deleteButtonClick) {
            self.deleteButtonClick(self.articleListModel.article_id);
        }
    }
}

-(void)setModel:(id)model{
    if (model) {
        if ([model isKindOfClass:[WYAMineCollectionCourseListModel class]]) {
            WYAMineCollectionCourseListModel * courseModel = (WYAMineCollectionCourseListModel *)model;
            self.courseListModel = courseModel;
            [self.imgView sd_setImageWithURL:[NSURL URLWithString:[checkString(courseModel.img_url) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@""]];
            self.titleLabel.text = checkString(courseModel.title);
            self.learnLabel.text = [NSString stringWithFormat:@"已学习: %@",checkString(courseModel.total_process)];
        }else if ([model isKindOfClass:[WYAMineCollectionArticleListModel class]]) {
            WYAMineCollectionArticleListModel * articleModel = (WYAMineCollectionArticleListModel *)model;
            self.articleListModel = articleModel;
            [self.imgView sd_setImageWithURL:[NSURL URLWithString:[checkString(articleModel.img) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@""]];
            self.titleLabel.text = checkString(articleModel.title);
            self.learnLabel.text = checkString(articleModel.teacher_name);
            self.learnLabel.textColor = [UIColor WYAJHBlackTextColor];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
