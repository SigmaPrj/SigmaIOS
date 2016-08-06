//
//  TimelineViewController.h
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const kNeedsUpdateRefreshStateNotification = @"kNeedsUpdateRefreshStateNotification";
static NSString * const kTimelineNeedsReserveNotification = @"kTimelineNeedsReserveNotification";
static NSString * const kStoryShouldShowNotification = @"kStoryShouldShowNotification";
static NSString * const kStoryUserInfoKey = @"kTopStoryUserInfoKey";

@interface TimelineViewController : UIViewController

@end
