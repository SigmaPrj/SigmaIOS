//
//  SAKeyChain.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/1.
//  Copyright (c) 2016 sigma. All rights reserved.
//

/**
 * 代替 NSUserDefaults 保存重要用户信息 如: 登录账号和密码
 *
 * 注意: 只能用于保存很有价值的信息, 不能用户保存大量信息
 */

#import <Security/Security.h>
#import <Foundation/Foundation.h>

@interface SAKeyChain : NSObject

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;

/**
 * 保存信息
 * @param service
 * @param data
 */
+ (void)save:(NSString *)service data:(id)data;

/**
 * 读取信息
 * @param service
 * @return
 */
+ (id)load:(NSString *)service;

/**
 * 删除保存的信息
 * @param service
 */
+ (void)delete:(NSString *)service;

@end
