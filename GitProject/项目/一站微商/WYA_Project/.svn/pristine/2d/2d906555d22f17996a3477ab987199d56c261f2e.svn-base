//
//  WYATestSingleSelectedTableViewCell.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/14.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//答题选项单选cell

#import "WYATestSingleSelectedTableViewCell.h"
#import "WYAJHAnswerModel.h"
@interface WYATestSingleSelectedTableViewCell ()
@property(nonatomic, strong) UIButton * button;
@property(nonatomic, strong) UILabel * titleNameLabel;
@property(nonatomic, strong) UIButton * titleTypeLabel;
@property(nonatomic, strong) UILabel * optionsLabel;
@end
static NSInteger selectIndex;
@implementation WYATestSingleSelectedTableViewCell

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
- (void)singleButtonClicked:(UIButton *)sender
{
    if (selectIndex) {
        UIButton * button = [self viewWithTag:selectIndex];
        if (button == sender) {
            // 选中按钮就是点击的按钮再次点击取消选中
            sender.selected = !sender.selected;
            UIImageView * selectedImageView = [[UIImageView alloc]initWithFrame:sender.frame];
            selectedImageView.backgroundColor = [UIColor whiteColor];
            selectedImageView.tag = sender.tag+1000;
            [self addSubview:selectedImageView];
            selectedImageView.image = [UIImage imageNamed:@"选框(已选)"];
            selectedImageView.layer.cornerRadius = 12.f*Size_ratio;
            selectedImageView.layer.masksToBounds = YES;
        }else
        {
            // 添加图片
            UIImageView * selectedImg = [self viewWithTag:selectIndex + 1000];
            [selectedImg removeFromSuperview];
            button.selected = NO;
            UIImageView * selectedImageView = [[UIImageView alloc]initWithFrame:sender.frame];
            selectedImageView.backgroundColor = [UIColor whiteColor];
            selectedImageView.tag = sender.tag+1000;
            [self addSubview:selectedImageView];
            selectedImageView.image = [UIImage imageNamed:@"选框(已选)"];
            selectedImageView.layer.cornerRadius = 12.f*Size_ratio;
            selectedImageView.layer.masksToBounds = YES;
        }
    }
    if (_button == nil){
        sender.selected = YES;
        // 添加选中了
        _button = sender;
        UIImageView * selectedImageView = [[UIImageView alloc]initWithFrame:_button.frame];
        selectedImageView.backgroundColor = [UIColor whiteColor];
        selectedImageView.tag = sender.tag+1000;
        [self addSubview:selectedImageView];
        selectedImageView.image = [UIImage imageNamed:@"选框(已选)"];
        selectedImageView.layer.cornerRadius = 12.f*Size_ratio;
        selectedImageView.layer.masksToBounds = YES;
    }
    else  if (_button !=nil &&_button == sender){
        sender.selected = YES;
        //取消选中
        UIImageView * selectedImg = [self viewWithTag:_button.tag + 1000];
        [selectedImg removeFromSuperview];
        UIImageView * selectedImageView = [[UIImageView alloc]initWithFrame:_button.frame];
        selectedImageView.backgroundColor = [UIColor whiteColor];
        selectedImageView.tag = sender.tag+1000;
        [self addSubview:selectedImageView];
        selectedImageView.image = [UIImage imageNamed:@"选框(已选)"];
        selectedImageView.layer.cornerRadius = 12.f*Size_ratio;
        selectedImageView.layer.masksToBounds = YES;
    } else if (_button!= sender && _button!=nil){
        _button.selected = NO;
        // 先把_button处的移除
        UIImageView * selectedImg = [self viewWithTag:_button.tag + 1000];
        [selectedImg removeFromSuperview];
        sender.selected = YES;
        _button = sender;
        // 在此设置图片
        UIImageView * selectedImageView = [[UIImageView alloc]initWithFrame:_button.frame];
        selectedImageView.backgroundColor = [UIColor whiteColor];
        selectedImageView.tag = sender.tag+1000;
        [self addSubview:selectedImageView];
        selectedImageView.image = [UIImage imageNamed:@"选框(已选)"];
        selectedImageView.layer.cornerRadius = 12.f*Size_ratio;
        selectedImageView.layer.masksToBounds = YES;
    }
    selectIndex = (NSInteger)sender.tag;
    
#pragma mark ====== 数据存入数据库
    JQFMDB * db = [JQFMDB shareDatabase];
    [db jq_createTable:ANSWE_DataBase dicOrModel:[WYAJHAnswerModel class]];
    WYAJHAnswerModel * model = [[WYAJHAnswerModel alloc]initWithPaper_id:self.paperId
                                                         question_number:_listModel.question_number
                                                            questionType:_listModel.type
                                                            answerString:sender.titleLabel.text];
    // 查询条件
    NSString * searchString = [NSString stringWithFormat:@"where question_number = '%@'",_listModel.question_number];
    //查询结果
    NSArray * answerArr = [db jq_lookupTable:ANSWE_DataBase dicOrModel:[WYAJHAnswerModel class] whereFormat:searchString];
    
    if (answerArr.count==0) {
        // 插入model到数据库
        [db jq_insertTable:ANSWE_DataBase dicOrModel:model];
    }else{
        // 通过rowid更新数据库对应的model内容
        NSString * answerString = [NSString stringWithFormat:@"WHERE rowid = %@",_listModel.question_number];
        [db jq_updateTable:ANSWE_DataBase dicOrModel:@{@"answerString":sender.titleLabel.text} whereFormat:answerString];
    }
    //    if (self.delegate&&[self.delegate respondsToSelector:@selector(chooseAnswerButtonClicked:)]) {
    //        [self.delegate chooseAnswerButtonClicked:sender];
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
        _button.tag = 1000 + i;
        
        if (answerArr.count!=0) {
            WYAJHAnswerModel * model = answerArr[0];
            if ([btnTitleText isEqualToString:model.answerString]) {
                _button.selected = YES;
                selectIndex = _button.tag;
            }
        }
        [_button setTitle:btnTitleText forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor WYAJHBlackTextColor] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor WYAJHBaseRedColor] forState:UIControlStateSelected];
        //        [_button setBackgroundImage:[UIImage imageNamed:@"选框(已选)"] forState:UIControlStateSelected];
        _button.backgroundColor = [UIColor whiteColor];
        
        _button.layer.cornerRadius = 17.5*Size_ratio;
        _button.layer.borderColor = [UIColor WYAJHLightGreyColor].CGColor;
        _button.layer.borderWidth = 1;
        if (_isTouchUpInsde == WYATestTestSelected) {
            [_button addTarget:self action:@selector(singleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
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
//            make.top.mas_equalTo(Y - 3*Size_ratio + i*(labelHeight + margin));
            make.centerY.mas_equalTo(_button.mas_centerY);
            make.width.mas_equalTo(ScreenWidth-80*Size_ratio);
            make.height.mas_equalTo(labelHeight);
        }];
        if (_button.isSelected) {
            UIImageView * selectedImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20*Size_ratio, Y + i*(labelHeight + margin), height, height)];
            selectedImageView.tag = _button.tag+1000;
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
