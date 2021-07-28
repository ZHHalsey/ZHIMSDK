//
//  DPSIMSocketManager.m
//  DPSIMSDK
//
//  Created by ZH on 2021/6/1.
//

#import "DPSIMSocketManager.h"
#import "login.pbobjc.h"
#import "Chat.pbobjc.h"
#import "Serv.pbobjc.h"
#import "Channel.pbobjc.h"
#import "DPSIMMessageModel.h"
#import "DPSIMSocketDataMananger.h"
#import "DPSIMMessageModel.h"


#define socketHost @"192.168.0.43"
#define socketPort 8211
#define HeartBeatID  @"beatID"    //心跳标识
static int64_t playerId = 1418034067206574082;





@interface DPSIMSocketManager () <GCDAsyncSocketDelegate>

@property (nonatomic, strong)GCDAsyncSocket *clientSocket;
@property (nonatomic, strong)dispatch_source_t beatTimer;
@property (nonatomic, strong)NSMutableData *allData; // 缓存data
@property (nonatomic, assign)int allLength;
@property (nonatomic, assign)int chatType;
@property (nonatomic, assign)BOOL isFirst; // 每个数据包请求是否是第一次读到数据
@property (nonatomic, copy)NSString *host;
@property (nonatomic, assign)uint16_t  port;


@end


@implementation DPSIMSocketManager

/// 建立socket连接
- (void)socketConnectWithHost:(NSString *)Host Port:(uint16_t)Port block:(void(^)(int code, NSDictionary *resultDic))block{
    NSLog(@"开始连接socket,ip地址:%@, 端口:%d", Host, Port);
    self.allData = [[NSMutableData alloc] init];
    self.isFirst = YES;
    self.host = Host;
    self.port = Port;
    self.connectBlock = block;
    
    // 创建socket
    if (self.clientSocket == nil){
        self.clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    [self.clientSocket connectToHost:Host onPort:Port error:nil];
}

/// 建立socket连接(json形式)
- (void)connect:(NSString *)para block:(void(^)(int code, NSDictionary *resultDic))block{
    // json串转dic
    NSDictionary *jsonDic =[DPSIMTools jsonStrToDic:para];
    NSLog(@"jsonDic--%@", jsonDic);

    self.allData = [[NSMutableData alloc] init];
    self.isFirst = YES;
    self.host = [jsonDic objectForKey:@"host"];
    self.port = [[jsonDic objectForKey:@"port"] intValue];
    self.connectBlock = block;

    NSLog(@"json方式开始连接socket,ip地址:%@, 端口:%d", [jsonDic objectForKey:@"host"], [[jsonDic objectForKey:@"port"] intValue]);
    // 创建socket
    if (self.clientSocket == nil){
        self.clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    [self.clientSocket connectToHost:self.host onPort:self.port error:nil];
    
    [self sendHeartBeat]; // 心跳放到连接成功之后
}

/// 断开socket连接
- (void)socketDisConnect{
    NSLog(@"sdk--socketDisConnect");
    [self.clientSocket disconnect];
    dispatch_source_cancel(self.beatTimer); // 关闭心跳定时器
    self.clientSocket = nil;
}

/// 发送心跳(登录成功后)
- (void)sendHeartBeat{

    if (!self.beatTimer) {
            dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
            self.beatTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC));
            uint64_t interval = (uint64_t)(30 * NSEC_PER_SEC); // 每隔30秒调用一次
            dispatch_source_set_timer(self.beatTimer, start, interval, 0);
            dispatch_source_set_event_handler(self.beatTimer, ^{
                if ([self.clientSocket isConnected]) {
                    NSLog(@"socket连接着呢");
                }else{
                    NSLog(@"socket断开着呢");
                    [self.clientSocket connectToHost:self.host onPort:self.port error:nil];
                }

                C2SPingMsg *pingModel = [[C2SPingMsg alloc] init];
//                NSLog(@"当前时间戳--%lld", [DPSIMTools getCurrentTime]);
                pingModel.timeCurr = [DPSIMTools getCurrentTime];
                NSData *data = pingModel.data;// 心跳包data
                NSMutableData *beatData = [DPSIMSocketDataMananger calculatorData:1003 bodyData:data maxM:5];
                [self.clientSocket writeData:beatData withTimeout:-1 tag:111];
                [self.clientSocket readDataWithTimeout:-1 tag:111];
            });
            //启动定时器
            dispatch_resume(self.beatTimer);
        }
}

