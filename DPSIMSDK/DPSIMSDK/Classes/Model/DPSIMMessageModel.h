//
//  DPSIMMessageModel.h
//  DPSIMSDK
//
//  Created by ZH on 2021/6/10.
//

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN

@interface DPSIMMessageModel : NSObject

// 这里的属性要和生成的protobuf类里面生成的一样

@property(nonatomic, copy)NSString *devId;

@property(nonatomic, copy)NSString *uid;

@property(nonatomic, copy)NSString *rid;

@property(nonatomic, copy)NSString *token;

/// protobuf数据转成model
//+ (DPSIMMessageModel *)initWithProtobufModel:(MessageModel *)model;

@end

NS_ASSUME_NONNULL_END
