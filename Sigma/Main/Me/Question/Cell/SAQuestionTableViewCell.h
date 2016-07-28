//
//  SAQuestionTableViewCell.h
//  Sigma
//
//  Created by Ace Hsieh on 7/27/16.
//  Copyright © 2016 blackcater. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAQuestionCell;

@protocol SAQuestionTableViewCellDelegate <NSObject>

@end

@interface SAQuestionTableViewCell : UITableViewCell

@property(nonatomic,strong)SAQuestionCell *data;
@property(nonatomic,weak)id<SAQuestionTableViewCellDelegate> delegate;

-(void)showQuestionCell;

@end
