//
//  SAUserDataManager.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/1.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAUserDataManager : NSObject

+ (void)saveUserData:(NSDictionary *)dict;

+ (id)readUserData;

+ (id)readToken;

+ (id)readTime;

+ (id)readUser;

+ (void)deleteUserData;

+ (void)deleteToken;

+ (void)deleteTime;

+ (void)deleteUser;

+ (NSString *)getFilePath;

@end
