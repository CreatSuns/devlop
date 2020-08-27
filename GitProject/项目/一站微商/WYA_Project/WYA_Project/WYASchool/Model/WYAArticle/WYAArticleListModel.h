//
//  WYAArticleListModel.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/9.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYAArticleListModel : NSObject
@property(nonatomic, copy) NSString * article_id;//文章id
@property(nonatomic, copy) NSString * article_title;//文章名称
@property(nonatomic, copy) NSString * artic_img;// 文章封面url
@property(nonatomic, copy) NSString * pv;// 浏览量
@property(nonatomic, copy) NSString * url;//下载专区文章的url
@property(nonatomic, copy) NSString * ext;//下载文章专区的文章后缀
@property(nonatomic, copy) NSString * count_thumb;// 点赞数
@property(nonatomic, copy) NSString * count_collection;//收藏数
@property(nonatomic, copy) NSString * download_status;//文章下载状态（汉字）
@property(nonatomic, copy) NSString * download_status_id;//文章下载状态（数字）
@property(nonatomic, copy) NSString * teacher_name;
@property(nonatomic, copy) NSString * count;
+ (NSMutableArray *)articleListModelWith:(id)response;
+ (NSMutableArray *)searchArticleModelWith:(id)resulte;
@end
