//
//  DPSIMSingleton.m
//  DPSIMSDK
//
//  Created by ZH on 2021/6/1.
//

#import "DPSIMSingleton.h"
#import <objc/runtime.h>

@implementation DPSIMSingleton

+ (instancetype)sharedInstance{
    id instance = objc_getAssociatedObject(self, @"dpsimsdkinstance");
    if (!instance) {
        instance = [[super allocWithZone:NULL] init];
        objc_setAssociatedObject(self, @"dpsimsdkinstance", instance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

- (id)copyWithZone:(struct _NSZone *)zone{
    Class selfClass = [self class];
    return [selfClass sharedInstance];
}

@end
