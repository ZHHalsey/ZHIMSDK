//
//  DPSIMAPIManager.m
//  DPSIMSDK
//
//  Created by ZH on 2021/6/1.
//

#import "DPSIMAPIManager.h"

@implementation DPSIMAPIManager

/// 初始化SDK
- (void)initSDK:(void(^)(int code, NSDictionary *resultDic))block{
    ZHLog(@"SDK初始化成功");
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"SDK init success" forKey:@"msg"];
    block(1, dic);

}

/// 建立socket连接
- (void)socketConnectWithHost:(NSString *)Host Port:(uint16_t)Port block:(void(^)(int code, NSDictionary *resultDic))block{
    [[DPSIMSocketManager sharedInstance] socketConnectWithHost:Host Port:Port block:block];
}

/// 建立socket连接(json形式)
- (void)connect:(NSString *)para block:(void(^)(int code, NSDictionary *resultDic))block;{
    [[DPSIMSocketManager sharedInstance] connect:para block:block];
}

/// 登录
- (void)login:(NSString *)para block:(void(^)(int code, NSDictionary *resultDic))loginBlock{
    [[DPSIMSocketManager sharedInstance] login:para block:loginBlock];
}

/// 登出
- (void)logout:(NSString *)para block:(void(^)(int code, NSDictionary *resultDic))logoutBlock{
    [[DPSIMSocketManager sharedInstance] logout:para block:logoutBlock];
}

/// 接收消息
- (void)didReceivedMessage:(void(^)(int code, NSDictionary *resultDic))receivedMsgBlock{
    [[DPSIMSocketManager sharedInstance] didReceivedMessage:receivedMsgBlock];
}

/// 发送私聊消息
- (void)sendMessage:(NSString *)message withBlock:(void(^)(int code, NSDictionary *resultDic))sendMsgBlock{
    [[DPSIMSocketManager sharedInstance] sendMessage:message withBlock:sendMsgBlock];
}

/// 发送群聊消息
- (void)sendGroupMsg:(NSString *)message withBlock:(void(^)(int code, NSDictionary *resultDic))sendGroupMsgBlock{
    [[DPSIMSocketManager sharedInstance] sendGroupMsg:message withBlock:sendGroupMsgBlock];
}


@end
