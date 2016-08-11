//
//  SAValidator.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/3.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAValidator : NSObject

+ (BOOL)isValidUsername:(NSString *)username;

+ (BOOL)isValidPassword:(NSString *)password;

+ (BOOL)isValidEmail:(NSString *)email;

+ (BOOL)isValidPhone:(NSString *)phone;

+ (BOOL)isValidCustomUser:(NSString *)username;

@end
