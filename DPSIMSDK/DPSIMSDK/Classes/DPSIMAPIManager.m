//
//  DPSIMAPIManager.m
//  DPSIMSDK
//
//  Created by ZH on 2021/6/1.
//

#import "DPSIMAPIManager.h"

@implementation DPSIMAPIManager

/// 初始化SDK
- (void)initSDK{
    ZHLog(@"SDK初始化成功");
}

/// 建立socket连接
- (void)socketConnectWithHost:(NSString *)Host Port:(uint16_t)Port block:(void(^)(int code, NSDictionary *resultDic))block{
    [[DPSIMSocketManager sharedInstance] socketConnectWithHost:Host Port:Port block:block];
}

/// 发送消息
- (void)sendMessage:(NSString *)message withBlock:(void(^)(int code, NSDictionary *resultDic))sendMsgBlock{
    [[DPSIMSocketManager sharedInstance] sendMessage:message withBlock:sendMsgBlock];
}

/// 接收消息
- (void)didReceivedMessage:(void(^)(int code, NSDictionary *resultDic))receivedMsgBlock{
    [[DPSIMSocketManager sharedInstance] didReceivedMessage:receivedMsgBlock];
}

@end
