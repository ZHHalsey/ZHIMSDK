//
//  DPSIMSocketManager.h
//  DPSIMSDK
//
//  Created by ZH on 2021/6/1.
//

#import "DPSIMSingleton.h"
#import "GCDAsyncSocket.h"


NS_ASSUME_NONNULL_BEGIN


typedef void (^socketConnectBlock)(int code, NSDictionary *resultDic);
typedef void (^receivedMsgBlock)(int code, NSDictionary *resultDic);
typedef void (^sendGroupMsgBlock)(int code, NSDictionary *resultDic);
typedef void (^loginBlock)(int code, NSDictionary *resultDic);


@interface DPSIMSocketManager : DPSIMSingleton
@property (nonatomic, copy)socketConnectBlock connectBlock;
@property (nonatomic, copy)receivedMsgBlock receiveBlock;
@property (nonatomic, copy)sendGroupMsgBlock sendGroupBlock;
@property (nonatomic, copy)loginBlock loginBlock;
/// 建立socket连接
- (void)socketConnectWithHost:(NSString *)Host Port:(uint16_t)Port block:(void(^)(int code, NSDictionary *resultDic))block;

/// 建立socket连接(json方式)
- (void)connect:(NSString *)para block:(void(^)(int code, NSDictionary *resultDic))block;

/// 登录
- (void)login:(NSString *)para block:(void(^)(int code, NSDictionary *resultDic))loginBlock;

/// 退出登录
- (void)logout:(NSString *)para block:(void(^)(int code, NSDictionary *resultDic))logoutBlock;

/// 断开socket连接
- (void)socketDisConnect;

/// 发送心跳
- (void)sendHeartBeat;

/// 接收到的消息
- (void)didReceivedMessage:(void(^)(int code, NSDictionary *resultDic))receivedMsgBlock;

/// 发送私聊消息
- (void)sendMessage:(NSString *)message withBlock:(void(^)(int code, NSDictionary *resultDic))sendMsgBlock;

/// 发送群聊消息
- (void)sendGroupMsg:(NSString *)message withBlock:(void(^)(int code, NSDictionary *resultDic))sendGroupMsgBlock;

@end

NS_ASSUME_NONNULL_END
