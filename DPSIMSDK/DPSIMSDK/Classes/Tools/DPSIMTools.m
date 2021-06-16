//
//  DPSIMTools.m
//  DPSIMSDK
//
//  Created by ZH on 2021/6/16.
//

#import "DPSIMTools.h"

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


@end
