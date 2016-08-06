//
//  CacheManagement.h
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheManagement : NSObject

+ (NSString*)calculateCacheSize;
+ (void)clearCache;

@end
