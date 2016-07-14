//
//  SACustomTabBar.h
//  Sigma
//
//  Created by Terence on 16/7/13.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^plusBtnClick)();

@interface SACustomTabBar : UITabBar
@property(nonatomic, copy)plusBtnClick clickBlock;
@end
