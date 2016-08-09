//
//  TimelineDataSource.h
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Timeline.h"

@interface TimelineDataSource : NSObject <UITableViewDataSource>

@property (copy, nonatomic) NSString *cellIdentifier;
@property (copy, nonatomic) NSArray<Timeline *> *timelines;

- (Story *)storyAtIndexPath:(NSIndexPath *)indexPath;

@end
