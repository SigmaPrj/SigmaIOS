//
//  UIView+SAPublishBtnFrame.h
//  Sigma
//
//  Created by Terence on 16/7/17.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SAPublishBtnFrame)

@property (nonatomic, assign)CGFloat height;
@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat x;
@property (nonatomic, assign)CGFloat y;
@property (nonatomic, assign)CGFloat centerX;
@property (nonatomic, assign)CGFloat centerY;
@property (nonatomic, assign)CGSize size;

- (BOOL)isShowingOnKeyWindow;

+ (instancetype)viewFromXib;

@end
