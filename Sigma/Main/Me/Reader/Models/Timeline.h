//
//  Timeline.h
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Story.h"

@interface Timeline : NSObject

@property (copy, nonatomic) NSDate *date;
@property (copy, nonatomic) NSString *dateString;
@property (copy, nonatomic) NSArray<Story *> *stories;
@property (copy, nonatomic) NSArray<Story *> *topStories;

@end

