//
//  WYAArticleDetailsHeaderView.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/25.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAArticleDetailsHeaderView.h"
#import "WYAArticleDetailsHeaderView.h"

@interface WYAArticleDetailsHeaderView()
@property(nonatomic, strong) UILabel * titleLabel;
@property(nonatomic, strong) UILabel * authorName;
@property(nonatomic, strong) UILabel * timeLabel;
@property(nonatomic, strong) UILabel * readNum;
@end
@implementation WYAArticleDetailsHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        _titleLabel = [[UILabel alloc]init];
        _authorName = [[UILabel alloc]init];
        _timeLabel = [[UILabel alloc]init];
        _readNum = [[UILabel alloc]init];
        
        [self addSubview:_titleLabel];
        [self addSubview:_authorName];
        [self addSubview:_timeLabel];
        [self addSubview:_readNum];
    }
    return self;
}
- (void)layoutSubviews
{
    CGFloat titleHeight = [WYAJHTools heightOfConttent:_model.article_title fontSize:20*Size_ratio maxWidth:ScreenWidth-20*Size_ratio];
    if (titleHeight> 43.8671875) {
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10*Size_ratio);
        make.top.mas_equalTo(15*Size_ratio);
        make.height.mas_equalTo(titleHeight);
        make.width.mas_equalTo(ScreenWidth-20*Size_ratio);
    }];
     [_authorName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10*Size_ratio);
        make.top.equalTo(_titleLabel.mas_bottom).offset(5*Size_ratio);
        make.width.mas_equalTo(50*Size_ratio);
        make.height.mas_equalTo(20*Size_ratio);
    }];
     [_timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_authorName.mas_right).offset(0*Size_ratio);
         make.top.mas_equalTo(_authorName.mas_top);
         make.width.mas_equalTo(ScreenWidth*0.5);
         make.height.mas_equalTo(20*Size_ratio);
    }];
    [_readNum mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10*Size_ratio);
        make.top.mas_equalTo(_authorName.mas_top);
        make.width.mas_equalTo(ScreenWidth*0.25);
        make.height.mas_equalTo(20*Size_ratio);
    }];
}
- (void)setModel:(WYAArticleDetailModel *)model
{
    _model = model;
    _titleLabel.text = _model.article_title;
    _titleLabel.textColor = [UIColor WYAJHBlackTextColor];
    _titleLabel.font = [UIFont systemFontOfSize:20*Size_ratio];
    _titleLabel.numberOfLines = 0;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _authorName.text = _model.teacher_name;
    _authorName.textColor = [UIColor WYAJHBaseBlueColor];
    _authorName.adjustsFontSizeToFitWidth = YES;
    _authorName.font = [UIFont systemFontOfSize:14*Size_ratio];
    
    _timeLabel.textColor = [UIColor WYAJHSettingGrayTextColor];
    _timeLabel.text = _model.create_time;
    _timeLabel.font = [UIFont systemFontOfSize:14*Size_ratio];

    NSString * string = [NSString stringWithFormat:@"阅读:%@",_model.pv];
    _readNum.textColor = [UIColor WYAJHSettingGrayTextColor];
    _readNum.attributedText = [self AttribytedStringWithstr:string changeStr:_model.pv] ;
    _readNum.font = [UIFont systemFontOfSize:14*Size_ratio];
    _readNum.textAlignment = NSTextAlignmentRight;
    [self layoutIfNeeded];
}
- (NSAttributedString *)AttribytedStringWithstr:(NSString *)str changeStr:(NSString *)changeStr
{
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc]initWithString:str];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:3*Size_ratio];
    
    [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    
    NSRange range = [str rangeOfString:changeStr];
    
    [string addAttribute:NSForegroundColorAttributeName
                   value:[UIColor WYAJHBaseRedColor]
                   range:range];
    
    [string addAttribute:NSFontAttributeName
                   value:[UIFont systemFontOfSize:14*Size_ratio]
                   range:range];
    return string;
}
@end