/// 登录
- (void)login:(NSString *)para block:(void(^)(int code, NSDictionary *resultDic))loginBlock{
    if ([self.clientSocket isConnected]) {
        NSLog(@"socket连接着呢");
    }else{
        NSLog(@"socket断开着呢");
    }
    
    // json 转 dic
    NSDictionary *jsonDic =[DPSIMTools jsonStrToDic:para];
    NSLog(@"jsonDic--%@", jsonDic);
    C2SLoginInMsg *loginModel = [[C2SLoginInMsg alloc]init];
    loginModel.playerId = [[jsonDic objectForKey:@"playerId"] longLongValue];
    loginModel.token = [jsonDic objectForKey:@"token"];
    NSData *data = loginModel.data;

    NSLog(@"data---%@, 长度:%ld", data, data.length);
    NSMutableData * sendData = [DPSIMSocketDataMananger calculatorData:1001 bodyData:data maxM:5];
    NSLog(@"sendData---%@, 长度:%ld", sendData, sendData.length);
    [self.clientSocket writeData:sendData withTimeout:-1 tag:111];
    [self.clientSocket readDataWithTimeout:-1 tag:111];
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
//    [dic setObject:@"login success" forKey:@"msg"];
//    [dic setObject:loginModel forKey:@"MsgContent"];
//    loginBlock(1, dic);
    self.loginBlock = loginBlock;
}

/// 发送私聊消息
- (void)sendMessage:(NSString *)message withBlock:(void(^)(int code, NSDictionary *resultDic))sendMsgBlock{
    
    if ([self.clientSocket isConnected]) {
        NSLog(@"socket连接着呢");
    }else{
        NSLog(@"socket断开着呢");
    }
    
    C2SPrivateChatMsg *privChatModel = [[C2SPrivateChatMsg alloc]init];
    privChatModel.clientMsgId = 1;
    privChatModel.clientSendTime = (int32_t)[DPSIMTools getCurrentTime];
    privChatModel.senderType = 1;
    privChatModel.fromPlayerId = playerId;
    privChatModel.businessType = 1;
    privChatModel.toPlayerId = 1413055642230370305;
    privChatModel.msgType = @"TEXT"; // 消息类型 TEXT | IMAGE | VOICE | VIDEO
    privChatModel.msgBody = message;
    privChatModel.extensionInfo = @"私聊扩展消息";
    NSData *data = [privChatModel data];
    NSMutableData * privChatData = [DPSIMSocketDataMananger calculatorData:2001 bodyData:data maxM:5];

    [self.clientSocket writeData:privChatData withTimeout:-1 tag:111];
    [self.clientSocket readDataWithTimeout:-1 tag:111];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"send private message success" forKey:@"msg"];
    [dic setObject:privChatModel forKey:@"MsgContent"];
    sendMsgBlock(1, dic);

}

/// 退出登录
- (void)logout:(NSString *)para block:(void(^)(int code, NSDictionary *resultDic))logoutBlock{
    
    NSDictionary *jsonDic =[DPSIMTools jsonStrToDic:para];
    NSLog(@"退出jsonDic--%@", jsonDic);

    C2SLogoutMsg *logoutModel = [[C2SLogoutMsg alloc]init];
    logoutModel.playerId = [[jsonDic objectForKey:@"playerId"] longLongValue];
    NSData *data = [logoutModel data];
    NSMutableData *logoutData = [DPSIMSocketDataMananger calculatorData:1008 bodyData:data maxM:5];
    [self.clientSocket writeData:logoutData withTimeout:-1 tag:111];
    
    [self socketDisConnect];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"logout success" forKey:@"msg"];
    logoutBlock(1, dic);
}

