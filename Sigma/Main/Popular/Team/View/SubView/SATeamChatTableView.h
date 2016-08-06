//
//  SATeamChatTableView.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/5.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SALoadingTableView.h"

@class SAMessageModel;

@interface SATeamChatTableView : UITableView

@property (nonatomic, strong) SAMessageModel *messageModel;

- (void)setDatas:(NSArray *)array;

@end
