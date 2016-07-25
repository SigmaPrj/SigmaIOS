//
//  SAComposeToolBar.h
//  Sigma
//
//  Created by Terence on 16/7/25.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SAComposeToolBar;

@protocol SAComposeToolBarDelegate <NSObject>

@optional

-(void)composeToolBar:(SAComposeToolBar *)toolBar didClickBnt:(NSInteger)index;

@end

@interface SAComposeToolBar : UIView

@property(nonatomic, weak) id <SAComposeToolBarDelegate> delegate;

@end
