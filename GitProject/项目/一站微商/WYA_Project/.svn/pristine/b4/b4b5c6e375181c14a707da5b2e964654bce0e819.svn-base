//
//  WYAMineTestScoresCell.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/18.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMineTestScoresCell.h"
#import "WYAMineTestScoresModel.h"
@interface WYAMineTestScoresCell ()

/**
 图片
 */
@property (nonatomic, strong) UIImageView * imgView;

/**
 标题
 */
@property (nonatomic, strong) UILabel * titleLabel;

/**
 待测试
 */
@property (nonatomic, strong) UILabel * willTestLabel;

/**
 已测试
 */
@property (nonatomic, strong) UILabel * didTestLabel;

@end

@implementation WYAMineTestScoresCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
        self.titleLabel.numberOfLines = 2;
        [self.contentView addSubview:self.titleLabel];
        
        self.willTestLabel = [[UILabel alloc]init];
        self.willTestLabel.font = [UIFont systemFontOfSize:12];
        self.willTestLabel.textColor = [UIColor WYAJHBlackTextColor];
        self.willTestLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.willTestLabel];
        
        self.didTestLabel = [[UILabel alloc]init];
        self.didTestLabel.font = [UIFont systemFontOfSize:12];
        self.didTestLabel.textColor = [UIColor WYAJHBasePurpleColor];
        self.didTestLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.didTestLabel];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(10.f);
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(12.f);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(-12.f);
        make.width.mas_equalTo(114.f);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_top).with.offset(2.f);
        make.left.mas_equalTo(self.imgView.mas_right).with.offset(10.f);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-48.f);
    }];
    
    [self.willTestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.bottom.mas_equalTo(self.imgView.mas_bottom).with.offset(-2.f);
        make.width.mas_lessThanOrEqualTo(80.f);
    }];
    
    [self.didTestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.willTestLabel.mas_right).with.offset(12.f);
        make.centerY.mas_equalTo(self.willTestLabel.mas_centerY);
    }];
}

-(void)setModel:(WYAMineTestScoresListModel *)model{
    if (model) {
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:[checkString(model.img_url) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@""]];
        self.titleLabel.text = checkString(model.title);
        self.willTestLabel.text = [NSString stringWithFormat:@"待测试：%@",checkString(model.all_count)];
        self.didTestLabel.text = [NSString stringWithFormat:@"已测试：%@",checkString(model.user_count)];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
