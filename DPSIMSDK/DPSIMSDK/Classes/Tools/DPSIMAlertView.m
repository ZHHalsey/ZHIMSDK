//
//  DPSIMAlertView.m
//  DPSIMSDK
//
//  Created by ZH on 2021/6/24.
//

#import "DPSIMAlertView.h"

@implementation DPSIMAlertView
// 弹出一个提示框,一个按钮
+ (void)showOneBtnAlertViewWithMessage:(NSString *)message
                            enterClick:(void(^)(NSString *zhString))btnClick
                         andController:(UIViewController *)controller{
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert]; // 弹窗
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        btnClick(@"111");
    }];
    [alertCon addAction:action1];
    [controller presentViewController:alertCon animated:YES completion:nil];
}

// 弹出一个提示框, 两个按钮
+ (void)showTwoBtnAlertViewWithMessage:(NSString *)message
                          btnLeftTitle:(NSString *)btnLeftTitle
                         btnRightTitle:(NSString *)btnRightTitle
                            enterClick:(void(^)(NSString *zhString))btnOneClick
                           cancelClick:(void(^)(NSString *zhString1))btnTwoClick
                         andController:(UIViewController *)viewController{
    
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert]; // 弹窗
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:btnLeftTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        btnOneClick(@"1111");
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:btnRightTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        btnTwoClick(@"111");
    }];
    [alertCon addAction:action1];
    [alertCon addAction:action2];
    [viewController presentViewController:alertCon animated:YES completion:nil];
}

// 底部弹出一个提示框, 两个按钮
+ (void)showTwoBtnSheetViewWithMessage:(NSString *)message
                            btnUpTitle:(NSString *)btnUpTitle
                          btnDownTitle:(NSString *)btnDownTitle
                            enterClick:(void(^)())btnUpClick
                           cancelClick:(void(^)())btnDownClick
                         andController:(UIViewController *)viewController{
    
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleActionSheet]; // 弹窗
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:btnUpTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        btnUpClick(); // btnUpClick() 这个block代表的就是这个大括号{}里面的所有的代码, 所以是代码块
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:btnDownTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        btnDownClick();
    }];
    [alertCon addAction:action1];
    [alertCon addAction:action2];
    [viewController presentViewController:alertCon animated:YES completion:nil];
    
}

+ (void)showAlertWithTitle:(NSString *)titleStr{
    [[[UIAlertView alloc] initWithTitle:titleStr
                                message:nil
                               delegate:nil
                      cancelButtonTitle:@"返回"
                      otherButtonTitles:nil] show];

}

@end
