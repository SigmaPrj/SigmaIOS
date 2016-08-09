//
//  SATeamRequest.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/5.
//  Copyright (c) 2016 sigma. All rights reserved.
//



#import "SARequestBase.h"

@interface SATeamRequest : SARequestBase

/**
 * 请求该用户的所有消息
 * @param uid
 */
+ (void)requestAllMessages:(NSInteger)uid;

/**
 * 请求用户之间的对话信息
 * @param mUser
 * @param sUser
 */
+ (void)requestMessagesOfUser:(NSInteger )mUser sUser:(NSInteger)sUser;

@end
