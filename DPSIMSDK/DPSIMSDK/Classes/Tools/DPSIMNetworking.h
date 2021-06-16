//
//  DPSIMNetworking.h
//  DPSIMSDK
//
//  Created by ZH on 2021/6/16.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface DPSIMNetworking : NSObject

/// 1 > GET请求
+ (void)GETRequestWithUrl:(NSString *)urlStr
               parameters:(id)parameters
                  success:(void(^)(id requestData))success
                  failure:(void(^)(NSError *error))failure;

/// 2 > POST请求, 无请求头
+ (void)POSTRequestWithUrl:(NSString *)urlStr
                parameters:(id)parameters
                   success:(void(^)(id requestData))success
                   failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
