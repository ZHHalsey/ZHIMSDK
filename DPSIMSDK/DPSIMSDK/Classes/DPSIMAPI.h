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
 *  @param block                回调block
 */
+ (void)initSDK:(void(^)(int code, NSDictionary *resultDic))block;

/**
 *  @brief                      建立socket连接
 *  @param Host                 ip地址
 *  @param Port                 端口
 *  @param block                回调block
 */
+ (void)socketConnectWithHost:(NSString *)Host Port:(uint16_t)Port block:(void(^)(int code, NSDictionary *resultDic))block;
/**
 *  @brief                      建立socket连接
 *  @param para                 含ip地址和端口的json串
 *  @param block                回调block
 */
+ (void)connect:(NSString *)para block:(void(^)(int code, NSDictionary *resultDic))block;
/**
 *  @brief                      登录
 *  @param para                 含登录信息的json串
 *  @param loginBlock           回调block
 */
+ (void)login:(NSString *)para block:(void(^)(int code, NSDictionary *resultDic))loginBlock;

/**
 *  @brief                      登出
 *  @param para                 含登出信息的json串
 *  @param logoutBlock          回调block
 */
+ (void)logout:(NSString *)para block:(void(^)(int code, NSDictionary *resultDic))logoutBlock;

/**
 *  @brief                      接收消息
 *  @param receivedMsgBlock     回调block
 */
+ (void)didReceivedMessage:(void(^)(int code, NSDictionary *resultDic))receivedMsgBlock;

/**
 *  @brief                      发送私聊消息
 *  @param message              发送的消息文本
 *  @param sendMsgBlock         回调block
 */
+ (void)sendMessage:(NSString *)message withBlock:(void(^)(int code, NSDictionary *resultDic))sendMsgBlock;

/**
 *  @brief                      发送群聊消息
 *  @param message              发送的消息文本
 *  @param sendGroupMsgBlock    回调block
 */
+ (void)sendGroupMsg:(NSString *)message withBlock:(void(^)(int code, NSDictionary *resultDic))sendGroupMsgBlock;

@end

NS_ASSUME_NONNULL_END