/// 发送群聊消息
- (void)sendGroupMsg:(NSString *)message withBlock:(void(^)(int code, NSDictionary *resultDic))sendGroupMsgBlock{
    if ([self.clientSocket isConnected]) {
        NSLog(@"socket连接着呢");
    }else{
        NSLog(@"socket断开着呢");
    }
    
    NSDictionary *jsonDic =[DPSIMTools jsonStrToDic:message];
    NSLog(@"群聊jsonDic--%@", jsonDic);

    C2SGroupChatMsg *groupChatModel = [[C2SGroupChatMsg alloc]init];
//    //    groupChatModel.clientMsgId = 1;
//    //    groupChatModel.clientSendTime = (int32_t)[DPSIMTools getCurrentTime];
//    //    groupChatModel.senderType = 1;
//        groupChatModel.fromPlayerId = playerId;
//    //    groupChatModel.fromPlayerRoleName = @"";
//    //    groupChatModel.fromPlayerNickName = @"";
//    //    groupChatModel.fromPlayerPortrait = @"";
//        groupChatModel.atPlayerIds = @"";
//    //    groupChatModel.businessType = 1;
//        groupChatModel.channelCode = @"world_01";
//        groupChatModel.msgType = @"TEXT"; // 消息类型 TEXT | IMAGE | VOICE | VIDEO
//        groupChatModel.msgBody = @"我是发送的内容zzzzzzzhhhhhh";
//    //    groupChatModel.extensionInfo = @"群聊扩展消息";
    
    groupChatModel.fromPlayerId = [[jsonDic objectForKey:@"fromPlayerId"] longLongValue];
    groupChatModel.atPlayerIds = [jsonDic objectForKey:@"atPlayerIds"];
    groupChatModel.channelCode = [jsonDic objectForKey:@"channelCode"];
    groupChatModel.msgType = [jsonDic objectForKey:@"msgType"]; // 消息类型 TEXT | IMAGE | VOICE | VIDEO
    groupChatModel.msgBody = [jsonDic objectForKey:@"msgBody"];

    NSData *data = [groupChatModel data];
    NSMutableData * groupChatData = [DPSIMSocketDataMananger calculatorData:2005 bodyData:data maxM:5];

    [self.clientSocket writeData:groupChatData withTimeout:-1 tag:111];
    [self.clientSocket readDataWithTimeout:-1 tag:111];

    self.sendGroupBlock = sendGroupMsgBlock;


}


/// 接收到的消息
- (void)didReceivedMessage:(void(^)(int code, NSDictionary *resultDic))receivedMsgBlock{
    NSLog(@"开始接收消息");
    self.receiveBlock = receivedMsgBlock;
    
}

// tag参数是为了在回调方法中匹配发起调用的方法的，不会加在传输数据中。
#pragma mark - GCDAsyncSocketDelegate
// 已经连接到服务器
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(nonnull NSString *)host port:(uint16_t)port{
    NSLog(@"连接成功, 服务器ip:%@, 端口:%d", host, port);
    [self.clientSocket readDataWithTimeout:-1 tag:111]; // 连接成功就从服务器读取数据
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"socket connect success" forKey:@"msg"];
    [dic setObject:host forKey:@"host"];
    [dic setObject:[NSString stringWithFormat:@"%d", port] forKey:@"port"];
    self.connectBlock(1, dic);
}

// 连接断开
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    NSLog(@"断开socket连接 原因:%@, 描述:%@",err, err.localizedDescription);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"socket disConnect" forKey:@"msg"];
//    [dic setObject:err forKey:@"error"];
    self.connectBlock(-1, dic);
}

