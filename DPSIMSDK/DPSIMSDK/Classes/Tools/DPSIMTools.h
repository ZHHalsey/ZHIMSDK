//
//  DPSIMTools.h
//  DPSIMSDK
//
//  Created by ZH on 2021/6/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DPSIMTools : NSObject

/// 沙盒获取主目录
+ (NSString *)getHomePath;

/// 沙盒document路径
+ (NSString *)getDocumentPath;

/// 沙盒library路径
+ (NSString *)getLibraryPath;

/// 沙盒tmp路径
+ (NSString *)getTmpPath;

/// 获取devId
+ (NSString *)getDeviceId;

/// 获取当前时间戳
+ (int64_t)getCurrentTime;

/// 字典转Json串
+ (NSString *)dicToJsonStr:(NSDictionary *)dic;

/// Json串转字典
+ (NSDictionary *)jsonStrToDic:(NSString *)jsonStr;

@end

NS_ASSUME_NONNULL_END
