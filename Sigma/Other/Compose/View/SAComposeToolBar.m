//
//  SAComposeToolBar.m
//  Sigma
//
//  Created by Terence on 16/7/25.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAComposeToolBar.h"

@implementation SAComposeToolBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        // 添加所有子控件
        [self setUpAllChildView];
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}


#pragma mark - 添加所有子控件
-(void)setUpAllChildView{
    // 相册
    [self setUpbuttonWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] target:self action:@selector(btnClick:)];
    
    [self setUpbuttonWithImage:[UIImage imageNamed:@"compose_camerabutton_background"] highImage:[UIImage imageNamed:@"compose_camerabutton_background_highlighted"] target:self action:@selector(btnClick:)];
//
//    [self setUpbuttonWithImage:[UIImage imageNamed:@"compose_camerabutton_backgroun"] highImage:[UIImage imageNamed:@"compose_camerabutton_background_highlighte"] target:self action:@selector(btnClick:)];
//    
//    [self setUpbuttonWithImage:[UIImage imageNamed:@"compose_camerabutton_backgroun"] highImage:[UIImage imageNamed:@"compose_camerabutton_background_highlighte"] target:self action:@selector(btnClick:)];
    
    
}


-(void)btnClick:(UIButton*)button{
    // 点击工具条
    if ([_delegate respondsToSelector:@selector(composeToolBar:didClickBnt:)]) {
        [_delegate composeToolBar:self didClickBnt:button.tag];
    }
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    NSUInteger count = self.subviews.count;
    
    CGFloat w = self.frame.size.width / count;
    CGFloat h = self.frame.size.height;
    CGFloat x = 0;
    CGFloat y = 0;
    
    for (int i = 0; i < count; i++) {
        UIButton* btn = self.subviews[i];
        x = i * w;
        btn.frame = CGRectMake(x, y, w, h);
    }
    
//    CGFloat w = 30;
//    CGFloat h = self.frame.size.height;
//    CGFloat x = 0;
//    CGFloat y = 0;
//
//    UIButton* btn = self.subviews[0];
//    x = w;
//    btn.frame = CGRectMake(x, y, w, h);
    
    
}


-(void)setUpbuttonWithImage:(UIImage*)image highImage:(UIImage*)highImage target:(id)target action:(SEL)action{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.tag = self.subviews.count;
    
    [self addSubview:btn];
}


@end
