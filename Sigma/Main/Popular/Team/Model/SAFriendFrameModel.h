//
//  SAFriendFrameModel.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/10.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAFriendModel;

@interface SAFriendFrameModel : NSObject

@property (nonatomic, assign) CGRect avatarImageViewFrame;
@property (nonatomic, assign) CGRect nicknameLabelFrame;
@property (nonatomic, assign) CGRect vipImageViewFrame;
@property (nonatomic, assign) CGRect schoolLabelFrame;
@property (nonatomic, assign) CGRect onlineLabelFrame;

@property (nonatomic, strong) SAFriendModel *friendModel;

- (BOOL)isOnline;

- (BOOL)isVip;

@end
