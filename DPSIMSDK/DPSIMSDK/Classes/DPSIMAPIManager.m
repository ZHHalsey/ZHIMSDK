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
        NSLog(@"socket连接 code--   %d, result--%@", code, resultDic);
    }];
}

- (void)sendMessage:(NSString *)message withBlock:(void(^)(int code, NSDictionary *resultDic))sendMsgBlock{
    [[DPSIMSocketManager sharedInstance] sendMessage:message withBlock:sendMsgBlock];
}

- (void)didReceivedMessage:(void(^)(int code, NSDictionary *resultDic))receivedMsgBlock{
    [[DPSIMSocketManager sharedInstance] didReceivedMessage:receivedMsgBlock];
}

@end
