//
//  HUDManager.h
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HUDManager : NSObject

+ (instancetype)defaultManager;

- (void)showToastWithString:(NSString *)string;
- (void)hideToast;

- (void)showProgressWithString:(NSString *)string;
- (void)hideProgress;

@end
