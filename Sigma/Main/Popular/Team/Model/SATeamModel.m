//
//  SATeamModel.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/11.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SATeamModel.h"

@implementation SATeamModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _teamId = dict[@"group_id"];
        _teamName = dict[@"group_name"];
        _teamDesc = dict[@"desc"];
        _avatar = dict[@"avatar"];
        _creator = dict[@"creator"];
        _tId = [dict[@"id"] intValue];
    }
    return self;
}

+ (instancetype)teamWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
