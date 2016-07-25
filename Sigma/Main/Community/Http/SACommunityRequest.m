//
// Created by 汤轶侬 on 16/7/25.
// Copyright (c) 2016 Terence. All rights reserved.
//

#import "SACommunityRequest.h"


@implementation SACommunityRequest

+ (void)requestHeaderUserData:(int)user_id {
    NSString *url = [NSString stringWithFormat:@"user/%d/basic", user_id];
    
    SARequestBase *request = [self requestWithPath:url method:@"GET" parameters:nil token:nil notification:NOTI_COMMUNITY_USER_DATA];
    [request sendRequest];
}

+ (void)requestDynamics:(NSDictionary *)dict token:(NSString *)token{
    NSString *url = @"dynamic";
    SARequestBase *request = [self requestWithPath:url method:@"GET" parameters:dict token:token notification:NOTI_COMMUNITY_DYNAMICS_DATA];
    [request sendRequest];
}

+ (void)requestCommentsWithDynamicId:(int)dynamic_id options:(NSDictionary *)dict {
    NSString *url = [NSString stringWithFormat:@"dynamic/%d/comment", dynamic_id];
    
    SARequestBase *request = [self requestWithPath:url method:@"GET" parameters:dict token:nil notification:NOTI_COMMUNITY_DYNAMIC_COMMENTS_DATA];
    [request sendRequest];
}

@end