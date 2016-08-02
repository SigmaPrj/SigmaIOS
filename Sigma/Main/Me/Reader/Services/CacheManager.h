//
//  CacheManager.h
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheManager : NSObject

+ (instancetype)defaultManager;

- (void)putObject:(NSObject<NSCoding> *)object forKey:(NSString *)key;
- (void)putObject:(NSObject<NSCoding> *)object forKey:(NSString *)key toBothDiskAndMemory:(BOOL)flag;

- (id)objectForKey:(NSString *)key;

- (void)clearMemoryCaches;

@end

