//
//  SACircleAnimationView.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/1.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SACircleAnimationView.h"

@interface SACircleAnimationView()

@property (nonatomic, strong) UIColor* borderColor;
@property (nonatomic, assign) CGFloat timeFlag;
@property (nonatomic, strong) NSTimer* timer;

@end

@implementation SACircleAnimationView

+(instancetype)viewWithButton:(UIButton *)button{
    SACircleAnimationView* animationView = [[SACircleAnimationView alloc] init];

    animationView.frame = CGRectMake(-8, -8, button.frame.size.width + 16, button.frame.size.height + 16);

    animationView.backgroundColor = [UIColor clearColor];

    animationView.borderColor = button.titleLabel.textColor;

    animationView.timeFlag = 0;
    return animationView;
}
-(void)removeFromSuperview{
    [self.timer invalidate];
    [super removeFromSuperview];
}
-(void)startAnimation{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(continueAnimation) userInfo:nil repeats:YES];
    [self.timer fire];

}
-(void)continueAnimation{
    self.timeFlag += 0.02;

    [self setNeedsDisplay];

}
-(void)drawRect:(CGRect)rect{


    UIBezierPath* path = [UIBezierPath bezierPath];


    CGPoint center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    CGFloat radius = rect.size.width / 2 - 2;
    CGFloat start = (CGFloat)(- M_PI_2 + self.timeFlag * 2*M_PI);
    CGFloat end = (CGFloat)(-M_PI_2 + 0.45 * 2 * M_PI  + self.timeFlag * 2 *M_PI);

    [path addArcWithCenter:center radius:radius startAngle:start endAngle:end clockwise:YES];

    [self.borderColor setStroke];
    path.lineWidth = 1.5;

    [path stroke];
}

@end
