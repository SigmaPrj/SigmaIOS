//
//  SAMineTableViewCell.h
//  Sigma
//
//  Created by Ace Hsieh on 7/16/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAMineCell;

@protocol SAMineTableViewCellDelegate <NSObject>

@end

@interface SAMineTableViewCell : UITableViewCell

@property(nonatomic,strong)SAMineCell *data;
@property(nonatomic,weak)id<SAMineTableViewCellDelegate> delegate;

-(void)showMineCell;

@end
