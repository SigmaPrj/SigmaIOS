//
//  SAValidator.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/3.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SAValidator.h"

@implementation SAValidator

+ (BOOL)isValidUsername:(NSString *)username {
    if ([self isValidPhone:username]) return YES;
    if ([self isValidEmail:username]) return YES;
    return [self isValidCustomUser:username];
}

+ (BOOL)isValidPassword:(NSString *)password {
    NSString *pattern = @"^[a-zA-Z0-9.]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [predicate evaluateWithObject:password];
}

+ (BOOL)isValidEmail:(NSString *)email {
    NSString *pattern = @"^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [predicate evaluateWithObject:email];
}

+ (BOOL)isValidPhone:(NSString *)phone {
    NSString *pattern = @"^1[3|4|5|8][0-9]\\d{4,8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [predicate evaluateWithObject:phone];
}

+ (BOOL)isValidCustomUser:(NSString *)username {
    NSString *pattern = @"^[a-zA-Z]+[a-zA-Z0-9]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [predicate evaluateWithObject:username];
}

@end
