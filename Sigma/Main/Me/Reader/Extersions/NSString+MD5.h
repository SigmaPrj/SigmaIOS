//
//  NSString+MD5.h
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)

@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *stringDigestedViaMD5;

@end
