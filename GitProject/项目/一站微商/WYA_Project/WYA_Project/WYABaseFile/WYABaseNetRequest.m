//
//  NetRequest.m
//  CustomHUD
//
//  Created by lishihang on 18/03/28.
//  Copyright © 2018年 lishihang. All rights reserved.
//

#import "WYABaseNetRequest.h"
#import "WYALoginVC.h"

//默认网络请求时间
static const NSUInteger kDefaultTimeoutInterval = 6;

@implementation WYABaseNetRequest

+(AFHTTPSessionManager *)AFManager
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    // 超过时间
    manager.requestSerializer.timeoutInterval = kDefaultTimeoutInterval;
    
    // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
    
    // 声明获取到的数据格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
    //        manager.responseSerializer = [AFJSONResponseSerializer serializer]; // AFN会JSON解析返回的数据
    // 个人建议还是自己解析的比较好，有时接口返回的数据不合格会报3840错误，大致是AFN无法解析返回来的数据
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain",@"text/xml", nil];
    return manager;
}


+ (void)GetWithUrl:(NSString *)urlString
            Params:(NSMutableDictionary *)params
           Success:(Success)success
              Fail:(Fail)fail
{
    
    AFHTTPSessionManager *manager = [self AFManager];
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * token = [userDefaults objectForKey:@"access_token"];
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:params];
    if (token) {
        [dic setObject:token forKey:@"access_token"];
    }
    
    [manager GET:urlString parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        id status = jsonObj[@"status"];
        if ([status isKindOfClass:[NSNumber class]]) {
            float statusFloat = [status floatValue];
            if (statusFloat == -1) {
                [WYAShowMessageView showToastAWithMessage:@"登录信息已失效，请重新登录"];
                WYALoginVC * login = [[WYALoginVC alloc]init];
                Window.rootViewController = login;
            }else{
                success(jsonObj);
            }
        }else if ([status isKindOfClass:[NSString class]]) {
            if ([status isEqualToString:@"-1"]) {
                [WYAShowMessageView showToastAWithMessage:@"登录信息已失效，请重新登录"];
                WYALoginVC * login = [[WYALoginVC alloc]init];
                Window.rootViewController = login;
            }else{
                success(jsonObj);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        fail(code104, error.localizedDescription);
        
    }];

}

+ (void)PostWithUrl:(NSString *)urlString
             Params:(NSMutableDictionary *)params
            Success:(Success)success
               Fail:(Fail)fail
{
    
    AFHTTPSessionManager *manager = [self AFManager];
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * token = [userDefaults objectForKey:@"access_token"];
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:params];
    if (token) {
        [dic setObject:token forKey:@"access_token"];
    }
    
    [manager POST:urlString parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        id status = jsonObj[@"status"];
        if ([status isKindOfClass:[NSNumber class]]) {
            float statusFloat = [status floatValue];
            if (statusFloat == -1) {
                [WYAShowMessageView showToastAWithMessage:@"登录信息已失效，请重新登录"];
                WYALoginVC * login = [[WYALoginVC alloc]init];
                Window.rootViewController = login;
            }else{
                success(jsonObj);
            }
        }else if ([status isKindOfClass:[NSString class]]) {
            if ([status isEqualToString:@"-1"]) {
                [WYAShowMessageView showToastAWithMessage:@"登录信息已失效，请重新登录"];
                WYALoginVC * login = [[WYALoginVC alloc]init];
                Window.rootViewController = login;
            }else{
                success(jsonObj);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        fail(code104, error.localizedDescription);
        
    }];

}



+ (void)UploadImageWithUrl:(NSString *)urlString
                    params:(NSMutableDictionary *)params
                    Images:(NSArray *)images
                  progress:(Progress)progress
                   Success:(Success)success
                      Fail:(Fail)fail
{
    AFHTTPSessionManager * manager = [self AFManager];
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * token = [userDefaults objectForKey:@"access_token"];
    NSString * string;
    if (token) {
        string = [NSString stringWithFormat:@"%@?access_token=%@&action=uploadimage&encode=utf-8&code=yzws&type=base64",urlString,token];
    }else{
        string = urlString;
    }
    
    [manager POST:string parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i<images.count; i++) {
            
            UIImage * image = images[i];
            
            //转PNG
//            NSData *data =UIImagePNGRepresentation(image);
            
            //转JPEG
            NSData * data = UIImageJPEGRepresentation(image, 0.6);
            
            //拼接数据到请求题中
            [formData appendPartWithFileData:data name:@"Filedata" fileName:[NSString stringWithFormat:@"shop_logo.png"] mimeType:@"image/jpeg"];
        }
        
        /******** 2.通过路径上传沙盒或系统相册里的图片 *****/
        //        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"文件地址"] name:@"file" fileName:@"1234.png" mimeType:@"application/octet-stream" error:nil];
        
        NSLog(@"formdata==%@",formData);
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        // 打印上传进度
        //NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        
        progress(1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
//        NSLog(@"%@", jsonObj);
//        NSLog(@"%@", responseObject);
//        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"responseString: %@", responseString);
//        NSMutableString * str = [NSMutableString stringWithString:responseString];
//        NSString * dicStr = [NSString stringWithFormat:@"%@}",[[str componentsSeparatedByString:@"}"]  firstObject]];
//        NSLog(@"responseStr: %@", str);
        
        success(jsonObj);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        fail(code104, error.localizedDescription);
        
    }];
    
}

+ (void)UploadVideoWithUrl:(NSString *)urlString
                    Params:(NSMutableDictionary *)params
                    Videos:(NSMutableArray *)videos
                      Keys:(NSArray *)keys
                   Success:(Success)success
                      Fail:(Fail)fail
{
    
}

+ (NSURLSessionDownloadTask *)DownLoadFileWithUrl:(NSString *)urlString
                                           Params:(NSMutableDictionary *)params
                                         FilePath:(NSString *)filePath
                                         progress:(Progress)progress
                                          Success:(Success)success
                                             Fail:(Fail)fail
{
    AFHTTPSessionManager * manager = [self AFManager];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    NSURLRequest * reuqest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLSessionDownloadTask * downloadTask =[manager downloadTaskWithRequest:reuqest progress:^(NSProgress * _Nonnull downloadProgress) {
        float number = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        NSLog(@"number==%f",number);
        progress(number);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {

        NSLog(@"jsonobj==%@",response);
        NSLog(@"error==%@",error);
        NSLog(@"filep==%@",filePath);
        if (error) {
            fail(code104, @"下载失败");
        }else{
            success(@"下载成功");

        }

    }];
    
    return downloadTask;
    
}

@end
