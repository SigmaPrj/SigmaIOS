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
        [self setValue:dict[@"id"] forKey:@"user_id"];
        [self setValue:dict[@"nickname"] forKey:@"nickname"];
        [self setValue:dict[@"image"] forKey:@"image"];
        [self setValue:dict[@"bgImage"] forKey:@"bgImage"];
        [self setValue:dict[@"is_approved"] forKey:@"is_approved"];
        [self setValue:dict[@"user_level"] forKey:@"user_level"];
    }
    
    return self;
}

+ (instancetype) userModelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
