//
//  SACollectionViewController.h
//  Sigma
//
//  Created by Terence on 16/7/19.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SAPDelegate <NSObject>

- (void) CollectionDismissViewController;

@end

@interface SACollectionViewController : UIViewController

@property (nonatomic, weak) id<SAPDelegate> myDelegate;

@end
