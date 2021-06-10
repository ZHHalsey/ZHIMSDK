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
- (void)initSDK;

/// 建立socket连接
- (void)socketConnectWithHost:(NSString *)Host Port:(uint16_t)Port block:(void(^)(int code, NSDictionary *resultDic))block;

/// 发送消息
- (void)sendMessage:(NSString *)message withBlock:(void(^)(int code, NSDictionary *resultDic))sendMsgBlock;

/// 接收到的消息
- (void)didReceivedMessage:(void(^)(int code, NSDictionary *resultDic))receivedMsgBlock;

@end

NS_ASSUME_NONNULL_END
