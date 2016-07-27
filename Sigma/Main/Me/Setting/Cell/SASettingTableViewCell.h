//
//  SASettingTableViewCell.h
//  Sigma
//
//  Created by Ace Hsieh on 7/25/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SASettingCell;

@protocol SASettingTableViewCellDelegate <NSObject>

@end

@interface SASettingTableViewCell : UITableViewCell

@property(nonatomic,strong)SASettingCell *data;
@property(nonatomic,weak)id<SASettingTableViewCellDelegate> delegate;

-(void)showMineCell;


@end
