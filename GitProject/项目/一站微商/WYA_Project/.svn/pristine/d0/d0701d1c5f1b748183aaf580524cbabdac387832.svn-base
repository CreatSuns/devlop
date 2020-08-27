//
//  WYANewCourseCell.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/10.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYANewCourseCell.h"
#import "WYANewCourseModel.h"

@interface WYANewCourseCell ()

@property (nonatomic, strong) UIView * backgroundView;

@property (nonatomic, strong) UIImageView * imgView;

@property (nonatomic, strong) UILabel * titleLabel;

@property (nonatomic, strong) UIImageView * goldMedalImageView;

@property (nonatomic, strong) UILabel * teacherLabel;

@property (nonatomic, strong) UILabel * dateLabel;


@end

@implementation WYANewCourseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor WYAJHLightGreyColor];
        
        self.backgroundView = [[UIView alloc]init];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
        self.backgroundView.layer.cornerRadius = 10;
        self.backgroundView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.backgroundView];
        
        self.imgView = [[UIImageView alloc]init];
        self.imgView.layer.cornerRadius = 5.f;
        self.imgView.layer.masksToBounds = YES;
        
        [self.backgroundView addSubview:self.imgView];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textColor = [UIColor WYAJHBlackTextColor];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.numberOfLines = 2;
        [self.backgroundView addSubview:self.titleLabel];
        
        self.goldMedalImageView = [[UIImageView alloc]init];
        
        [self.backgroundView addSubview:self.goldMedalImageView];
        
        self.teacherLabel = [[UILabel alloc]init];
        self.teacherLabel.font = [UIFont systemFontOfSize:11];
        self.teacherLabel.textColor = [UIColor WYAJHOpinionBlackTextColor];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.backgroundView addSubview:self.teacherLabel];
        
        self.dateLabel = [[UILabel alloc]init];
        self.dateLabel.font = [UIFont systemFontOfSize:10];
        self.dateLabel.textColor = [UIColor WYAJHSegNoSelectColor];
        self.dateLabel.textAlignment = NSTextAlignmentLeft;
        [self.backgroundView addSubview:self.dateLabel];
    
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(2.5, 10.f, 2.5, 10.f));
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backgroundView.mas_left).with.offset(11.f);
        make.top.mas_equalTo(self.backgroundView.mas_top).with.offset(15);
        make.bottom.mas_equalTo(self.backgroundView.mas_bottom).with.offset(-16.f);
        make.width.mas_equalTo(134.f);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_top).with.offset(2.f);
        make.left.mas_equalTo(self.imgView.mas_right).with.offset(8.f);
        make.right.mas_equalTo(self.backgroundView.mas_right).with.offset(-17.f);
    }];
    
    [self.goldMedalImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(11.f);
        make.size.mas_equalTo(CGSizeMake(15.f, 15.f));
    }];
    
    [self.teacherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goldMedalImageView.mas_right).with.offset(3.f);
        make.centerY.mas_equalTo(self.goldMedalImageView.mas_centerY);
        make.right.mas_equalTo(self.titleLabel.mas_right);
    }];

    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.teacherLabel.mas_bottom).with.offset(8.f);
        make.width.mas_lessThanOrEqualTo(@150.f);
    }];
}

-(void)setThisModel:(ThisMonth *)thisModel{
    if (thisModel) {
        
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:[checkString(thisModel.img_url) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@""]];
        
        self.titleLabel.text = checkString(thisModel.title);
        self.teacherLabel.text = [NSString stringWithFormat:@"%@  %@",checkString(thisModel.name),checkString(thisModel.teacher_name)];
        self.dateLabel.text = checkString(thisModel.create_time);
        [self.goldMedalImageView sd_setImageWithURL:[NSURL URLWithString:[checkString(thisModel.category_ico) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@""]];
    }
}

-(void)setLastModel:(LastMonth *)lastModel{
    if (lastModel) {
        
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:[checkString(lastModel.img_url) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@""]];
        
        self.titleLabel.text = checkString(lastModel.title);
        self.teacherLabel.text = [NSString stringWithFormat:@"%@  %@",checkString(lastModel.name),checkString(lastModel.teacher_name)];
        self.dateLabel.text = checkString(lastModel.create_time);
        [self.goldMedalImageView sd_setImageWithURL:[NSURL URLWithString:[checkString(lastModel.category_ico) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@""]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
