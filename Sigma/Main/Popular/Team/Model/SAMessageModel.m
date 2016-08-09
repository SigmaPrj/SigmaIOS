//
//  SAMessageModel.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/5.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SAMessageModel.h"
#import "SADateHelper.h"

@implementation SAMessageModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
//        @property (nonatomic, copy) NSString *avatar;
//        @property (nonatomic, copy) NSString *nickname;
//        @property (nonatomic, copy) NSString *school;
//        @property (nonatomic, copy) NSString *message;
//        @property (nonatomic, copy) NSString *date;
//
//        @property (nonatomic, assign) int user_id;
//        @property (nonatomic, assign) int fuser_id;
//        @property (nonatomic, assign) int tuser_id;
//        @property (nonatomic, assign) int team_id;
//        @property (nonatomic, assign) int is_approved;
//        @property (nonatomic, assign) int user_level;
//        @property (nonatomic, assign) int user_type;
        _avatar = [dict valueForKeyPath:@"user.image"];
        _nickname = [dict valueForKeyPath:@"user.nickname"];
        _school = [dict valueForKeyPath:@"user.school_name"];
        _message = dict[@"message"];
        _date = [SADateHelper humanizedDate:[dict[@"date"] intValue]];

        _user_id = [[dict valueForKeyPath:@"user.id"] intValue];
        _fuser_id = [dict[@"from"] intValue];
        _tuser_id = [dict[@"to"] intValue];
        _team_id = [dict[@"team_id"] intValue];
        _is_approved = ([[dict valueForKeyPath:@"user.is_approved"] intValue] == 1);
        _user_level = [[dict valueForKeyPath:@"user.user_level"] intValue];
        _user_type = [[dict valueForKeyPath:@"user.user_type"] intValue];
    }
    return self;
}

+ (instancetype)messageWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
