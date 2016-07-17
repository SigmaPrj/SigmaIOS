//
//  TextEnhance.h
//  Sigma
//
//  Created by Ace Hsieh on 7/17/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UILabel;
@class UIButton;

@interface TextEnhance : NSObject

+ (void)resizeUILabelWidth:(UILabel *)label;

+ (void)resizeUIButtonWith:(UIButton *)label;


@end
