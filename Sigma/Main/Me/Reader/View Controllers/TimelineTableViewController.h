//
//  TimelineTableViewController.h
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimelineTableViewController : UITableViewController

@property (strong, nonatomic) id<UITableViewDataSource> dataSource;

@end
