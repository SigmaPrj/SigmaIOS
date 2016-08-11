//
//  SAFriendModel.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/10.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SAFriendModel.h"

@implementation SAFriendModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _userId = [dict[@"id"] intValue];
        _username = [NSString stringWithFormat:@"%@", dict[@"username"]];
        _nickname = dict[@"nickname"];
        _avatar = dict[@"image"];
        _vip = [dict[@"is_approved"] intValue];
        _userLevel = [dict[@"user_level"] intValue];
        _userType = [dict[@"user_type"] intValue];
        _school = dict[@"school_name"];

        // 模拟是否在线
        _online = (NSInteger *) ((arc4random()%3 == 1)?1:0);
    }
    return self;
}


+ (instancetype)friendsModelWith:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
