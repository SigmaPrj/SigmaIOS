//
//  SAQuestionCell.m
//  Sigma
//
//  Created by Ace Hsieh on 7/27/16.
//  Copyright © 2016 blackcater. All rights reserved.
//

#import "SAMyQuestionCell.h"

@implementation SAMyQuestionCell

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

@end
