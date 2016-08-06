//
//  SATeamChatViewController.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/5.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAMessageModel;

@interface SATeamChatViewController : UIViewController

- (instancetype)initWithMessageModel:(SAMessageModel *)messageModel;

@end
