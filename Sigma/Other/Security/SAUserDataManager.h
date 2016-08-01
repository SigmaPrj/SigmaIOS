//
//  SAUserDataManager.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/1.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAUserDataManager : NSObject

+ (void)saveToken:(NSString *)token withDeadline:(NSTimeInterval)deadline;

+ (id)readToken;

+ (void)deleteToken;

@end
