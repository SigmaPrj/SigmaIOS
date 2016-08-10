//
//  SASignUpRequest.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/8.
//  Copyright (c) 2016 sigma. All rights reserved.
//



#import "SARequestBase.h"

@interface SASignUpRequest : SARequestBase

/**
 * 通过电话号码进行注册
 * @param phone
 */
+ (void)registerWithPhone:(NSString *)phone;

/**
 * 获取用户数据
 * @param user_id
 */
+ (void)requestUserData:(NSInteger)user_id;

/**
 * 修改密码请求
 * @param password
 */
+ (void)requestSetPass:(NSString *)password;

/**
 * 修改用户信息
 * @param dict
 */
+ (void)requestSetUserInfo:(NSMutableDictionary *)dict;

/**
 * 获取头像上传token
 */
+ (void)requestQNUploadToken;

@end
