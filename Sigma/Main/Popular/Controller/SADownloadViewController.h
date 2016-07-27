//
//  SADownloadViewController.h
//  Sigma
//
//  Created by Terence on 16/7/22.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SADownloadViewControllerDelegate <NSObject>

-(void) DownloadDismissViewController;

@end

@interface SADownloadViewController : UIViewController

@property (nonatomic, weak) id<SADownloadViewControllerDelegate> delegate;


@end
