//
//  SAQuestionCell.h
//  Sigma
//
//  Created by Ace Hsieh on 7/27/16.
//  Copyright © 2016 blackcater. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAMyQuestionCell : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *headImgName;
@property(nonatomic,copy)NSString *popularity;
@property(nonatomic,copy)NSString *detail;

-(instancetype)initWithTitle:(NSString*)title andDetail:(NSString*)detail andHeadImageName:(NSString*)headName andPopularity:(NSString*)popularity;

@end
