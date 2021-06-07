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
    NSLog(@"logTest----实时打印asd");
}

+ (void)initSDK{
    [[DPSIMAPIManager sharedInstance] initSDK];
}

+ (void)sendMessage:(NSString *)message withBlock:(void(^)(int code, NSDictionary *resultDic))sendMsgBlock{
    [[DPSIMAPIManager sharedInstance] sendMessage:message withBlock:sendMsgBlock];
}

/// 接收到的消息
+ (void)didReceivedMessage:(void(^)(int code, NSDictionary *resultDic))receivedMsgBlock{
    [[DPSIMAPIManager sharedInstance] didReceivedMessage:receivedMsgBlock];
}

@end
