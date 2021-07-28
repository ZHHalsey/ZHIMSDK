//
//  ViewController.m
//  DPSIMSDKDemo
//
//  Created by ZH on 2021/5/31.
//



//#define socketHost @"129.211.123.137" // 服务端
//#define socketPort 18081

#define socketHost @"192.168.1.174" // 茂森本地
#define socketPort 18081

//#define socketHost @"192.168.0.43" // 自己本地
//#define socketPort 8211




#import "ViewController.h"
#import <DPSIMSDK/DPSIMAPI.h>

static int64_t playerId = 1418034067206574082;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"IM-Demo";
    self.view.backgroundColor = [UIColor grayColor];

    [self createUI];
}
- (void)createUI{
    NSArray *btnArray = @[
        @"初始化SDK",
        @"连接socket",
        @"开始接收消息",// 点击后才能收到消息
        @"开始登录",
        @"发送私聊消息",
        @"发送群聊消息",
        @"退出登录",
    ];
    for (int i = 0; i< [btnArray count]; i++) {
        [self createButtonWithIdx:i Title:[btnArray objectAtIndex:i]];
    }
}



- (void)clickButton:(UIButton *)btn{
    if (btn.tag == 0) {
        NSLog(@"点击了初始化SDK");
        [DPSIMAPI initSDK:^(int code, NSDictionary * _Nonnull resultDic) {
            NSLog(@"SDK初始化回调--%d, resultDic--%@", code, resultDic);
        }];
    }else if (btn.tag == 1){
//        NSLog(@"开始连接IP和端口Port");
//        [DPSIMAPI socketConnectWithHost:socketHost Port:socketPort block:^(int code, NSDictionary * _Nonnull resultDic) {
//            NSLog(@"回调code:%d, resultDic:%@", code, resultDic);
//        }];
        // 模拟dic转json
        NSDictionary *paraDic = @{@"host":socketHost, @"port":[NSString stringWithFormat:@"%d", socketPort]};
        NSString *jsonStr = [self dicToJsonStr:paraDic];
        NSLog(@"json串是--%@", jsonStr);
        [DPSIMAPI connect:jsonStr block:^(int code, NSDictionary * _Nonnull resultDic) {
            NSLog(@"socket连接回调code:%d, resultDic:%@", code, resultDic);
        }];

    }else if (btn.tag == 2){
        NSLog(@"点击了开始接收消息");
        [DPSIMAPI didReceivedMessage:^(int code, NSDictionary * _Nonnull resultDic) {
            NSLog(@"demo中接收到的数据:%d, 数据:%@", code, resultDic);
        }];

    }else if (btn.tag == 3){
        NSLog(@"点击了开始登录");
        // 模拟dic转json
        NSDictionary *paraDic = @{@"playerId":[NSString stringWithFormat:@"%lld", playerId], @"token":@"token11"};
        NSString *jsonStr = [self dicToJsonStr:paraDic];
        NSLog(@"json串是--%@", jsonStr);
        [DPSIMAPI login:jsonStr block:^(int code, NSDictionary * _Nonnull resultDic) {
            NSLog(@"登录回调数据:%d, 数据:%@", code, resultDic);
        }];

    }else if (btn.tag == 4){
        NSLog(@"点击了发送私聊消息");

        [DPSIMAPI sendMessage:@"发送的私聊消息adsfdfs" withBlock:^(int code, NSDictionary * _Nonnull resultDic) {
            NSLog(@"发送私聊消息回调, code : %d, 字典 : %@", code, resultDic);
        }];
    }else if (btn.tag == 5){
        NSLog(@"点击了发送群聊消息");
        NSDictionary *paraDic = @{@"fromPlayerId":[NSString stringWithFormat:@"%lld", playerId], @"atPlayerIds":@"", @"channelCode":@"world_servertest_1", @"msgType":@"TEXT", @"msgBody":@"发送内容408240824082"};
        NSString *jsonStr = [self dicToJsonStr:paraDic];

        [DPSIMAPI sendGroupMsg:jsonStr withBlock:^(int code, NSDictionary * _Nonnull resultDic) {
            NSLog(@"发送群聊消息回调, code : %d, 字典 : %@", code, resultDic);
        }];
        
    }else if (btn.tag == 6){
        NSLog(@"点击了退出登录");
        NSDictionary *paraDic = @{@"playerId":[NSString stringWithFormat:@"%lld", playerId]};
        NSString *jsonStr = [self dicToJsonStr:paraDic];
        [DPSIMAPI logout:jsonStr block:^(int code, NSDictionary * _Nonnull resultDic) {
            NSLog(@"退出登录回调:%d, 字典:%@", code, resultDic);
        }];
        
    }else if (btn.tag == 7){
        
    }else if (btn.tag == 8){
        
    }else if (btn.tag == 9){
        
    }
}




- (void) createButtonWithIdx:(int)idx Title:(nullable NSString *)title {
    // 创建一个Button对象，根据类型来创建button
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGSize btnSize = CGSizeMake(180, 40);
    CGSize viewSize = self.view.bounds.size;
    NSInteger indexNum = 3;
    if ([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationPortrait ||
    [UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationPortraitUpsideDown) {
        //当前竖屏
        indexNum = 2;
    }
    button.frame = CGRectMake(20 + (idx % indexNum) * (btnSize.width + 10), 100 + floor(idx / indexNum) * (btnSize.height + 10), btnSize.width, btnSize.height);
    // 按钮的正常状态
    [button setTitle:title forState:UIControlStateNormal];
    // 按钮的按下状态
    [button setTitle:title forState:UIControlStateHighlighted];
    // 设置按钮的背景色
    button.backgroundColor = [UIColor brownColor];
    // 设置正常状态下按钮文字的颜色，如果不写其他状态，默认都是用这个文字的颜色
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    // 设置按下状态文字的颜色
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    // 设置按钮的风格颜色,只有titleColor没有设置的时候才有用
    [button setTintColor:[UIColor whiteColor]];
    // titleLabel：UILabel控件
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    // 按钮TAG
    button.tag = idx;
    // 添加点击事件
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    // 添加到主视图
    [self.view addSubview:button];
}


/// 字典转Json串
- (NSString *)dicToJsonStr:(NSDictionary *)dic
{
    if ([NSJSONSerialization isValidJSONObject:dic]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}

/// Json串转字典
- (NSDictionary *)jsonStrToDic:(NSString *)jsonStr{
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return dic;
}


@end
