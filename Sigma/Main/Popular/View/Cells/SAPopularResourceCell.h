//
//  SAPopularResourceCell.h
//  Sigma
//
//  Created by Terence on 16/7/15.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAPopularModel;
@class SAPopularResourceModel;

@interface SAPopularResourceCell : UITableViewCell

-(void)setData:(SAPopularModel *)data;

-(void)setResourceData:(SAPopularResourceModel *)resourcedata;

-(instancetype)initUI;

@end
