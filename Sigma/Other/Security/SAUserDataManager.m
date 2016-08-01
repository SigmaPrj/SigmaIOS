//
//  SAUserDataManager.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/1.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SAUserDataManager.h"
#import "SAKeyChain.h"

@interface SAUserDataManager()

@end

@implementation SAUserDataManager

static SAUserDataManager *manager = nil;

+ (void)saveToken:(NSString *)token withDeadline:(NSTimeInterval)deadline {
    NSMutableDictionary *tokenData = [NSMutableDictionary dictionary];
    tokenData[KEY_TOKEN_VALUE] = token;
    tokenData[KEY_TOKEN_TIME] = @(deadline);
    [SAKeyChain save:KEY_TOKEN_IN_KEYCHAIN data:tokenData];
}

+ (id)readToken {
    return [SAKeyChain load:KEY_TOKEN_IN_KEYCHAIN];
}

+ (void)deleteToken {
    [SAKeyChain delete:KEY_TOKEN_IN_KEYCHAIN];
}

@end
