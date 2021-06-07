//
//  DPSIMSocketManager.m
//  DPSIMSDK
//
//  Created by ZH on 2021/6/1.
//

#import "DPSIMSocketManager.h"
#import "Person.pbobjc.h"


#define socketHost @"192.168.0.43"
#define socketPort 8211



@interface DPSIMSocketManager () <GCDAsyncSocketDelegate>

@property (nonatomic, strong)GCDAsyncSocket *clientSocket;

@end


@implementation DPSIMSocketManager

/// 建立socket连接
- (void)socketConnect:(void(^)(int code, NSDictionary *resultDic))block{
    NSLog(@"开始连接socket");
    self.connectBlock = block;
    // 创建socket
    if (self.clientSocket == nil){
        self.clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    [self.clientSocket connectToHost:socketHost onPort:socketPort error:nil];
}

/// 断开socket连接
- (void)socketDisConnect{
    [self.clientSocket disconnect];
    self.clientSocket = nil;
}

/// 发送消息
- (void)sendMessage:(NSString *)message withBlock:(void(^)(int code, NSDictionary *resultDic))sendMsgBlock{
    
    // 下面这是传递字符串的
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    [self.clientSocket writeData:data withTimeout:-1 tag:0];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"send message success" forKey:@"msg"];
    [dic setObject:message forKey:@"MsgContent"];
    sendMsgBlock(1, dic);
    
    
    
    
    
    
    // 下面这是通过protobuf协议传递数据的 (通过probuf协议传输的时候就打开下面的注释 by zh 2020.5.7)
//    Person *person = [[Person alloc]init];
//    person.age = 13;
//    person.username = @"zh";
//    person.phone = @"123456";
//    NSData *data1 = [person data];
//    [self.clientSocket writeData:data1 withTimeout:-1 tag:0];
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
//    [dic setObject:@"send message success" forKey:@"msg"];
//    Person *p = [Person parseFromData:data1 error:nil]; // data1模拟为服务端传递过来的, 模拟解码
//    [dic setObject:p forKey:@"MsgContent"];
//    sendMsgBlock(1, dic);

}

/// 接收到的消息
- (void)didReceivedMessage:(void(^)(int code, NSDictionary *resultDic))receivedMsgBlock{
    self.receiveBlock = receivedMsgBlock;
}





#pragma mark - GCDAsyncSocketDelegate
// 已经连接到服务器
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(nonnull NSString *)host port:(uint16_t)port{
    NSLog(@"连接成功, 服务器ip:%@, 端口:%d", host, port);
    [self.clientSocket readDataWithTimeout:-1 tag:0];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"socket connect success" forKey:@"msg"];
    [dic setObject:host forKey:@"host"];
    [dic setObject:[NSString stringWithFormat:@"%d", port] forKey:@"port"];
    self.connectBlock(1, dic);
}

// 连接断开
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    NSLog(@"断开socket连接 原因:%@",err);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"socket disConnect" forKey:@"msg"];
    [dic setObject:err forKey:@"error"];
    self.connectBlock(-1, dic);
}

// 已经接收服务器返回来的数据
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSLog(@"客户端接收到数据tag=%ld 长度:%ld ",tag,data.length);
    
    NSString *text = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"客户端接收到的text为--%@", text);
    //连接成功或者收到消息，必须开始read，否则将无法收到消息
    //不read的话，缓存区将会被关闭
    // -1 表示无限时长 ， tag
    [self.clientSocket readDataWithTimeout:-1 tag:0];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"received message success" forKey:@"msg"];
    [dic setObject:text forKey:@"MsgContent"];
    if (self.receiveBlock) {
        self.receiveBlock(1, dic);
    }
}

// 消息发送成功
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"客户端发送数据成功 - tag是%ld ",tag);
}


@end
