//
//  DPSIMSocketDataMananger.m
//  DPSIMSDK
//
//  Created by ZH on 2021/6/22.
//

#import "DPSIMSocketDataMananger.h"

@implementation DPSIMSocketDataMananger

/// 封包
+ (NSMutableData *)calculatorData:(CMD_ID)type bodyData:(NSData *)bodyData maxM:(int)maxM{
    // 前四位消息总长度，在四位消息id type，最后消息体
    NSMutableData *needSendData = [NSMutableData data];
    Byte resultByte[4] = {0};
    int lenth = (int)bodyData.length + 8;
    int typeInt = (int)type;
    [needSendData appendBytes:intTobytes(lenth, resultByte) length:4];
    [needSendData appendBytes:intTobytes(typeInt, resultByte) length:4];
    [needSendData appendData:bodyData];
    return needSendData;
}

///// 解包
//+ (void)unravelData:(NSData *)data socket:(GCDAsyncSocket *)socket{
//    // 头
//    int length = bytesToint((void *)[[data subdataWithRange:NSMakeRange(0, 4)] bytes]);
//    int type = bytesToint((void *)[[data subdataWithRange:NSMakeRange(4, 4)] bytes]);
//    // 消息体
//    NSData *contentData = [data subdataWithRange:NSMakeRange(8, length - 8)];
//    NSLog(@"11取到的长度--%d, 类型--%d", length, type);
//    NSError *error = nil;
//    if (type == 1002) { // 登录返回
//        S2CLoginMsg *loginMsgModel = [S2CLoginMsg parseFromData:contentData error:&error];
//        NSLog(@"111loginMsgModel - %@", loginMsgModel);
//        NSLog(@"222loginMsgModel--code:%d msg:%@ playerId:%lld", loginMsgModel.code, loginMsgModel.msg, loginMsgModel.playerId);
//
//    }else if (type == 1004){ // 心跳返回
//        S2CPongMsg *currentTime = [S2CPongMsg parseFromData:contentData error:&error];
//        NSLog(@"心跳收到返回数据cuttTime--%lld", currentTime.timeCurr);
//    }
//}



#pragma mark - Private method
/**
 将int转换为byte数组
 @param a int数据
 @param aResult 放到哪个byte数组中
 @return byte数组
 */
unsigned char* intTobytes(int a,unsigned char* aResult) {
    unsigned char * result = aResult;
    result[3] = (unsigned char)(a &0xff);
    result[2] = (unsigned char)(a >> 8 &0xff);
    result[1] = (unsigned char)(a >> 16 &0xff);
    result[0] = (unsigned char)(a >> 24 &0xff);
    return result;
}


///**
// bytes转成成int
// @param aDes 需要转换的bytes
// @return int结果
// */
//int bytesToint(unsigned char* aDes) {
//    int result;
//    result = (aDes[0] & 0xff) << 24
//    | (aDes[1] & 0xff) << 16
//    | (aDes[2] & 0xff) << 8
//    | (aDes[3] & 0xff) << 0;
//    return result;
//}


@end
