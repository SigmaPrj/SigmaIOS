//
//  SASchoolSearchTableView.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/8.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SASchoolSearchTableView;

@protocol SASchoolSearchTableViewDelegate<NSObject>

- (void)schoolCellDidClicked:(SASchoolSearchTableView *)searchTableView cell:(UITableViewCell *)cell;

@end

@interface SASchoolSearchTableView : UITableView

@property (nonatomic, weak) id<SASchoolSearchTableViewDelegate> ownDelegate;

@end
