//
//  SATeamFrameModel.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/11.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SATeamModel;

@interface SATeamFrameModel : NSObject

@property (nonatomic, assign) CGRect avatarImageViewFrame;
@property (nonatomic, assign) CGRect nicknameLabelFrame;
@property (nonatomic, assign) CGRect descLabelFrame;

@property (nonatomic, strong) SATeamModel *teamModel;

@end
