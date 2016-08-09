//
//  StoryBody.h
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryBody : NSObject

@property (copy, nonatomic) NSString *htmlString;
@property (strong, nonatomic) NSString *cssString;
@property (strong, nonatomic) NSString *imageSource;
@property (copy, nonatomic) NSURL *shareURL;

@end
