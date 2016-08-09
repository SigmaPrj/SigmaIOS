//
//  SASignUpRequest.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/8.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SASignUpRequest.h"
#import "SAUserDataManager.h"
#import "SASecurity.h"

@implementation SASignUpRequest

+ (void)registerWithPhone:(NSString *)phone {
    NSString *url = @"/login/register";

    SARequestBase *request = [self requestFormWithPath:url parameters:@{
            @"username_type" : @"phone",
            @"phone" : phone,
            @"password" : @""
    } notification:NOTI_SIGNUP_PHONE];

    [request sendRequest:NOTI_SIGNUP_PHONE_ERROR];
}

+ (void)requestUserData:(NSInteger)user_id {
    NSString *url = [NSString stringWithFormat:@"user/%d", user_id];
    SARequestBase *request = [self requestWithPath:url method:@"GET" parameters:nil token:nil notification:NOTI_SIGNUP_USER];

    [request sendRequest:NOTI_SIGNUP_USER_ERROR];
}

+ (void)requestSetPass:(NSString *)password{
    NSString *url = @"/login/setpass";

    NSInteger userId = [SAUserDataManager readUserId];

    NSString *certPassword = [SASecurity md5WithString:[NSString stringWithFormat:@"%@%@", PREFIX_PASSWORD, password]];

    SARequestBase *request = [SARequestBase requestFormWithPath:url parameters:@{
            @"user_id" : @(userId),
            @"password" : certPassword
    } notification:NOTI_SIGNUP_PASS];

    [request sendRequest:NOTI_SIGNUP_PASS_ERROR];
}

+ (void)requestSetUserInfo:(NSMutableDictionary *)dict {
    NSString *url = @"/login/setinfo";

    NSInteger userId = [SAUserDataManager readUserId];

    dict[@"user_id"] = @(userId);

    SARequestBase *request = [SARequestBase requestFormWithPath:url parameters:dict notification:NOTI_SIGNUP_INFO];

    [request sendRequest:NOTI_SIGNUP_INFO_ERROR];
}

@end
