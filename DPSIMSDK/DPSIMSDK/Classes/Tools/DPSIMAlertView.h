//
//  DPSIMAlertView.h
//  DPSIMSDK
//
//  Created by ZH on 2021/6/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DPSIMAlertView : NSObject

/**
 * 显示一个按钮的弹窗提示框
 */
+ (void)showOneBtnAlertViewWithMessage:(NSString *)message
                            enterClick:(void(^)(NSString *zhString))btnClick
                         andController:(UIViewController *)controller;

/**
 * 显示两个按钮的弹窗提示框
 */
+ (void)showTwoBtnAlertViewWithMessage:(NSString *)message
                          btnLeftTitle:(NSString *)btnLeftTitle
                         btnRightTitle:(NSString *)btnRightTitle
                            enterClick:(void(^)(NSString *zhString))btnOneClick
                           cancelClick:(void(^)(NSString *zhString1))btnTwoClick
                         andController:(UIViewController *)viewController;

/**
 * 从底部弹出两个选项的提示框(可以任意的加按钮)
 */
+ (void)showTwoBtnSheetViewWithMessage:(NSString *)message
                            btnUpTitle:(NSString *)btnUpTitle
                          btnDownTitle:(NSString *)btnDownTitle
                            enterClick:(void(^)())btnUpClick
                           cancelClick:(void(^)())btnDownClick
                         andController:(UIViewController *)viewController;

/// 仅仅弹一个提示弹窗
+ (void)showAlertWithTitle:(NSString *)titleStr;

@end

NS_ASSUME_NONNULL_END
