//
//  SATeamCreateGroupView.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/11.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SATeamCreateGroupView;

@protocol SATeamCreateGroupViewDelegate<NSObject>

- (void)createCustomView:(SATeamCreateGroupView *)createGroupView cancelBtnDidClicked:(UIButton *)cancelBtn;
- (void)createCustomView:(SATeamCreateGroupView *)createGroupView sureBtnDidClicked:(UIButton *)sureBtn groupName:(NSString *)groupName groupDesc:(NSString *)groupDesc username:(NSString *)username;

@end

@interface SATeamCreateGroupView : UIView

@property (nonatomic, weak) id<SATeamCreateGroupViewDelegate> delegate;

@end
