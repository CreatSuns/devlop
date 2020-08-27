//
//  WYAMyCourseTableCell.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/10.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMyCourseTableCell.h"
#import "WYAMyCourseListModel.h"

@interface WYAMyCourseTableCell ()

@property (nonatomic, strong) UIImageView * imgView;

@property (nonatomic, strong) UILabel * titleLabel;

@property (nonatomic, strong) UILabel * issuerLabel;

@property (nonatomic, strong) UILabel * learnLabel;

@property (nonatomic, strong) UILabel * downloadLabel;

@end

@implementation WYAMyCourseTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.imgView = [[UIImageView alloc]init];
        self.imgView.layer.cornerRadius = 5.f;
        self.imgView.layer.masksToBounds = YES;
        self.imgView.backgroundColor = [UIColor redColor];
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
        self.learnLabel.textColor = [UIColor WYAJHBaseBlueColor];
        self.learnLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.learnLabel];
        
        self.downloadLabel = [[UILabel alloc]init];
        self.downloadLabel.font = [UIFont systemFontOfSize:10];
        self.downloadLabel.textColor = [UIColor WYAJHSegNoSelectColor];
        self.downloadLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.downloadLabel];
        
        self.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
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
        make.width.mas_lessThanOrEqualTo(@150.f);
    }];
    
    [self.downloadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-13.f);
        make.centerY.mas_equalTo(self.learnLabel.mas_centerY);
        make.width.mas_lessThanOrEqualTo(@100.f);
    }];
}

-(void)setModel:(MyCourseList *)model{
    
    if (model) {
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:[checkString(model.img_url) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@""]];
        
        self.titleLabel.text = checkString(model.title);
        self.issuerLabel.text = checkString(model.teacher_name);
        if (model.total_process) {
            self.learnLabel.text = [NSString stringWithFormat:@"已学习%@",checkString(model.total_process)];
        }
        if (model.download_status) {
            self.downloadLabel.text = model.download_status;
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
