//
//  SAMyDetailQuestionTableViewCell.h
//  Sigma
//
//  Created by Ace Hsieh on 8/5/16.
//  Copyright © 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SAMyDetailQuestionTableViewCellDelegate <NSObject>


@end

@class SAMyDetailQuestionData;

@interface SAMyDetailQuestionTableViewCell : UITableViewCell

@property (nonatomic, strong)SAMyDetailQuestionData* data;

@property (nonatomic, weak)id<SAMyDetailQuestionTableViewCellDelegate> delegate;

-(void)showMyDetailQuestionCell;

@end
