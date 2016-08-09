//
//  SATeamRequest.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/5.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SATeamRequest.h"

@implementation SATeamRequest

+ (void)requestAllMessages:(NSInteger)uid {
    NSString *path = [NSString stringWithFormat:@"message/%d", uid];
    SARequestBase *request = [self requestWithPath:path method:@"GET" parameters:nil token:nil notification:NOTI_TEAM_MESSAGES];
    [request sendRequest:NOTI_TEAM_MESSAGES_ERROR];
}

+ (void)requestMessagesOfUser:(NSInteger )mUser sUser:(NSInteger)sUser {
    NSString *path = [NSString stringWithFormat:@"message/%d/user/%d", mUser, sUser];
    SARequestBase *request = [self requestWithPath:path method:@"GET" parameters:nil token:nil notification:NOTI_TEAM_USER_MESSAGES];
    [request sendRequest:NOTI_TEAM_USER_MESSAGES_ERROR];
}

@end
