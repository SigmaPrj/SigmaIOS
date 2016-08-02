//
//  NSString+MD5.m
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5)

- (NSString *)stringDigestedViaMD5 {
    const char * cStr = self.UTF8String;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG) strlen(cStr), result);
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [resultString appendFormat:@"%02x", result[i]];
    }
    
    return [resultString copy];
}

@end
