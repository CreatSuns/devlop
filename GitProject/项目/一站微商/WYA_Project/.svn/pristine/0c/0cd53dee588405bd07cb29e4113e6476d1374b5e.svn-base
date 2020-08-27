//
//  WYAArticleNetRequest.m
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/9.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "WYAArticleNetRequest.h"
#import "WYAArticleCategory.h"
#import "WYAArticleListModel.h"
#import "WYAArticleDetailModel.h"
@implementation WYAArticleNetRequest
- (void)loadArticlCategoryWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail
{
    [WYAArticleNetRequest GetWithUrl:ArticleCategory Params:params Success:^(id data) {
        NSLog(@"文章分类data==%@",data);
        NSMutableArray * array = [NSMutableArray array];
        array = [WYAArticleCategory articleCategoryModelWith:data];
        success(array);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
- (void)loadArticlListWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail
{
    [WYAArticleNetRequest GetWithUrl:ArticleList Params:params Success:^(id data) {
         NSLog(@"文章listdata==%@",data);
        NSMutableArray * array = [NSMutableArray array];
        array = [WYAArticleListModel articleListModelWith:data];
        success(array);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
- (void)loadArticlDetailWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail
{
    [WYAArticleNetRequest GetWithUrl:ArticleDetail Params:params Success:^(id data) {
        WYAArticleDetailModel * model = [WYAArticleDetailModel articleDetailWith:data];
        success(model);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {

    }];
}
- (void)thumArticlDetailWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail
{
    [WYAArticleNetRequest GetWithUrl:ThumArticleDetail Params:params Success:^(id data) {
        success(data);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
- (void)collectionArticlDetailWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail
{
    [WYAArticleNetRequest GetWithUrl:CollectionArticleDetail Params:params Success:^(id data) {
        success(data);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
- (void)focusTeacherWithParams:(NSMutableDictionary *)params Success:(Success)success Fail:(Fail)fail
{
    [WYAArticleNetRequest GetWithUrl:CancelAttention Params:params Success:^(id data) {
        success(data);
    } Fail:^(NetRequestCode netCode, NSString *errorDes) {
        
    }];
}
@end
