//
//  SAGroupModel.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/10.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SAGroupModel.h"
#import "SAFriendModel.h"
#import "SAFriendFrameModel.h"

@implementation SAGroupModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _name = [dict allKeys][0];

        _explain = YES;

        NSMutableArray *mutableArray = nil;
        mutableArray = [dict allValues][0];

        _online = 0;

        for (int i = 0; i < mutableArray.count; ++i) {
            SAFriendModel *friendModel = [SAFriendModel friendsModelWith:mutableArray[(NSUInteger)i]];
            SAFriendFrameModel *frameModel = [[SAFriendFrameModel alloc] init];
            frameModel.friendModel = friendModel;

            if (frameModel.isOnline) {
                _online = _online+1;
                [self.friends insertObject:frameModel atIndex:0];
            } else {
                [self.friends addObject:frameModel];
            }
        }

    }
    return self;
}


+ (instancetype)groupsModelWith:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (NSMutableArray *)friends {
    if (!_friends) {
        _friends = [NSMutableArray array];
    }
    return _friends;
}

@end
