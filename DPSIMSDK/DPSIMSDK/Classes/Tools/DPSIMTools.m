//
//  DPSIMTools.m
//  DPSIMSDK
//
//  Created by ZH on 2021/6/16.
//

#import "DPSIMTools.h"
#import <AdSupport/AdSupport.h>

@implementation DPSIMTools


/// 沙盒获取主目录
+ (NSString *)getHomePath{
    return NSHomeDirectory();
}
/// 沙盒document路径
+ (NSString *)getDocumentPath{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];;
}
/// 沙盒library路径
+ (NSString *)getLibraryPath{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
}
/// 沙盒tmp路径
+ (NSString *)getTmpPath{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
}

/// 获取devId
+ (NSString *)getDeviceId{
    NSLog(@"设备唯一标识为--%@", [[[UIDevice currentDevice] identifierForVendor] UUIDString]);
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];// (重新运行不会改变, 卸载重装后就会改变)
}

/// 获取当前时间戳
+ (int64_t)getCurrentTime{
    NSDate *datenow = [NSDate date];//现在时间
    long long currentTime = [datenow timeIntervalSince1970]*1000;
    return currentTime;
}


/// 字典转Json串
+ (NSString *)dicToJsonStr:(NSDictionary *)dic
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
+ (NSDictionary *)jsonStrToDic:(NSString *)jsonStr{
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return dic;
}


@end
