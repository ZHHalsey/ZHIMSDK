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

/**
 *  @brief                      初始化sdk
 */
+ (void)initSDK;

/**
 *  @brief                      发送消息
 *  @param message              发送的消息文本
 *  @param sendMsgBlock         回调block
 */
+ (void)sendMessage:(NSString *)message withBlock:(void(^)(int code, NSDictionary *resultDic))sendMsgBlock;

/**
 *  @brief                      接收消息
 *  @param receivedMsgBlock     回调block
 */
+ (void)didReceivedMessage:(void(^)(int code, NSDictionary *resultDic))receivedMsgBlock;

@end

NS_ASSUME_NONNULL_END
