//
//  DPSIMMessageModel.h
//  DPSIMSDK
//
//  Created by ZH on 2021/6/10.
//

#import <Foundation/Foundation.h>
#import "Person.pbobjc.h"



NS_ASSUME_NONNULL_BEGIN

@interface DPSIMMessageModel : NSObject

// 这里的属性要和生成的protobuf类里面生成的一样
@property(nonatomic, assign)int32_t age;

@property(nonatomic, copy)NSString *username;

@property(nonatomic, copy)NSString *phone;

/// protobuf数据转成model
+ (DPSIMMessageModel *)initWithProtobufModel:(Person *)model;

@end

NS_ASSUME_NONNULL_END
