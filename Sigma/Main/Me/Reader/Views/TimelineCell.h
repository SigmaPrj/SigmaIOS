//
//  TimelineCell.h
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Story.h"

@interface TimelineCell : UITableViewCell

- (void)loadWithStory:(Story *)story;

@end
