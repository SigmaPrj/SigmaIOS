//
//  SASignInRequest.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/3.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SASignInRequest.h"
#import "SASecurity.h"

@implementation SASignInRequest

+ (void)requestSignInWithUsername:(NSString *)username password:(NSString *)password {
    NSString *url = [NSString stringWithFormat:@"/login/auth"];

    // 加密password 为了安全
    NSString *pass = [SASecurity md5WithString:[NSString stringWithFormat:@"%@%@", PREFIX_PASSWORD, password]];

    SARequestBase *request = [self requestFormWithPath:url parameters:@{
        @"username" : username,
        @"password" : pass
    } notification:NOTI_SIGNIN_AUTH];
    [request sendRequest];
}

@end
