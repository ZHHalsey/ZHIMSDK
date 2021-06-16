//
//  DPSIMUserDefaults.m
//  DPSIMSDK
//
//  Created by ZH on 2021/6/16.
//

#import "DPSIMUserDefaults.h"

@implementation DPSIMUserDefaults

#pragma mark - 存储token
+ (void)setToken:(NSString *)tokenStr{
    [ZHUserDefaults setObject:tokenStr forKey:@"DPSIMToken"];
}

#pragma mark - 获取token
+ (NSString *)getToken{
    if ([ZHUserDefaults objectForKey:@"DPSIMToken"]) {
        return [ZHUserDefaults objectForKey:@"DPSIMToken"];
    }
    return nil;
}
#pragma mark - 移除token
+ (void)removeToken{
    if ([ZHUserDefaults objectForKey:@"DPSIMToken"]) {
        [ZHUserDefaults removeObjectForKey:@"DPSIMToken"];
        NSLog(@"token成功移除");
    }
}

@end
