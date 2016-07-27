//
//  SAQuestionViewController.h
//  Sigma
//
//  Created by Terence on 16/7/26.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SAQuestionvcDelegate <NSObject>

-(void)questionDismissViewController;

@end

@interface SAQuestionViewController : UIViewController

@property(nonatomic, weak) id <SAQuestionvcDelegate> delegate;

@end
