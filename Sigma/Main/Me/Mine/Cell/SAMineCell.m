//
//  SAMineCell.m
//  Sigma
//
//  Created by Ace Hsieh on 7/16/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import "SAMineCell.h"

@implementation SAMineCell

-(instancetype)initWithTitle:(NSString*)title andAdditionalInfo:(NSString*)additionInfo{
    self=[super init];
    if (self) {
        self.title=title;
        self.additionInfo=additionInfo;
    }
    return self;
}

@end
