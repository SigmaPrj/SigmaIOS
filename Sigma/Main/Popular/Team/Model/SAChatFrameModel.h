//
//  SAChatFrameModel.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/5.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAChatModel;
@class SAMessageModel;

@interface SAChatFrameModel : NSObject

@property (nonatomic, assign, readonly) CGRect avatarImageViewFrame;
@property (nonatomic, assign, readonly) CGRect messageLabelFrame;
@property (nonatomic, assign, readonly) CGRect dateLabelFrame;

@property (nonatomic, strong) SAChatModel *chatModel;
@property (nonatomic, strong) SAMessageModel *messageModel;

- (CGFloat)getTotalHeight;

@end
