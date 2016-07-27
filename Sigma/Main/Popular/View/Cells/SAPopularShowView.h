//
//  SAPopularShowView.h
//  Sigma
//
//  Created by Terence on 16/7/14.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAPopularShowView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                          num:(NSUInteger)num
                     filename:(NSString *)filename
                        width:(CGFloat)width
                       height:(CGFloat)height;

@end
