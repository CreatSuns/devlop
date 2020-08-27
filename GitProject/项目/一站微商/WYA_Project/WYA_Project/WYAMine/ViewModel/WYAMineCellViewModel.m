//
//  WYAMineCellViewModel.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/8.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAMineCellViewModel.h"

@implementation WYAMineCellViewModel
+ (NSArray *)mineCellDataSourcesArray
{
    WYAMineCellModel * model1 = [WYAMineCellModel mineCellModelWithIconImgNamed:@"我的收藏"
                                                                      titleText:@"我的收藏"
                                                                  arrowImgNamed:@"Right arrow"];
    WYAMineCellModel * model2 = [WYAMineCellModel mineCellModelWithIconImgNamed:@"我的关注"
                                                                      titleText:@"我的关注"
                                                                  arrowImgNamed:@"Right arrow"];
    WYAMineCellModel * model3 = [WYAMineCellModel mineCellModelWithIconImgNamed:@"我的下载"
                                                                      titleText:@"我的下载"
                                                                  arrowImgNamed:@"Right arrow"];
    WYAMineCellModel * model4 = [WYAMineCellModel mineCellModelWithIconImgNamed:@"意见反馈"
                                                                      titleText:@"意见反馈"
                                                                  arrowImgNamed:@"Right arrow"];
    WYAMineCellModel * model5 = [WYAMineCellModel mineCellModelWithIconImgNamed:@"设置"
                                                                      titleText:@"设置"
                                                                  arrowImgNamed:@"Right arrow"];
    
    return @[@[model1,model2],@[model3,model4],@[model5]];
}
@end
