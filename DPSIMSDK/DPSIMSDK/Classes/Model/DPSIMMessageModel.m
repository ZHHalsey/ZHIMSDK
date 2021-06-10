//
//  DPSIMMessageModel.m
//  DPSIMSDK
//
//  Created by ZH on 2021/6/10.
//

#import "DPSIMMessageModel.h"

@implementation DPSIMMessageModel

/// protobuf数据转成model
+ (DPSIMMessageModel *)initWithProtobufModel:(Person *)model{
    DPSIMMessageModel *dpsMessageModel = [[DPSIMMessageModel alloc]init];
    dpsMessageModel.age = model.age;
    dpsMessageModel.username = model.username;
    dpsMessageModel.phone = model.phone;
    return dpsMessageModel;
}

@end
