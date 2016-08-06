//
//  NSLock+Helpers.m
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import "NSLock+Helpers.h"

@implementation NSLock (Helpers)

- (id)withCriticalZone:(id(^)())block {
    [self lock];
    id obj = block();
    [self unlock];
    
    return obj;
}

@end
