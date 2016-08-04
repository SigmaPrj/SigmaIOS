//
//  SAFooterLoadingView.h
//  Sigma
//
//  Created by 汤轶侬 on 16/7/27.
//  Copyright (c) 2016 blackcater. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAFooterLoadingView;

@protocol SAFooterLoadingViewDelegate <NSObject>

@required
- (void)endFooterLoadingAnimation:(SAFooterLoadingView *)footerLoadingView;

@end

@interface SAFooterLoadingView : UIView

@property (nonatomic, weak) id<SAFooterLoadingViewDelegate> delegate;

- (void)startAnimation;

- (void)stopAnimation;

@end
