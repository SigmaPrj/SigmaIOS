//
//  SAMessageFrameModel.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/5.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAMessageModel;

@interface SAMessageFrameModel : NSObject

@property (nonatomic, assign, readonly) CGRect avatarImageViewFrame;
@property (nonatomic, assign, readonly) CGRect nicknameLabelFrame;
@property (nonatomic, assign, readonly) CGRect approvedImageViewFrame;
@property (nonatomic, assign, readonly) CGRect schoolLabelFrame;
@property (nonatomic, assign, readonly) CGRect dateLabelFrame;
@property (nonatomic, assign, readonly) CGRect messageLabelFrame;

@property (nonatomic, assign, getter=isApproved) BOOL isApproved;

@property (nonatomic, strong) SAMessageModel* messageModel;

@end
