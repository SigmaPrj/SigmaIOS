//
//  SATeamFriendView.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/4.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SATeamFriendView;
@class SAFriendCell;

@protocol SATeamFriendViewDelegate<NSObject>

- (void)friendView:(SATeamFriendView *)friendView cellDidClicked:(SAFriendCell *)friendCell;

@end

@interface SATeamFriendView : UIView

@property (nonatomic, weak) id<SATeamFriendViewDelegate> ownDelegate;

@end
