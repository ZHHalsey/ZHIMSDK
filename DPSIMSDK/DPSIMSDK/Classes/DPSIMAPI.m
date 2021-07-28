//
//  DPSIMAPI.m
//  DPSIMSDK
//
//  Created by ZH on 2021/5/31.
//

#import "DPSIMAPI.h"
#import "DPSIMAPIManager.h"


@implementation DPSIMAPI

/// 接口test
+ (void)testLog{
    ZHLog(@"logTest----实时打印asd");
}

/// 初始化SDK
+ (void)initSDK:(void(^)(int code, NSDictionary *resultDic))block{
    [[DPSIMAPIManager sharedInstance] initSDK:block];
}

/// 建立socket连接
+ (void)socketConnectWithHost:(NSString *)Host Port:(uint16_t)Port block:(void(^)(int code, NSDictionary *resultDic))block{
    [[DPSIMAPIManager sharedInstance] socketConnectWithHost:Host Port:Port block:block];
}

/// 建立socket连接(json形式)
+ (void)connect:(NSString *)para block:(void(^)(int code, NSDictionary *resultDic))block{
    [[DPSIMAPIManager sharedInstance] connect:para block:block];
}

/// 登录
+ (void)login:(NSString *)para block:(void(^)(int code, NSDictionary *resultDic))loginBlock{
    [[DPSIMAPIManager sharedInstance] login:para block:loginBlock];
}

/// 登出
+ (void)logout:(NSString *)para block:(void(^)(int code, NSDictionary *resultDic))logoutBlock{
    [[DPSIMAPIManager sharedInstance] logout:para block:logoutBlock];
}

/// 接收到的消息
+ (void)didReceivedMessage:(void(^)(int code, NSDictionary *resultDic))receivedMsgBlock{
    [[DPSIMAPIManager sharedInstance] didReceivedMessage:receivedMsgBlock];
}

/// 发送私聊消息
+ (void)sendMessage:(NSString *)message withBlock:(void(^)(int code, NSDictionary *resultDic))sendMsgBlock{
    [[DPSIMAPIManager sharedInstance] sendMessage:message withBlock:sendMsgBlock];
}

/// 发送群聊消息
+ (void)sendGroupMsg:(NSString *)message withBlock:(void(^)(int code, NSDictionary *resultDic))sendGroupMsgBlock{
    [[DPSIMAPIManager sharedInstance] sendGroupMsg:message withBlock:sendGroupMsgBlock];
}


@end
