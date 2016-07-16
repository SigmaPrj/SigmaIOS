//
//  SAMineCell.h
//  Sigma
//
//  Created by Ace Hsieh on 7/16/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAMineCell : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *additionInfo;

-(instancetype)initWithTitle:(NSString*)title andAdditionalInfo:(NSString*)additionInfo;

@end
