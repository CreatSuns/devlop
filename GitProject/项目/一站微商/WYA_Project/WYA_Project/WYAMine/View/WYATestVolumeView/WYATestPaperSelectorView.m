//
//  WYATestPaperSelectorView.m
//  WYA_Project
//
//  Created by 李世航 on 2018/4/19.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYATestPaperSelectorView.h"

@interface WYATestPaperSelectorView()

@property (strong, nonatomic) UIButton * allChapterButton;

@property (strong, nonatomic) UIButton * allPeopleButton;

@property(nonatomic, strong) UIView * lineView;// 添加分割线，修改人李俊恒

@end


@implementation WYATestPaperSelectorView

- (UIButton *)allChapterButton{
    if (!_allChapterButton) {
        
        _allChapterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allChapterButton setTitle:@"全部章节" forState:UIControlStateNormal];
        #pragma mark ====== 修改人李俊恒设置button标题字号
        _allChapterButton.titleLabel.font = [UIFont systemFontOfSize:14*Size_ratio];
        #pragma mark ======
        [_allChapterButton setTitleColor:[UIColor WYAJHBlackTextColor] forState:UIControlStateNormal];
        [_allChapterButton setImage:[UIImage imageNamed:@"down_black_icon"] forState:UIControlStateNormal];
        _allChapterButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _allChapterButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        CGFloat imageWidth = _allChapterButton.imageView.image.size.width;
        CGFloat titleWidth = _allChapterButton.titleLabel.width;
        CGFloat spaceWidth = (ScreenWidth/2-imageWidth-titleWidth)/2;
        _allChapterButton.selected = NO;
        _allChapterButton.titleEdgeInsets = UIEdgeInsetsMake(0, -spaceWidth, 0, spaceWidth-imageWidth);
        _allChapterButton.imageEdgeInsets = UIEdgeInsetsMake(0, titleWidth+spaceWidth, 0, -titleWidth);
        [_allChapterButton addTarget:self action:@selector(chapterClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allChapterButton;
}

- (UIButton *)allPeopleButton{
    if (!_allPeopleButton) {
        _allPeopleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allPeopleButton setTitle:@"全部人员" forState:UIControlStateNormal];
        [_allPeopleButton setTitleColor:[UIColor WYAJHBlackTextColor] forState:UIControlStateNormal];
        [_allPeopleButton setImage:[UIImage imageNamed:@"down_black_icon"] forState:UIControlStateNormal];
        _allPeopleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _allPeopleButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        #pragma mark ====== 修改人李俊恒设置button标题字号
        _allPeopleButton.titleLabel.font = [UIFont systemFontOfSize:14*Size_ratio];//
        #pragma mark ======
        CGFloat imageWidth = _allPeopleButton.imageView.image.size.width;
        CGFloat titleWidth = _allPeopleButton.titleLabel.width;
        CGFloat spaceWidth = (ScreenWidth/2-imageWidth-titleWidth)/2;
        _allPeopleButton.selected = NO;
        _allPeopleButton.titleEdgeInsets = UIEdgeInsetsMake(0, -spaceWidth, 0, spaceWidth-imageWidth);
        _allPeopleButton.imageEdgeInsets = UIEdgeInsetsMake(0, titleWidth+spaceWidth, 0, -titleWidth);
        [_allPeopleButton addTarget:self action:@selector(peopleClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allPeopleButton;
}
// 添加分割线视图 修改人李俊恒
- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor WYAJHLightGreyColor];
    }
    return _lineView;
}
- (instancetype)init{
    self = [super init];
    if (self) {

        [self addSubview:self.allChapterButton];
        [self addSubview:self.lineView];
        [self addSubview:self.allPeopleButton];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.allChapterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.mas_equalTo(ScreenWidth/2);
    }];
    // 添加分割线约束
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.allChapterButton.mas_right);
        make.top.mas_equalTo(4.5*Size_ratio);
        make.bottom.mas_equalTo(-4.5*Size_ratio);
        make.width.mas_equalTo(1);
    }];
    [self.allPeopleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.mas_equalTo(ScreenWidth/2);
    }];
}

- (void)chapterClick:(UIButton *)sender{
    self.allPeopleButton.selected = NO;
    [self.allPeopleButton setTitleColor:[UIColor WYAJHBlackTextColor] forState:UIControlStateNormal];
    [self.allPeopleButton setImage:[UIImage imageNamed:@"down_black_icon"] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.1 animations:^{
        self.allPeopleButton.imageView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setTitleColor:[UIColor WYAJHBasePurpleColor] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"down_purple_icon"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.5 animations:^{
            sender.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }completion:^(BOOL finished) {
            
        }];
        
    }else{
        [sender setTitleColor:[UIColor WYAJHBlackTextColor] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"down_black_icon"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.5 animations:^{
            sender.imageView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedChapterWithButton:)]) {
        [self.delegate selectedChapterWithButton:sender];
    }
}

- (void)peopleClick:(UIButton *)sender{
    self.allChapterButton.selected = NO;
    [self.allChapterButton setTitleColor:[UIColor WYAJHBlackTextColor] forState:UIControlStateNormal];
    [self.allChapterButton setImage:[UIImage imageNamed:@"down_black_icon"] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.1 animations:^{
        self.allChapterButton.imageView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setTitleColor:[UIColor WYAJHBasePurpleColor] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"down_purple_icon"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.5 animations:^{
            sender.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }completion:^(BOOL finished) {
            
        }];
        
    }else{
        [sender setTitleColor:[UIColor WYAJHBlackTextColor] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"down_black_icon"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.5 animations:^{
            sender.imageView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedPeopleWithButton:)]) {
        [self.delegate selectedPeopleWithButton:sender];
    }
}

- (void)setChapterName:(NSString *)chapterName{
    if (chapterName) {
        [self.allChapterButton setTitle:chapterName forState:UIControlStateNormal];
        self.allChapterButton.selected = NO;
        [self.allChapterButton setTitleColor:[UIColor WYAJHBlackTextColor] forState:UIControlStateNormal];
        [self.allChapterButton setImage:[UIImage imageNamed:@"down_black_icon"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.1 animations:^{
            self.allChapterButton.imageView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)setPeopleName:(NSString *)peopleName{
    if (peopleName) {
        [self.allPeopleButton setTitle:peopleName forState:UIControlStateNormal];
        self.allPeopleButton.selected = NO;
        [self.allPeopleButton setTitleColor:[UIColor WYAJHBlackTextColor] forState:UIControlStateNormal];
        [self.allPeopleButton setImage:[UIImage imageNamed:@"down_black_icon"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.1 animations:^{
            self.allPeopleButton.imageView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
