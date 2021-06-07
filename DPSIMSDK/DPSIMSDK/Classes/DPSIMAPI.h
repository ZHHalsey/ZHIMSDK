//
//  DPSIMAPI.h
//  DPSIMSDK
//
//  Created by ZH on 2021/5/31.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface DPSIMAPI : NSObject

/// 接口test
+ (void)testLog;

/// 初始化sdk
+ (void)initSDK;

/// 发送消息
+ (void)sendMessage:(NSString *)message withBlock:(void(^)(int code, NSDictionary *resultDic))sendMsgBlock;

/// 接收到的消息
+ (void)didReceivedMessage:(void(^)(int code, NSDictionary *resultDic))receivedMsgBlock;

@end

NS_ASSUME_NONNULL_END
