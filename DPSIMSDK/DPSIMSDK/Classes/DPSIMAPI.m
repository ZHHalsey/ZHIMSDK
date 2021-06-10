//
//  DPSIMAPI.m
//  DPSIMSDK
//
//  Created by ZH on 2021/5/31.
//

#import "DPSIMAPI.h"
#import "DPSIMAPIManager.h"


@implementation DPSIMAPI

// 接口test
+ (void)testLog{
    ZHLog(@"logTest----实时打印asd");
}

/// 初始化SDK
+ (void)initSDK{
    [[DPSIMAPIManager sharedInstance] initSDK];
}

/// 建立socket连接
+ (void)socketConnectWithHost:(NSString *)Host Port:(uint16_t)Port block:(void(^)(int code, NSDictionary *resultDic))block{
    [[DPSIMAPIManager sharedInstance]socketConnectWithHost:Host Port:Port block:block];
}

/// 发送消息
+ (void)sendMessage:(NSString *)message withBlock:(void(^)(int code, NSDictionary *resultDic))sendMsgBlock{
    [[DPSIMAPIManager sharedInstance] sendMessage:message withBlock:sendMsgBlock];
}

/// 接收到的消息
+ (void)didReceivedMessage:(void(^)(int code, NSDictionary *resultDic))receivedMsgBlock{
    [[DPSIMAPIManager sharedInstance] didReceivedMessage:receivedMsgBlock];
}

@end
