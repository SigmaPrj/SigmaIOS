//
//  SAComposeViewController.h
//  Sigma
//
//  Created by Terence on 16/7/25.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SAComposevcDelegate <NSObject>

-(void)ComposeDismisssViewController;

@end

@interface SAComposeViewController : UIViewController

@property(nonatomic, weak) id <SAComposevcDelegate> delegate;

@end
