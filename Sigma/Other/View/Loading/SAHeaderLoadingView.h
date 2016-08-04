//
//  SAHeaderLoadingView.h
//  Sigma
//
//  Created by 汤轶侬 on 16/7/26.
//  Copyright (c) 2016 blackcater. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAHeaderLoadingView;

@protocol SAHeaderLoadingViewDelegate <NSObject>

@required
- (void)endHeaderLoadingAnimation:(SAHeaderLoadingView *)loadingView;

@end

@interface SAHeaderLoadingView : UIView

- (instancetype)initWithTitle:(NSString *)title frame:(CGRect)frame;

+ (instancetype)loadingWithTitle:(NSString *)title frame:(CGRect)frame;

- (void)startAnimation;

- (void)stopAnimation;

- (void)prepareAnimation;

- (void)endPrepareAnimation;

- (void)roateOutView:(CGFloat)offsetY;

// 代理
@property (nonatomic, weak) id<SAHeaderLoadingViewDelegate> delegate;

@end
