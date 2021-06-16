//
//  DPSIMUserDefaults.h
//  DPSIMSDK
//
//  Created by ZH on 2021/6/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DPSIMUserDefaults : NSObject
/// 存储token
+ (void)setToken:(NSString *)tokenStr;

/// 获取token
+ (NSString *)getToken;

/// 移除token
+ (void)removeToken;

@end

NS_ASSUME_NONNULL_END
