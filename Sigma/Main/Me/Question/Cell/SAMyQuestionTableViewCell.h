//
//  SAQuestionTableViewCell.h
//  Sigma
//
//  Created by Ace Hsieh on 7/27/16.
//  Copyright © 2016 blackcater. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAMyQuestionCell;

@protocol SAMyQuestionTableViewCellDelegate <NSObject>

@end

@interface SAMyQuestionTableViewCell : UITableViewCell

@property(nonatomic,strong)SAMyQuestionCell *data;
@property(nonatomic,weak)id<SAMyQuestionTableViewCellDelegate> delegate;

-(void)showMyQuestionCell;

@end
