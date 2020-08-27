//
//  WYAArticleDetailModel.h
//  WYA_Project
//
//  Created by 李俊恒 on 2018/4/13.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYAArticleDetailModel : NSObject
@property(nonatomic, copy) NSString * article_id;
@property(nonatomic, copy) NSString * teacher_id;
@property(nonatomic, copy) NSString * article_title;
@property(nonatomic, copy) NSString * pv;// 浏览量
@property(nonatomic, copy) NSString * content;
@property(nonatomic, copy) NSString * create_time;//发布时间
@property(nonatomic, copy) NSString * teacher_name;
@property(nonatomic, strong) NSString * is_attention;
@property(nonatomic, strong) NSString * is_thumb;//是否点赞该文章
@property(nonatomic, strong) NSString * is_collection;// 是否收藏该文章
+ (instancetype)articleDetailWith:(id)respone;
@end
