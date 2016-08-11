//
//  SATeamAddUserView.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/11.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SATeamAddUserView;

@protocol SATeamAddUserViewDelegate<NSObject>

- (void)addCustomView:(SATeamAddUserView *)addUserView cancelBtnDidClicked:(UIButton *)cancelBtn;
- (void)addCustomView:(SATeamAddUserView *)addUserView sureBtnDidClicked:(UIButton *)sureBtn username:(NSString *)username;

@end

@interface SATeamAddUserView : UIView

@property (nonatomic, weak) id<SATeamAddUserViewDelegate> delegate;

@end
