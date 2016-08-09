//
//  SASignUpWithTelephoneView.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/1.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SASignUpWithTelephoneView;

@protocol SASignUpWithTelephoneViewDelegate<NSObject>

- (void)phoneRegisterBtnClicked:(SASignUpWithTelephoneView *)phoneView phone:(NSString *)phone;

@end

@interface SASignUpWithTelephoneView : UIView

@property (nonatomic, weak) id<SASignUpWithTelephoneViewDelegate> delegate;

@end
