//
//  SAPopularEventCell.h
//  Sigma
//
//  Created by Terence on 16/7/15.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAPopularModel;

@interface SAPopularEventCell : UITableViewCell

-(void)setData:(SAPopularModel *)data;


-(instancetype)initUI;

@end
