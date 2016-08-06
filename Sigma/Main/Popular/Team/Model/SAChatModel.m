//
//  SAChatModel.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/5.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SAChatModel.h"
#import "SADateHelper.h"

@implementation SAChatModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _message = dict[@"message"];
        _date = [SADateHelper humanizedDate:[dict[@"date"] intValue]];
        _fromUser = [dict[@"from"] intValue];
        _toUser = [dict[@"to"] intValue];
    }
    return self;
}

+ (instancetype)chatWthDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
