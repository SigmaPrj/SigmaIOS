//
//  StoryBodyParsingOperation.h
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import "ParsingOperation.h"
#import "Story.h"

@interface StoryBodyParsingOperation : ParsingOperation

@property (weak, nonatomic) Story *story;

@end
