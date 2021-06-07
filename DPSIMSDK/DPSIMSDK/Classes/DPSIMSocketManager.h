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


@interface DPSIMSocketManager : DPSIMSingleton
@property (nonatomic, copy)socketConnectBlock connectBlock;
@property (nonatomic, copy)receivedMsgBlock receiveBlock;
/// 建立socket连接
- (void)socketConnect:(void(^)(int code, NSDictionary *resultDic))block;

/// 断开socket连接
- (void)socketDisConnect;

/// 发送消息
- (void)sendMessage:(NSString *)message withBlock:(void(^)(int code, NSDictionary *resultDic))sendMsgBlock;

/// 接收到的消息
- (void)didReceivedMessage:(void(^)(int code, NSDictionary *resultDic))receivedMsgBlock;


@end

NS_ASSUME_NONNULL_END
