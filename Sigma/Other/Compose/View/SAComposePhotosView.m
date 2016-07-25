//
//  SAComposePhotosView.m
//  Sigma
//
//  Created by Terence on 16/7/25.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAComposePhotosView.h"

@implementation SAComposePhotosView

-(void)setImage:(UIImage *)image{
    _image = image;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    
    [self addSubview:imageView];
}


// 每添加一个子控件的时候也会调用，如果在viewDidload添加子控件，就不会调用
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    NSUInteger cols = 3;
    CGFloat margin = 10;
    CGFloat wh = (self.frame.size.width - (cols - 1) * margin)/cols;
    CGFloat x = 0;
    CGFloat y = 0;
    NSInteger col = 0;
    NSInteger row = 0;
    
    for (int i = 0; i < self.subviews.count; i++) {
        UIImageView *imageView = self.subviews[i];
        col = i % cols;
        row = i / cols;
        x = col * (margin + wh);
        y = row * (margin + wh);
        imageView.frame = CGRectMake(x, y, wh, wh);
    }
}

@end
