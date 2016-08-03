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

+ (void)saveUserData:(NSDictionary *)dict {
    [dict writeToFile:[self getFilePath] atomically:YES];
}

+ (id)readUserData {
    return  [NSDictionary dictionaryWithContentsOfFile:[self getFilePath]];
}

+ (id)readToken {
    NSDictionary *userDict = [NSDictionary dictionaryWithContentsOfFile:[self getFilePath]];
    return userDict[@"token"];
}

+ (id)readTime {
    NSDictionary *userDict = [NSDictionary dictionaryWithContentsOfFile:[self getFilePath]];
    return userDict[@"time"];
}

+ (id)readUser {
    NSDictionary *userDict = [NSDictionary dictionaryWithContentsOfFile:[self getFilePath]];
    return userDict[@"user"];
}

+ (void)deleteUserData {
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:[self getFilePath]]) {
        [manager removeItemAtPath:[self getFilePath] error:nil];
    }
}

+ (void)deleteToken {
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithContentsOfFile:[self getFilePath]];
    userDict[@"token"] = nil;
    [userDict writeToFile:[self getFilePath] atomically:YES];
}

+ (void)deleteTime {
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithContentsOfFile:[self getFilePath]];
    userDict[@"time"] = nil;
    [userDict writeToFile:[self getFilePath] atomically:YES];
}

+ (void)deleteUser {
    NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithContentsOfFile:[self getFilePath]];
    userDict[@"user"] = nil;
    [userDict writeToFile:[self getFilePath] atomically:YES];
}

+ (NSString *)getFilePath {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    return [path stringByAppendingPathComponent:[NSString stringWithFormat:@"Caches/%@", USER_FILE_NAME]];
}

@end
