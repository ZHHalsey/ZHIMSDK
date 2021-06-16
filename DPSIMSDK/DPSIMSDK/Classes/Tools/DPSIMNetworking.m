//
//  DPSIMNetworking.m
//  DPSIMSDK
//
//  Created by ZH on 2021/6/16.
//

#import "DPSIMNetworking.h"

@implementation DPSIMNetworking

/// 1 > GET请求
+ (void)GETRequestWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void(^)(id requestData))success failure:(void(^)(NSError *error))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];

}

/// 2 > POST请求, 无请求头
+ (void)POSTRequestWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void(^)(id requestData))success failure:(void(^)(NSError *error))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer.timeoutInterval = 10; // 超时时间
    [manager POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//        success(responseObject);
        success(resultDic); // 这里返回的是解析后的字典
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        failure(error);
        
    }];

}


@end
