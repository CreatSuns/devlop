//
//  WYATestDoubleSelectedTableViewCell.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/16.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//答题选项多选

#import "WYATestDoubleSelectedTableViewCell.h"
#import "WYAJHAnswerModel.h"
@interface WYATestDoubleSelectedTableViewCell()
@property(nonatomic, strong) UIButton * button;
@property(nonatomic, strong) UILabel * titleNameLabel;
@property(nonatomic, strong) UIButton * titleTypeLabel;
@property(nonatomic, strong) UILabel * optionsLabel;
@end
@implementation WYATestDoubleSelectedTableViewCell
static NSString * chooseBtn = @"";
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleTypeLabel = [[UIButton alloc]init];
        _titleNameLabel = [[UILabel alloc]init];
        
        [self addSubview:_titleTypeLabel];
        [self addSubview:_titleNameLabel];
    }
    return self;
}
- (void)layoutSubviews
{
    
    [_titleTypeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(Size_ratio*10.f);
        make.top.equalTo(self.mas_top).offset(Size_ratio*20.f);
        make.width.mas_equalTo(Size_ratio*60.f);
        make.height.mas_equalTo(Size_ratio*15.f);
    }];
    
    CGFloat titleHeight = [self heightOfConttent:_listModel.question fontSize:16*Size_ratio maxWidth:ScreenWidth - 80*Size_ratio];
    [_titleNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleTypeLabel.mas_right).offset(Size_ratio*10.f);
        make.top.equalTo(self.mas_top).offset(Size_ratio*10.f);
        make.width.mas_equalTo(ScreenWidth - 80*Size_ratio);
        make.height.mas_equalTo(titleHeight);
    }];
}
- (void)setListModel:(WYATestQuestionListModel *)listModel
{
    _listModel = listModel;
    //    _titleTypeLabel.text = _listModel.type;
    //    _titleTypeLabel.textColor = [UIColor whiteColor];
    //    _titleTypeLabel.font = [UIFont systemFontOfSize:11*Size_ratio];
    //    _titleTypeLabel.textAlignment = NSTextAlignmentCenter;
    //    _titleTypeLabel.adjustsFontSizeToFitWidth = YES;
    [_titleTypeLabel setBackgroundImage:[UIImage imageNamed:@"渐变色"] forState:UIControlStateNormal];
    [_titleTypeLabel setTitle:_listModel.type forState:UIControlStateNormal];
    [_titleTypeLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _titleTypeLabel.titleLabel.font = [UIFont systemFontOfSize:11*Size_ratio];
    _titleTypeLabel.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    _titleNameLabel.text = _listModel.question;
    _titleNameLabel.textColor = [UIColor WYAJHBlackTextColor];
    _titleNameLabel.font = [UIFont systemFontOfSize:16*Size_ratio];
    _titleNameLabel.numberOfLines = 0;
    [self creatScrollButton];
    [self layoutIfNeeded];
}

#pragma mark ====== event
- (void)doubleButtonClicked:(UIButton *)sender
{
    
    //    NSString * currentNumber = [[NSUserDefaults standardUserDefaults]objectForKey:@"currentQuestionNum"];
    //    if (![currentNumber isEqualToString:_listModel.question_number]) {
    //        chooseBtn = @"";
    //    }
    sender.selected = !sender.selected;
    if (sender.selected) {
        chooseBtn = [chooseBtn stringByAppendingFormat:@"%@",sender.titleLabel.text];
        UIImageView * selectedImageView = [[UIImageView alloc]initWithFrame:sender.frame];
        selectedImageView.backgroundColor = [UIColor whiteColor];
        selectedImageView.tag = sender.tag+1000;
        [self addSubview:selectedImageView];
        selectedImageView.image = [UIImage imageNamed:@"选框(已选)"];
        selectedImageView.layer.cornerRadius = 12.f*Size_ratio;
        selectedImageView.layer.masksToBounds = YES;
    }else
    {
        UIImageView * selectedImg = [self viewWithTag:sender.tag + 1000];
        [selectedImg removeFromSuperview];
        if ([chooseBtn rangeOfString:sender.titleLabel.text].location == NSNotFound) {
        } else {
            chooseBtn = [chooseBtn stringByReplacingOccurrencesOfString:sender.titleLabel.text withString:@""];
        }
    }
#pragma mark ====== 数据存入数据库
    JQFMDB * db = [JQFMDB shareDatabase];
    [db jq_createTable:ANSWE_DataBase dicOrModel:[WYAJHAnswerModel class]];
    WYAJHAnswerModel * model = [[WYAJHAnswerModel alloc]initWithPaper_id:self.paperId
                                                         question_number:_listModel.question_number
                                                            questionType:_listModel.type
                                                            answerString:chooseBtn];
    // 查询条件
    NSString * searchString = [NSString stringWithFormat:@"where question_number = '%@'",_listModel.question_number];
    //查询结果
    NSArray * answerArr = [db jq_lookupTable:ANSWE_DataBase dicOrModel:[WYAJHAnswerModel class] whereFormat:searchString];
    
    if (answerArr.count==0) {
        // 插入model到数据库
        [db jq_insertTable:ANSWE_DataBase dicOrModel:model];
        NSString * answerString = [NSString stringWithFormat:@"WHERE question_number = %@",_listModel.question_number];
        [db jq_updateTable:ANSWE_DataBase dicOrModel:@{@"answerString":chooseBtn} whereFormat:answerString];
    }else{
        // 通过rowid更新数据库对应的model内容
        NSString * answerString = [NSString stringWithFormat:@"WHERE question_number = %@",_listModel.question_number];
        [db jq_updateTable:ANSWE_DataBase dicOrModel:@{@"answerString":chooseBtn} whereFormat:answerString];
        //    [[NSUserDefaults standardUserDefaults]setObject:_listModel.question_number forKey:@"currentQuestionNum"];
    }
    //    if (self.delegate&&[self.delegate respondsToSelector:@selector(doubleChooseAnswerButtonClicked:)]) {
    //        [self.delegate doubleChooseAnswerButtonClicked:self];
    //    }
}
#pragma mark ====== 创建选项按钮
- (void)creatScrollButton{
    
    CGFloat margin = 35.f*Size_ratio;
    CGFloat height = 35.f*Size_ratio;
    CGFloat titleHeight = [self heightOfConttent:_listModel.question fontSize:16*Size_ratio maxWidth:ScreenWidth - 65*Size_ratio];
    CGFloat Y = 12.f*Size_ratio + titleHeight + 10*Size_ratio;
    NSArray * optionArray = _listModel.options;
    for (NSInteger i = 0; i < optionArray.count; i++) {
        
        _optionsLabel = [[UILabel alloc]init];
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat  labelHeight = [self heightOfConttent:[optionArray[i] objectForKey:@"value"] fontSize:16.f*Size_ratio maxWidth:ScreenWidth-80*Size_ratio];
        NSString * btnTitleText = [optionArray[i] objectForKey:@"key"];
        //查询数据库
        NSString * searchString = [NSString stringWithFormat:@"where question_number = '%@'",_listModel.question_number];
        
        JQFMDB * db = [JQFMDB shareDatabase];
        NSArray * answerArr = [db jq_lookupTable:ANSWE_DataBase dicOrModel:[WYAJHAnswerModel class] whereFormat:searchString];
        if (answerArr.count!=0) {
            WYAJHAnswerModel * model = answerArr[0];
            chooseBtn = model.answerString;
            if ([model.answerString rangeOfString:btnTitleText].location == NSNotFound) {
            } else {
                _button.selected = YES;
            }
        }else
        {
            chooseBtn = @"";
        }
        [_button setTitle:btnTitleText forState:UIControlStateNormal];
        _button.tag = 1000 + i;
        [_button setTitleColor:[UIColor WYAJHBlackTextColor] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor WYAJHBaseRedColor] forState:UIControlStateSelected];
        _button.backgroundColor = [UIColor whiteColor];
        
        _button.layer.cornerRadius = 17.5*Size_ratio;
        _button.layer.borderColor = [UIColor WYAJHLightGreyColor].CGColor;
        _button.layer.borderWidth = 0.5;
        if (_isDoubleTouchUpInsde == WYATestTestDoubleSelected) {
            [_button addTarget:self action:@selector(doubleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [self addSubview:_button];
        [self addSubview:_optionsLabel];
        
        _optionsLabel.text = [optionArray[i] objectForKey:@"value"];
        _optionsLabel.textColor = [UIColor WYAJHBlackTextColor];
        _optionsLabel.numberOfLines = 0;
        _optionsLabel.font = [UIFont systemFontOfSize:16.f*Size_ratio];
        
        [_button mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(20*Size_ratio);
            make.top.mas_equalTo(Y + i*(labelHeight + margin));
            make.width.mas_equalTo(height);
            make.height.mas_equalTo(height);
        }];
        
        [_optionsLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_button.mas_right).offset(10*Size_ratio);
            make.centerY.mas_equalTo(_button.mas_centerY);
//            make.top.mas_equalTo(Y - 3*Size_ratio + i*(labelHeight + margin));
            make.width.mas_equalTo(ScreenWidth-80*Size_ratio);
            make.height.mas_equalTo(labelHeight);
        }];
        if (_button.isSelected) {
            UIImageView * selectedImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20*Size_ratio, Y + i*(labelHeight + margin), height, height)];
            selectedImageView.backgroundColor = [UIColor whiteColor];
            [self addSubview:selectedImageView];
            selectedImageView.image = [UIImage imageNamed:@"选框(已选)"];
            selectedImageView.layer.cornerRadius = 12.f*Size_ratio;
            selectedImageView.layer.masksToBounds = YES;
        }
    }
}
// 返回cell高度
+ (CGFloat)cellHeightWithModel:(WYATestQuestionListModel *)model
{
    CGFloat margin = 24.f*Size_ratio;
    CGFloat Y = 12.f;
    NSArray * optionArray = model.options;
    CGFloat labelHeightAll = 0.f ;
    for (NSInteger i = 0; i < optionArray.count; i++) {
        CGFloat  labelHeight = [self heightOfConttent:[optionArray[i] objectForKey:@"key"]  fontSize:16*Size_ratio maxWidth:ScreenWidth - 65*Size_ratio];
        labelHeightAll += labelHeight;
    }
    CGFloat questionHeight = [self heightOfConttent:model.question fontSize:16*Size_ratio maxWidth:ScreenWidth - 80*Size_ratio];
    
    return labelHeightAll + 2*Y + margin * 3 + 10 + questionHeight;
}
#pragma mark ====== 根据文字内容计算label高度
/**
 字符串高度
 */

- (CGFloat)heightOfConttent:(NSString*)content fontSize:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth
{
    
    if (content.length==0) {
        return 0.0;
    }
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    return [content boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height+fontSize;
    
}
+ (CGFloat)heightOfConttent:(NSString*)content fontSize:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth
{
    
    if (content.length==0) {
        return 0.0;
    }
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    return [content boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height+fontSize;
    
}
@end
