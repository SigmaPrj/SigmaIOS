//
//  SACitySearchTableView.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/8.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SACitySearchTableView;

@protocol SACitySearchTableViewDelegate<NSObject>

- (void)cityCellDidClicked:(SACitySearchTableView *)searchTableView cell:(UITableViewCell *)cell;

@end

@interface SACitySearchTableView : UITableView

@property (nonatomic, weak) id<SACitySearchTableViewDelegate> ownDelegate;

@end
