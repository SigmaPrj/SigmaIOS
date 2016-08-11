//
//  SAImagesBrowser.h
//  Sigma
//
//  Created by 汤轶侬 on 16/7/29.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SAImagesBrowserDelegate<NSObject>

@end

@interface SAImagesBrowser : UIViewController

@property (nonatomic, weak) UIView *sourceImagesView;
@property (nonatomic, weak) id<SAImagesBrowserDelegate> delegate;

@property (nonatomic, assign) int imagesCount;
@property (nonatomic, assign) int currentImageIndex;

/*!
 * 显示图片浏览器
 */
- (void)show;

@end
