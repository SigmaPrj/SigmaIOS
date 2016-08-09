//
//  TimelineParsingOperation.h
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import "ParsingOperation.h"
#import "Timeline.h"

@interface TimelineParsingOperation : ParsingOperation

@property (readonly, strong, nonatomic) Timeline *timeline;

@end
