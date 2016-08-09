//
//  SAQuestionCell.m
//  Sigma
//
//  Created by Ace Hsieh on 7/27/16.
//  Copyright © 2016 blackcater. All rights reserved.
//

#import "SAQuestionCell.h"

@implementation SAQuestionCell

-(instancetype)initWithTitle:(NSString*)title andDetail:(NSString*)detail andHeadImageName:(NSString*)headName andPopularity:(NSString*)popularity
{
    self=[super init];
    if (self) {
        self.title=title;
        self.detail=detail;
        self.headImgName=headName;
        self.popularity=popularity;
    }
    return self;
}

-(instancetype)initWithTitle:(NSString*)title andDetail:(NSString*)detail
{
    self=[super init];
    if (self) {
        self.title=title;
        self.detail=detail;
    }
    return self;
}

@end
