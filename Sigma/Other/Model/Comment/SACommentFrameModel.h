//
//  SACommentFrameModel.h
//  Sigma
//
//  Created by 汤轶侬 on 16/7/27.
//  Copyright (c) 2016 blackcater. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SACommentModel;

@interface SACommentFrameModel : NSObject

@property (nonatomic, assign, readonly) CGRect avatarFrame;
@property (nonatomic, assign, readonly) CGRect nicknameFrame;
@property (nonatomic, assign, readonly) CGRect approvedFrame;
@property (nonatomic, assign, readonly) CGRect schoolFrame;
@property (nonatomic, assign, readonly) CGRect dateFrame;
@property (nonatomic, assign, readonly) CGRect commentFrame;
@property (nonatomic, assign, readonly) CGRect praiseBtnFrame;
@property (nonatomic, assign, readonly) CGRect praiseLabelFrame;
@property (nonatomic, assign, readonly) CGRect underlineFrame;

@property (nonatomic, assign, getter=isApproved) BOOL isApproved;
@property (nonatomic, assign, getter=hasReplay) BOOL hasReplay;

@property (nonatomic, strong) SACommentModel *commentModel;

- (CGFloat)getTotalHeight;

@end
