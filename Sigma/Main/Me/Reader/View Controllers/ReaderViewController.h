//
//  ReaderViewController.h
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Story.h"
#import "SAViewController.h"

@interface ReaderViewController : SAViewController

@property (weak, nonatomic) Story *story;

@end