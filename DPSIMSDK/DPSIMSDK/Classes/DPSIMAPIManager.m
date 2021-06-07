//
//  DPSIMAPIManager.m
//  DPSIMSDK
//
//  Created by ZH on 2021/6/1.
//

#import "DPSIMAPIManager.h"

@implementation DPSIMAPIManager

- (void)initSDK{

    [[DPSIMSocketManager sharedInstance] socketConnect:^(int code, NSDictionary * _Nonnull resultDic) {
        NSLog(@"code--%d, result--%@", code, resultDic);
    }];
}
- (void)sendMessage:(NSString *)message withBlock:(void(^)(int code, NSDictionary *resultDic))sendMsgBlock{
    [[DPSIMSocketManager sharedInstance] sendMessage:message withBlock:sendMsgBlock];
}

/// 接收到的消息
- (void)didReceivedMessage:(void(^)(int code, NSDictionary *resultDic))receivedMsgBlock{
    [[DPSIMSocketManager sharedInstance] didReceivedMessage:receivedMsgBlock];
}

@end
