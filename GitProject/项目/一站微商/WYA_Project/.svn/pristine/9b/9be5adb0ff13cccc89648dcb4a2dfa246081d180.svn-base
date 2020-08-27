//
//  WYATestBottomView.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/14.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
// 测试题的底部进度显示以及答题卡显示

#import "WYATestBottomView.h"
#define  Size_ratio ScreenWidth/414
@interface WYATestBottomView ()
@property(nonatomic, strong) UIButton * answerCardBtn;
@property(nonatomic, strong) UILabel * answerCardLabel;
@property(nonatomic, strong) UIImageView * answerCardImg;
@property(nonatomic, strong) UILabel * currentPage;
@property(nonatomic, strong) UIProgressView * currentProgressView;
@end
@implementation WYATestBottomView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _answerCardBtn = [[UIButton alloc]init];
        _answerCardImg = [[UIImageView alloc]init];
        _answerCardLabel = [[UILabel alloc]init];
        _currentPage = [[UILabel alloc]init];
        _currentProgressView = [[UIProgressView alloc]init];
        [_answerCardBtn addSubview:_answerCardImg];
        [_answerCardBtn addSubview:_answerCardLabel];
        [self addSubview:_answerCardBtn];
        [self addSubview:_currentPage];
        [self addSubview:_currentProgressView];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_answerCardBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(Size_ratio*245.f);
        make.top.equalTo(self.mas_top).offset(15.f);
        make.bottom.equalTo(self.mas_bottom).offset(-15.f);
        make.width.mas_equalTo(60.f);
    }];
    
    [_answerCardImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_answerCardBtn.mas_left).offset(3.f);
        make.top.equalTo(_answerCardBtn.mas_top).offset(0);
        make.width.mas_equalTo(19.f);
        make.height.mas_equalTo(19.f);
    }];
    [_answerCardLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_answerCardImg.mas_right).offset(3.f);
        make.top.equalTo(_answerCardBtn.mas_top).offset(0);
        make.width.mas_equalTo(50.f);
        make.height.mas_equalTo(19.f);
    }];
    [_currentProgressView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(2.f);
        make.top.mas_equalTo(self.mas_top);
    }];
    [_currentPage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10.f);
        make.left.equalTo(_answerCardBtn.mas_right).offset(11.f);
        make.top.equalTo(self.mas_top).offset(15.f);
        make.bottom.equalTo(self.mas_bottom).offset(-15.f);
    }];
}
- (void)setPageNum:(NSArray *)pageNum
{
    _pageNum = pageNum;
    _answerCardImg.image = [UIImage imageNamed:@"答题卡"];
    _answerCardLabel.text = @"答题卡";
    _answerCardLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    _answerCardLabel.font = [UIFont systemFontOfSize:15.f];
    
    [_answerCardBtn addTarget:self action:@selector(answerCardBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _currentPage.text = [NSString stringWithFormat:@"%@/%@",[_pageNum firstObject],[_pageNum lastObject]];
    _currentPage.textColor = [UIColor colorWithHexString:@"#333333"];
    _currentPage.font = [UIFont systemFontOfSize:15.f];
    _currentPage.textAlignment = NSTextAlignmentRight;
    
    _currentProgressView.progressViewStyle = UIProgressViewStyleDefault;
    _currentProgressView.backgroundColor = [UIColor greenColor];
    _currentProgressView.alpha = 1;
    _currentProgressView.progressTintColor = [UIColor WYAJHBasePurpleColor];
    _currentProgressView.trackTintColor = [UIColor whiteColor];
    _currentProgressView.progress = [[_pageNum firstObject] floatValue]/[[_pageNum lastObject] floatValue];
    
    [self layoutIfNeeded];
}
#pragma mark ====== event
- (void)answerCardBtnClicked:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(testQuestionCardButtonClicked:)]) {
        [self.delegate testQuestionCardButtonClicked:sender];
    }
}
@end
