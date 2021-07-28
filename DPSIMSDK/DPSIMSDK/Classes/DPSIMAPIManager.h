//
//  DPSIMAPIManager.h
//  DPSIMSDK
//
//  Created by ZH on 2021/6/1.
//

#import "DPSIMSingleton.h"
#import "DPSIMSocketManager.h"


NS_ASSUME_NONNULL_BEGIN

@interface DPSIMAPIManager : DPSIMSingleton
/// sdk初始化
- (void)initSDK:(void(^)(int code, NSDictionary *resultDic))block;

/// 建立socket连接
- (void)socketConnectWithHost:(NSString *)Host Port:(uint16_t)Port block:(void(^)(int code, NSDictionary *resultDic))block;

/// 建立socket连接(json方式)
- (void)connect:(NSString *)para block:(void(^)(int code, NSDictionary *resultDic))block;

/// 登录
- (void)login:(NSString *)para block:(void(^)(int code, NSDictionary *resultDic))loginBlock;

/// 退出登录
- (void)logout:(NSString *)para block:(void(^)(int code, NSDictionary *resultDic))logoutBlock;

/// 接收到的消息
- (void)didReceivedMessage:(void(^)(int code, NSDictionary *resultDic))receivedMsgBlock;

/// 发送私聊消息
- (void)sendMessage:(NSString *)message withBlock:(void(^)(int code, NSDictionary *resultDic))sendMsgBlock;

/// 发送群聊消息
- (void)sendGroupMsg:(NSString *)message withBlock:(void(^)(int code, NSDictionary *resultDic))sendGroupMsgBlock;

@end

NS_ASSUME_NONNULL_END
