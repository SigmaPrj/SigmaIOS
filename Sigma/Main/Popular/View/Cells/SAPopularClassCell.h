//
//  SAPolularClassCell.h
//  Sigma
//
//  Created by Terence on 16/7/15.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAPopularModel;
@class SAPopularClassModel;

@interface SAPopularClassCell : UITableViewCell

//-(void)setData:(SAPopularModel *)data;

-(void)setClassData:(SAPopularClassModel*)classdata;

-(instancetype)initUI;

@end
