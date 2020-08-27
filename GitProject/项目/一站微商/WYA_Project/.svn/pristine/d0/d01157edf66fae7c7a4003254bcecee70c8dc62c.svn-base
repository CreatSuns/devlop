//
//  WYAArticleTableViewCell.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/9.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAArticleTableViewCell.h"
@interface WYAArticleTableViewCell()
@property(nonatomic, strong) UIImageView * leftImageView;// 大图
@property(nonatomic, strong) UILabel * articleTitle;// 标题
@property(nonatomic, strong) UILabel * authorName;// 作者名字
@property(nonatomic, strong) UIImageView * seeIcon;// 阅读
@property(nonatomic, strong) UILabel * seeNum;// 阅读量
@property(nonatomic, strong) UIImageView * likeIcon;// 点赞
@property(nonatomic, strong) UILabel * likeNum;// 点赞数
@property(nonatomic, strong) UIImageView * collectionIcon;//收藏
@property(nonatomic, strong) UILabel * collectionNum;// 收藏数
@end
@implementation WYAArticleTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _leftImageView = [[UIImageView alloc]init];
        _articleTitle = [[UILabel alloc]init];
        _seeIcon = [[UIImageView alloc]init];
        _seeNum = [[UILabel alloc]init];
        _likeIcon = [[UIImageView alloc]init];
        _likeNum = [[UILabel alloc]init];
        _collectionIcon = [[UIImageView alloc]init];
        _collectionNum = [[UILabel alloc]init];
        _authorName = [[UILabel alloc]init];
        
        [self addSubview:_leftImageView];
        [self addSubview:_articleTitle];
        [self addSubview:_seeIcon];
        [self addSubview:_seeNum];
        [self addSubview:_likeIcon];
        [self addSubview:_likeNum];
        [self addSubview:_collectionIcon];
        [self addSubview:_collectionNum];
        [self addSubview:_authorName];
        self.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);

    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];

    [_leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10.f*Size_ratio);
        make.top.equalTo(self.mas_top).offset(10.f*Size_ratio);
        make.width.mas_equalTo(114.f*Size_ratio);
        make.height.mas_equalTo(67.f*Size_ratio);
    }];

    [_articleTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImageView.mas_right).offset(10.f*Size_ratio);
        make.top.equalTo(self.mas_top).offset(12.f*Size_ratio);
        make.right.equalTo(self.mas_right).offset(-40.f*Size_ratio);
        make.height.mas_equalTo(45.f*Size_ratio);
    }];

    [_seeIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-16.f*Size_ratio);
        make.left.equalTo(_leftImageView.mas_right).offset(10.f*Size_ratio);
        make.width.mas_equalTo(15.f*Size_ratio);
        make.height.mas_equalTo(15.f*Size_ratio);
    }];
    [_seeNum mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-16.f*Size_ratio);
        make.left.equalTo(_seeIcon.mas_right).offset(3.f*Size_ratio);
        make.width.mas_equalTo(30.f*Size_ratio);
        make.height.mas_equalTo(15.f*Size_ratio);
    }];
//
    [_likeIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-16.f*Size_ratio);
        make.left.equalTo(_seeNum.mas_right).offset(8.f*Size_ratio);
        make.width.mas_equalTo(15.f*Size_ratio);
        make.height.mas_equalTo(15.f*Size_ratio);
    }];
    [_likeNum mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-16.f*Size_ratio);
        make.left.equalTo(_likeIcon.mas_right).offset(3.f*Size_ratio);
        make.width.mas_equalTo(30.f*Size_ratio);
        make.height.mas_equalTo(15.f*Size_ratio);
    }];

    [_collectionIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-16.f*Size_ratio);
        make.left.equalTo(_likeNum.mas_right).offset(8.f*Size_ratio);
        make.width.mas_equalTo(15.f*Size_ratio);
        make.height.mas_equalTo(15.f*Size_ratio);
    }];
    [_collectionNum mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-16.f*Size_ratio);
        make.left.equalTo(_collectionIcon.mas_right).offset(3.f*Size_ratio);
        make.width.mas_equalTo(30.f*Size_ratio);
        make.height.mas_equalTo(15.f*Size_ratio);
    }];
    
    [_authorName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-8.f*Size_ratio);
        make.bottom.equalTo(self.mas_bottom).offset(-12.f*Size_ratio);
        make.width.mas_equalTo(100.f*Size_ratio);
        make.height.mas_equalTo(19.f*Size_ratio);
    }];
    
   
}
- (void)setCellModel:(WYAArticleListModel *)cellModel
{
    _cellModel = cellModel;
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:_cellModel.artic_img] placeholderImage:[UIImage imageNamed:@"placeHoldImage"]];
    _leftImageView.layer.cornerRadius = 4*Size_ratio;
    _leftImageView.layer.masksToBounds = YES;
    
    [self creatLabelStyleWithLabel:_articleTitle Text:_cellModel.article_title];
    _articleTitle.textColor = [UIColor WYAJHBlackTextColor];
    _articleTitle.numberOfLines = 0;
    _articleTitle.font = [UIFont systemFontOfSize:15.f*Size_ratio];
    
    _seeIcon.image = [UIImage imageNamed:@"浏览"];
    [self creatLabelStyleWithLabel:_seeNum Text:_cellModel.pv];
    
    
    _likeIcon.image = [UIImage imageNamed:@"点赞"];
    [self creatLabelStyleWithLabel:_likeNum Text:_cellModel.count_thumb];
    
    _collectionIcon.image = [UIImage imageNamed:@"收藏"];
    [self creatLabelStyleWithLabel:_collectionNum Text:_cellModel.count_collection];
    
    if ([_cellModel.teacher_name isEqualToString:@"暂无数据"]) {
        _authorName.hidden = YES;
    }
    [self creatLabelStyleWithLabel:_authorName Text:_cellModel.teacher_name];
    
    _authorName.font = [UIFont systemFontOfSize:12.f*Size_ratio];
    _authorName.textAlignment = NSTextAlignmentRight;
    
    [self layoutIfNeeded];
}
- (void)creatLabelStyleWithLabel:(UILabel *)label Text:(NSString *)text{
    label.text = text;
    label.textColor = [UIColor colorWithHexString:@"#999999"] ;
    label.font = [UIFont systemFontOfSize:11.f*Size_ratio];
    label.adjustsFontSizeToFitWidth = YES;
}

@end
