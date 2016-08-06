//
//  SATeamMessageView.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/4.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SALoadingTableView.h"

@class SAMessageModel;

@protocol SATeamMessageViewDelegate<NSObject>

- (void)messageCellDidClicked:(SAMessageModel *)messageModel;

@end

@interface SATeamMessageView : SALoadingTableView

@property (nonatomic, weak) id<SATeamMessageViewDelegate> ownDelegate;

@end
