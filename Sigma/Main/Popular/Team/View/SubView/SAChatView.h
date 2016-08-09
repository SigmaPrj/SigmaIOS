//
//  SAChatView.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/7.
//  Copyright (c) 2016 sigma. All rights reserved.
//



#import <XMNChat/XMNChat.h>
#import <UIKit/UIKit.h>

@class SAMessageModel;

@interface SAChatView : XMNChatViewModel

@property (nonatomic, strong) SAMessageModel *messageModel;

@end