// 已经接收服务器返回来的数据
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
//    NSLog(@"传递过来的数据data----%ld", data.length);
    [self.allData appendData:data];
    if (self.isFirst) {
        // 每个数据包只需调用一次获取头长度即可, 因为如果一个数据包分两次传递, 这里就会调用两次, 第一次获取的长度是正常的, 但是第二次获取的长度是不正常的
        self.allLength = bytesToint((void *)[[data subdataWithRange:NSMakeRange(0, 4)] bytes]);// 头
        self.chatType = bytesToint((void *)[[data subdataWithRange:NSMakeRange(4, 4)] bytes]);
        self.isFirst = NO;
    }
    NSLog(@"拼接的数据的长度--%ld, 服务器获取的总长度--%d, 类型--%d", self.allData.length, self.allLength, self.chatType);
    if (self.allData.length < self.allLength) {
//        [self.clientSocket readDataWithTimeout:-1 tag:111]; // 这里可以注释, 走到这就会走到最后那行
    }else{
        NSData *contentData = [self.allData subdataWithRange:NSMakeRange(8, self.allData.length - 8)];// 消息体
        [self parseReceivedData:contentData type:self.chatType];
    }
    
    [self.clientSocket readDataWithTimeout:-1 tag:111];
}
- (void)parseReceivedData:(NSData *)contentData type:(int)type{
    // 只要开始解析数据, 就移除allData所有数据, 并且isFirse置为YES
    [self.allData resetBytesInRange:NSMakeRange(0, [self.allData length])];
    [self.allData setLength:0];
    self.isFirst = YES;
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init]; // 统一回调字典
    [dic setObject:[NSNumber numberWithInt:type] forKey:@"protobufCode"];

    NSError *error = nil;
    if (type == 1002) {
        S2CLoginMsg *loginMsgModel = [S2CLoginMsg parseFromData:contentData error:&error];
        NSLog(@"登录返回 loginMsgModel--code:%d msg:%@ playerId:%lld", loginMsgModel.code, loginMsgModel.msg, loginMsgModel.playerId);
        [dic setObject:[NSNumber numberWithInt:loginMsgModel.code] forKey:@"code"];
        [dic setObject:[NSNumber numberWithLongLong:loginMsgModel.playerId] forKey:@"playerId"];
        [dic setObject: loginMsgModel.msg forKey:@"msg"];
        self.loginBlock(1, dic);
        // 登录成功
        if (loginMsgModel.code == 0 || [loginMsgModel.msg isEqualToString:@"has login already"]) {
            NSLog(@"登录成功");
            
            [self GetRecordMsg]; // 玩家获取消息记录获取
            // 心跳这里注释, 同时进行多个socket请求的时候接收的数据data有时候会不一样, 最好分开请求, 要不就加个锁进行一个顺序安全的socket请求
//            [self sendHeartBeat]; // 心跳
//            [self GetChannelMember];
            
        }
        
    }else if (type == 1004){
        S2CPongMsg *pongModel = [S2CPongMsg parseFromData:contentData error:&error];
        ZHLog(@"心跳收到返回数据currTime--%lld", pongModel.timeCurr);
    }else if (type == 1006){
        S2CGetRecordMsg *getRecModel = [S2CGetRecordMsg parseFromData:contentData error:&error];
        ZHLog(@"玩家获取消息记录返回--\ncode:%d \nmsg:%@ \ncontent:%@ \nchannelCodes:%@", getRecModel.code, getRecModel.msg, getRecModel.content, getRecModel.channelCodes);
    }else if (type == 2002){
        S2CPrivateChatMsg *privChatModel = [S2CPrivateChatMsg parseFromData:contentData error:&error];
        ZHLog(@"发送私聊消息服务器数据返回--%@", privChatModel.msg);
    }else if (type == 2003){
        S2CPrivateChatNotice *privChatNotModel = [S2CPrivateChatNotice parseFromData:contentData error:&error];
        ZHLog(@"私聊消息通知数据返回--%@", privChatNotModel.msgBody);
    }else if (type == 2006){
        S2CGroupChatMsg *groupChatModel = [S2CGroupChatMsg parseFromData:contentData error:&error];
        ZHLog(@"发送群聊消息服务器返回--%@", groupChatModel);

        [dic setObject:[NSNumber numberWithInt:groupChatModel.code] forKey:@"code"];
        [dic setObject:groupChatModel.msg forKey:@"msg"];
        [dic setObject:[NSNumber numberWithLongLong:groupChatModel.fromPlayerId] forKey:@"fromPlayerId"];
        [dic setObject:groupChatModel.channelCode forKey:@"channelCode"];
        [dic setObject:[NSNumber numberWithLongLong:groupChatModel.clientMsgId] forKey:@"clientMsgId"];
        [dic setObject:[NSNumber numberWithLongLong:groupChatModel.serverMsgId] forKey:@"serverMsgId"];
        [dic setObject:[NSNumber numberWithInt:groupChatModel.clientSendTime] forKey:@"clientSendTime"];
        [dic setObject:[NSNumber numberWithInt:groupChatModel.serverReceiveTime] forKey:@"serverReceiveTime"];
        [dic setObject:[NSNumber numberWithInt:groupChatModel.serverSendTime] forKey:@"serverSendTime"];


        self.receiveBlock(1, dic);

    }else if (type == 2007){
        S2CGroupChatNotice *groupChatNotModel = [S2CGroupChatNotice parseFromData:contentData error:&error];
        ZHLog(@"群聊消息通知返回--%@--%@--%lld", groupChatNotModel.msgBody, groupChatNotModel.fromPlayerInfo, [DPSIMTools getCurrentTime]);
        [dic setObject:[NSNumber numberWithLongLong:groupChatNotModel.clientMsgId] forKey:@"clientMsgId"];
//        [dic setObject:[NSNumber numberWithInt:groupChatNotModel.clientSendTime] forKey:@"clientSendTime"];
        [dic setObject:[NSString stringWithFormat:@"%d", groupChatNotModel.clientSendTime] forKey:@"clientSendTime"];// int32转string
        [dic setObject:[NSNumber numberWithInt:groupChatNotModel.senderType] forKey:@"senderType"];
//        [dic setObject:[NSNumber numberWithLongLong:groupChatNotModel.fromPlayerId] forKey:@"fromPlayerId"];
        [dic setObject:[NSString stringWithFormat:@"%lld", groupChatNotModel.fromPlayerId] forKey:@"fromPlayerId"]; // int64转string
        [dic setObject:groupChatNotModel.fromPlayerInfo forKey:@"fromPlayerInfo"];
        [dic setObject:groupChatNotModel.atPlayerIds forKey:@"atPlayerIds"];
        [dic setObject:[NSNumber numberWithInt:groupChatNotModel.businessType] forKey:@"businessType"];
        [dic setObject:groupChatNotModel.channelCode forKey:@"channelCode"];
        [dic setObject:groupChatNotModel.msgType forKey:@"msgType"];
        [dic setObject:groupChatNotModel.msgBody forKey:@"msgBody"];
        [dic setObject:groupChatNotModel.extensionInfo forKey:@"extensionInfo"];
        [dic setObject:[NSNumber numberWithLongLong:groupChatNotModel.serverMsgId] forKey:@"serverMsgId"];
        [dic setObject:[NSNumber numberWithInt:groupChatNotModel.serverSendTime] forKey:@"serverSendTime"];
        self.receiveBlock(1, dic);
        [DPSIMAlertView showAlertWithTitle:[NSString stringWithFormat:@"收到2007响应内容:%@", groupChatNotModel.msgBody]];
        
//        self.sendGroupBlock(1, dic);
    }else if (type == 3004){
        S2CGetChannelMemberMsg *getChannelMemberModel = [S2CGetChannelMemberMsg parseFromData:contentData error:&error];
        ZHLog(@"获取查询频道成员返回--\ncode:%d \nmsg:%@ \nrequestId:%lld \ncontent:%@", getChannelMemberModel.code, getChannelMemberModel.msg, getChannelMemberModel.requestId, getChannelMemberModel.content);
    }else if (type == 3006){
        ZHLog(@"创建频道成员返回--");
    }
    
    
}

