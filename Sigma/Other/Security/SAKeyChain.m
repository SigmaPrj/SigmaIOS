//
//  SAKeyChain.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/1.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SAKeyChain.h"

@implementation SAKeyChain

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [@{(__bridge_transfer id) kSecClass : (__bridge_transfer id) kSecClassGenericPassword,
            (__bridge_transfer id) kSecAttrService : service,
            (__bridge_transfer id) kSecAttrAccount : service,
            (__bridge_transfer id) kSecAttrAccessible : (__bridge_transfer id) kSecAttrAccessibleAfterFirstUnlock} mutableCopy];
}

/**
 * 添加 加密信息
 * @param service
 * @param data
 */
+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    keychainQuery[(__bridge_transfer id) kSecValueData] = [NSKeyedArchiver archivedDataWithRootObject:data];
    //Add item to keychain with the search dictionary
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
}

/**
 * 读取加密信息
 * @param service
 * @return
 */
+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    keychainQuery[(__bridge_transfer id) kSecReturnData] = (id) kCFBooleanTrue;
    keychainQuery[(__bridge_transfer id) kSecMatchLimit] = (__bridge_transfer id) kSecMatchLimitOne;
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    return ret;
}

/**
 * 删除加密信息
 * @param service
 */
+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
}

@end
