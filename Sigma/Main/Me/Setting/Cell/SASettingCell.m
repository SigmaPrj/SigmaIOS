//
//  SASettingCell.m
//  Sigma
//
//  Created by Ace Hsieh on 7/25/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import "SASettingCell.h"

@implementation SASettingCell

-(instancetype)initWithTitle:(NSString*)title andAdditionalInfo:(NSString*)additionInfo{
    self=[super init];
    if (self) {
        self.title=title;
        self.additionInfo=additionInfo;
    }
    return self;
}

@end
