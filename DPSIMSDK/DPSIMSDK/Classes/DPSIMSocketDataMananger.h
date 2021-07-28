//
//  DPSIMSocketDataMananger.h
//  DPSIMSDK
//
//  Created by ZH on 2021/6/22.
//

#import <Foundation/Foundation.h>
#import "login.pbobjc.h"
#import "GCDAsyncSocket.h"

NS_ASSUME_NONNULL_BEGIN

@interface DPSIMSocketDataMananger : NSObject

/// 封包
+ (NSMutableData *)calculatorData:(CMD_ID)type bodyData:(NSData *)bodyData maxM:(int)maxM;

///// 解包
//+ (void)unravelData:(NSData *)data socket:(GCDAsyncSocket *)socket;
@end

NS_ASSUME_NONNULL_END
