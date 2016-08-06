//
//  Story.h
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoryBody.h"

@interface Story : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSURL *imageURL;
@property (assign, nonatomic) NSUInteger storyId;
@property (strong, nonatomic) StoryBody *body;

@end