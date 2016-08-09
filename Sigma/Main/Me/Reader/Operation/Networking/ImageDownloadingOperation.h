//
//  ImageDownloadingOperation.h
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseOperation.h"

@interface ImageDownloadingOperation : BaseOperation

@property (copy, nonatomic) NSURL *URL;
@property (weak, nonatomic) UIImageView *targetImageView;
@property (assign, nonatomic) BOOL cacheDisable;

+ (instancetype)operationWithURL:(NSURL *)URL forImageView:(UIImageView *)imageView;

@end