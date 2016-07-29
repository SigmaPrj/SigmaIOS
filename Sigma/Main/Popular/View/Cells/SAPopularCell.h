//
//  SAPopularCell.h
//  Sigma
//
//  Created by Terence on 16/7/15.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAPopularModel;
@class SAPopularQuestionModel;

@interface SAPopularCell : UITableViewCell

-(void)setData:(SAPopularModel *)data;

-(void)setQuesData:(SAPopularQuestionModel *)quesdata;

-(instancetype)initUI;

@end
