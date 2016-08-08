//
//  SAChatServer.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/7.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SAChatServer.h"

@implementation SAChatServer
@synthesize delegate = _delegate;

- (void)sendMessage:(XMNChatBaseMessage *)aMessage {
    // TODO : 向服务器发送信息
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        aMessage.state = XMNMessageStateFailed;
        aMessage.substate = XMNMessageSubStateSendContentFaield;
    });
}

@end
