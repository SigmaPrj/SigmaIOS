//
//  SASignUpSetPasswordView.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/8.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SASignUpSetPasswordView;

@protocol SASignUpSetPasswordViewDelegate<NSObject>

@optional
- (void)nextStepBtnClicked:(SASignUpSetPasswordView *)passwordView password:(NSString *)password;

@end

@interface SASignUpSetPasswordView : UIView

@property (nonatomic, weak) id<SASignUpSetPasswordViewDelegate> delegate;

@end
