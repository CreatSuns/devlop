//
//  WYAUrl.h
//  WYA_Project
//
//  Created by 李世航 on 2018/4/8.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#ifndef WYAUrl_h
#define WYAUrl_h


// 服务器
#define BaseUrl  @"https://app-wsapp.ruishan666.com/"

// 本地
//#define BaseUrl  @""

// 登录
#define LoginUrl  [NSString stringWithFormat:@"%@app/login",BaseUrl]

// 获取课程分类
#define CourseCategory  [NSString stringWithFormat:@"%@category/course-list",BaseUrl]

// 获取课程列表
#define CourseList  [NSString stringWithFormat:@"%@course/list",BaseUrl]


// 获取课程详情
#define CourseDetail  [NSString stringWithFormat:@"%@course/detail",BaseUrl]

// 收藏课程
#define CourseCollection  [NSString stringWithFormat:@"%@course/course-collection",BaseUrl]

// 更新学习进度
#define changeLearnTime  [NSString stringWithFormat:@"%@course/process-save",BaseUrl]

// 更新课程学习人数
#define addLearnPeople  [NSString stringWithFormat:@"%@course/learned-add",BaseUrl]

// 加入我的课表
#define addMyLearnCourse  [NSString stringWithFormat:@"%@course/add-to-schedule",BaseUrl]

// 章节下载
#define ChapterDownload  [NSString stringWithFormat:@"%@course/download-zone",BaseUrl]

// 改变下载状态
#define ChangeDownloadState  [NSString stringWithFormat:@"%@user-download/add-download",BaseUrl]

// 课程详情目录
#define CourseCatalog  [NSString stringWithFormat:@"%@course/menu",BaseUrl]

// 课程详情下载
#define CourseDownload  [NSString stringWithFormat:@"%@course/courseware-download",BaseUrl]

// 获取讲师列表

#define LecturerList [NSString stringWithFormat:@"%@teacher/list",BaseUrl]

// 获取讲师个人信息
#define LecturerDetail [NSString stringWithFormat:@"%@teacher/detail",BaseUrl]

// 获取讲师全部课程
#define LecturerAllCourse [NSString stringWithFormat:@"%@teacher/teacher-course",BaseUrl]

// 获取讲师全部课程
#define LecturerAllArticle [NSString stringWithFormat:@"%@teacher/teacher-article",BaseUrl]

// 关注/取消关注讲师
#define AttentionLecturer [NSString stringWithFormat:@"%@teacher/attention",BaseUrl]


// 搜索
#define SearchUrl [NSString stringWithFormat:@"%@course/search",BaseUrl]

// 提交反馈意见
#define SubmitOpinion [NSString stringWithFormat:@"%@test/feedback",BaseUrl]

// 获取文章分类
#define ArticleCategory [NSString stringWithFormat:@"%@category/article-list",BaseUrl]

// 获取文章列表article/list
#define ArticleList [NSString stringWithFormat:@"%@article/list",BaseUrl]

// 获取文章详情
#define ArticleDetail [NSString stringWithFormat:@"%@article/detail",BaseUrl]
// 点赞文章
#define ThumArticleDetail [NSString stringWithFormat:@"%@article/article-thumb",BaseUrl]
// 收藏文章
#define CollectionArticleDetail [NSString stringWithFormat:@"%@article/article-collection",BaseUrl]

// 获取我的课表
#define MyCoureseList [NSString stringWithFormat:@"%@user-chapter/time-table-list",BaseUrl]

// 新课上架
#define NewCourse [NSString stringWithFormat:@"%@course/new-stores",BaseUrl]

// 我的资料首页
#define AdminInfo [NSString stringWithFormat:@"%@user-chapter/admin-info",BaseUrl]

// 我的关注
#define Attention [NSString stringWithFormat:@"%@test/attention",BaseUrl]
// 取消关注
#define CancelAttention [NSString stringWithFormat:@"%@teacher/attention",BaseUrl]

// 我的收藏课程
#define MineCollectionCourse [NSString stringWithFormat:@"%@collection/collection-course",BaseUrl]

// 我的收藏文章
#define MineCollectionArticle [NSString stringWithFormat:@"%@collection/collection-article",BaseUrl]

// 删除我的收藏
#define DeleteMineCollection [NSString stringWithFormat:@"%@collection/del-collection",BaseUrl]

// 删除下载文件
#define MineDELDownload [NSString stringWithFormat:@"%@user-download/del-download",BaseUrl]

// 测试题
#define TestQuestion [NSString stringWithFormat:@"%@test/question",BaseUrl]
// 所有题号
#define TestAllQuestionNum [NSString stringWithFormat:@"%@test/answer",BaseUrl]
// 交卷
#define TestAssignment [NSString stringWithFormat:@"%@test/assignment",BaseUrl]

// 答题报告
#define TestPresentation [NSString stringWithFormat:@"%@test/presentation",BaseUrl]

// 详细答题报告
#define TestDetailPresentation [NSString stringWithFormat:@"%@test/presentation",BaseUrl]


// 错题解析
#define TestError_Analysis [NSString stringWithFormat:@"%@test/error-analysis",BaseUrl]

// 全部解析
#define TestAll_Analysis [NSString stringWithFormat:@"%@test/all-analysis",BaseUrl]

// 测试成绩
#define TestScorse [NSString stringWithFormat:@"%@test/list",BaseUrl]

// 所有人员和章节
#define AllPeopleAndChapter [NSString stringWithFormat:@"%@test/search",BaseUrl]

// 测试试卷
#define TestPaper [NSString stringWithFormat:@"%@test/paper",BaseUrl]

// 我的下载
#define MineDownload [NSString stringWithFormat:@"%@test/download",BaseUrl]

// 上传图片
#define UploadHeaderImage [NSString stringWithFormat:@"%@uploadfile/upimg",BaseUrl]

// 上传图片字符串
#define UploadHeaderImageString [NSString stringWithFormat:@"%@user-chapter/update-shop-logo",BaseUrl]

// 修改用户昵称
#define UpdateNickName [NSString stringWithFormat:@"%@user-chapter/update-account",BaseUrl]

// 修改密码
#define ChangePassword [NSString stringWithFormat:@"%@user-chapter/update-pwd",BaseUrl]

#endif /* WYAUrl_h */
