//
//  SACommunityUserModel.m
//  Sigma
//
//  Created by 汤轶侬 on 16/7/20.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SACommunityUserModel.h"

@implementation SACommunityUserModel

- (instancetype) initWithDict:(NSDictionary *)dict {
    self = [super init];
    
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+ (instancetype) userModelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
