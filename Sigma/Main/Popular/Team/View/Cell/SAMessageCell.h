//
//  SAMessageCell.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/5.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAMessageFrameModel;
@class SAMessageCell;

@protocol SAMessageCellDelegate<NSObject>

- (void)cellWillSwipe:(SAMessageCell *)cell;
- (void)cellDidSwipe:(SAMessageCell *)cell;
- (void)delBtnDidClicked:(SAMessageCell *)cell;
- (void)topBtnDidClicked:(SAMessageCell *)cell;

@end

@interface SAMessageCell : UITableViewCell

@property (nonatomic, strong) SAMessageFrameModel *frameModel;

@property (nonatomic, weak) id<SAMessageCellDelegate> delegate;

- (void)resetOffset;

@end
