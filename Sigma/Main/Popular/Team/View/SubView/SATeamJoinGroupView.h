//
//  SATeamJoinGroupView.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/11.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SATeamJoinGroupView;

@protocol SATeamJoinGroupViewDelegate<NSObject>

- (void)joinCustomView:(SATeamJoinGroupView *)joinGroupView cancelBtnDidClicked:(UIButton *)cancelBtn;
- (void)joinCustomView:(SATeamJoinGroupView *)joinGroupView sureBtnDidClicked:(UIButton *)sureBtn group:(NSString *)group username:(NSString *)username;

@end

@interface SATeamJoinGroupView : UIView

@property (nonatomic, weak) id<SATeamJoinGroupViewDelegate> delegate;

@end