- (void)GetChannelMember{
    NSLog(@"开始查询频道成员");
    C2SGetChannelMemberMsg *getChannelMemberModel = [[C2SGetChannelMemberMsg alloc]init];
    getChannelMemberModel.requestId = 0;
    getChannelMemberModel.playerId = playerId;
    getChannelMemberModel.channelId = 1;
    getChannelMemberModel.channelCode = @"world_01";
    NSData *data = getChannelMemberModel.data;
    NSMutableData *recMemData = [DPSIMSocketDataMananger calculatorData:3003 bodyData:data maxM:5];
    [self.clientSocket writeData:recMemData withTimeout:-1 tag:111];
}

- (void)GetRecordMsg{
    NSLog(@"玩家获取消息记录请求");
    C2SGetRecordMsg *getRecModel = [[C2SGetRecordMsg alloc]init];
    getRecModel.playerId = playerId;
    getRecModel.index = @"{}";
    NSData *data = getRecModel.data;
    NSMutableData *recData = [DPSIMSocketDataMananger calculatorData:1005 bodyData:data maxM:5];
    [self.clientSocket writeData:recData withTimeout:-1 tag:111];
}
int bytesToint(unsigned char* aDes) {
    int result;
    result = (aDes[0] & 0xff) << 24
    | (aDes[1] & 0xff) << 16
    | (aDes[2] & 0xff) << 8
    | (aDes[3] & 0xff) << 0;
    return result;
}

// 消息发送成功
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"发送数据成功 - tag是%ld ",tag);
}


@end
