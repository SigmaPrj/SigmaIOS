//
//  SASignUpSetInfoView.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/8.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SASignUpSetInfoView;

@protocol SASignUpSetInfoViewDelegate<NSObject>

@required
- (void)chooseImageForAvatar:(SASignUpSetInfoView *)infoView;
- (void)finishedBtnClicked:(SASignUpSetInfoView *)infoView city:(NSInteger)city school:(NSInteger)school nickname:(NSString *)nickname;

@end

@interface SASignUpSetInfoView : UIView

@property (nonatomic, weak) id<SASignUpSetInfoViewDelegate> delegate;

- (void)setupAvatar:(UIImage *)image;

@end
