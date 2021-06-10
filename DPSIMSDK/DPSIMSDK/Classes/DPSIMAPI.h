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
 *  @brief                      建立socket连接
 *  @param Host                 ip地址
 *  @param Port                 端口
 *  @param block                回调block
 */
+ (void)socketConnectWithHost:(NSString *)Host Port:(uint16_t)Port block:(void(^)(int code, NSDictionary *resultDic))block;

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
