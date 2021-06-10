//
//  ViewController.m
//  DPSIMSDKDemo
//
//  Created by ZH on 2021/5/31.
//


#define socketHost @"192.168.0.43"
#define socketPort 8211


#import "ViewController.h"
#import <DPSIMSDK/DPSIMAPI.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"vc";
    self.view.backgroundColor = [UIColor grayColor];

    [self createUI];
}
- (void)createUI{
    NSArray *btnArray = @[
        @"初始化SDK",
        @"连接socket",
        @"开始接收消息",// 点击后才能收到消息
        @"发送消息",
    ]; // 新功能直接往后加标题, demo中会自动从左往右创建相应的按钮
    for (int i = 0; i< [btnArray count]; i++) {
        [self createButtonWithIdx:i Title:[btnArray objectAtIndex:i]];
    }
}



- (void)clickButton:(UIButton *)btn{
    if (btn.tag == 0) {
        NSLog(@"点击了初始化SDK");
        [DPSIMAPI initSDK];
    }else if (btn.tag == 1){
        NSLog(@"开始连接IP和端口Port");
        [DPSIMAPI socketConnectWithHost:socketHost Port:socketPort block:^(int code, NSDictionary * _Nonnull resultDic) {
            NSLog(@"回调code:%d, resultDic:%@", code, resultDic);
        }];
    }else if (btn.tag == 2){
        NSLog(@"点击了开始接收消息");
        [DPSIMAPI didReceivedMessage:^(int code, NSDictionary * _Nonnull resultDic) {
            NSLog(@"demo中接收到的数据:%d, 数据:%@", code, resultDic);
        }];
    }else if (btn.tag == 3){
        NSLog(@"点击了发送消息");
        [DPSIMAPI sendMessage:@"我是客户端发的消息asdfsdf" withBlock:^(int code, NSDictionary * _Nonnull resultDic) {
            NSLog(@"发送消息回调, code : %d, 字典 : %@", code, resultDic);
        }];
        

    }else if (btn.tag == 4){
        
    }else if (btn.tag == 5){
        
    }else if (btn.tag == 6){
        
    }else if (btn.tag == 7){
        
    }else if (btn.tag == 8){
        
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

@end
