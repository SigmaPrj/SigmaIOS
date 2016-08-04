//
//  SADynamicCommentController.h
//  Sigma
//
//  Created by 汤轶侬 on 16/7/28.
//  Copyright (c) 2016 blackcater. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SADynamicModel;

@interface SADynamicCommentController : UIViewController

- (instancetype)initWithDynamicId:(NSInteger)dynamic_id dynamicModel:(SADynamicModel *)dynamicModel;

@end
