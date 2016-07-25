//
// Created by 汤轶侬 on 16/7/25.
// Copyright (c) 2016 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SARequestBase.h"

@interface SACommunityRequest : SARequestBase

+ (void)requestHeaderUserData:(int)user_id;

+ (void)requestDynamics:(NSDictionary *)dict token:(NSString *)token;

+ (void)requestCommentsWithDynamicId:(int)dynamic_id options:(NSDictionary *)dict;

@end