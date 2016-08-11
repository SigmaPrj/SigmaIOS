//
//  SATeamRequest.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/5.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SATeamRequest.h"
#import "SAUserDataManager.h"


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


+ (void)addFriend:(NSString *)username {
    NSInteger userId = [SAUserDataManager readUserId];
    NSString *path = [NSString stringWithFormat:@"friend/%d", userId];
    SARequestBase *request = [self requestFormWithPath:path parameters:@{
            @"username" : username
    } notification:NOTI_TEAM_ADD_USER];

    [request sendRequest:NOTI_TEAM_ADD_USER_ERROR];
}

+ (void)getFriends {
    NSInteger userId = [SAUserDataManager readUserId];
    NSString *token = [SAUserDataManager readToken];
    NSString *path = [NSString stringWithFormat:@"friend/%d/user", userId];
    SARequestBase *request = [self requestWithPath:path method:@"GET" parameters:nil token:token notification:NOTI_TEAM_FRIEND];

    [request sendRequest:NOTI_TEAM_FRIEND_ERROR];
}

+ (void)getGroups:(NSString *)groupsStr {
    NSString *path = @"group";
    SARequestBase *request = [self requestFormWithPath:path parameters:@{
            @"groups" :groupsStr
    } notification:NOTI_TEAM_GROUP];

    [request sendRequest:NOTI_TEAM_GROUP_ERROR];
}

+ (void)createGroup:(NSDictionary *)params {
    NSString *path = @"group";
    SARequestBase *requestBase = [self requestFormWithPath:path parameters:params notification:NOTI_TEAM_ADD_TEAM];
    [requestBase sendRequest:NOTI_TEAM_ADD_TEAM_ERROR];
}

@end
