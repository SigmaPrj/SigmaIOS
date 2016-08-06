//
//  SAImageViewBrowser.h
//  Sigma
//
//  Created by 汤轶侬 on 16/7/29.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAImageViewBrowser : UIScrollView

@property (nonatomic, assign, readonly) BOOL hasLoaded;
@property (nonatomic, assign, readonly) BOOL isScaled;

- (void)setImageWithUrl:(NSURL *)url placeholderImage:(UIImage *)image frame:(CGRect)frame;

- (void)dismissWithFrame:(CGRect)frame;

- (void)doubleClickWithScale:(CGFloat)scale;

@end
