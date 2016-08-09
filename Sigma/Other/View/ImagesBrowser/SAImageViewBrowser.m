//
//  SAImageViewBrowser.m
//  Sigma
//
//  Created by 汤轶侬 on 16/7/29.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SAImageViewBrowser.h"
#import "UIImageView+WebCache.h"
#import "POP.h"
#import "UIView+SAPublishBtnFrame.h"

@interface SAImageViewBrowser() <UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGFloat scale;

@end

@implementation SAImageViewBrowser

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor colorWithRed:(CGFloat) ((arc4random() % 255 + 1) / 255.0) green:(CGFloat) ((arc4random() % 255 + 1) / 255.0) blue:(CGFloat) ((arc4random() % 255 + 1) / 255.0) alpha:1.0];
        self.showsHorizontalScrollIndicator = YES;
        self.showsVerticalScrollIndicator = YES;
        self.maximumZoomScale = 2;
        self.minimumZoomScale = 0.5;

        self.delegate = self;

        // 捏合手势缩放图片
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomImage:)];
        pinch.delegate = self;
        [self addGestureRecognizer:pinch];

        [self addSubview:self.imageView];

        _hasLoaded = NO;
        _isScaled = NO;
    }
    return self;
}

- (void)setImageWithUrl:(NSURL *)url placeholderImage:(UIImage *)image frame:(CGRect)frame {
    self.imageView.bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
    __weak typeof(self) weakSelf = self;

    __block POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
//    __block POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBounds];
    springAnimation.fromValue = [NSValue valueWithCGRect:frame];
//    springAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    springAnimation.springBounciness = 10.0f;
    springAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        _hasLoaded = YES;
    };
    [self.imageView sd_setImageWithURL:url placeholderImage:image options:SDWebImageRetryFailed | SDWebImageHighPriority  completed:^(UIImage *newImage, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        CGFloat newImageRatio = newImage.size.width/newImage.size.height;
        CGFloat screenRatio = SCREEN_WIDTH/SCREEN_HEIGHT;
        if (newImageRatio >= screenRatio) {
            CGFloat newImageInitWidth = SCREEN_WIDTH;
            CGFloat newImageInitHeight = newImageInitWidth/newImageRatio;
            springAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, (SCREEN_HEIGHT-newImageInitHeight)/2, newImageInitWidth, newImageInitHeight)];
//            springAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, newImageInitWidth, newImageInitHeight)];
            [weakSelf.imageView pop_addAnimation:springAnimation forKey:@"ImageViewBrowserSpring"];
        } else {
            CGFloat newImageInitHeight = SCREEN_HEIGHT;
            CGFloat newImageInitWidth = newImageInitHeight*newImageRatio;
            springAnimation.toValue = [NSValue valueWithCGRect:CGRectMake((SCREEN_WIDTH-newImageInitWidth)/2, 0, newImageInitWidth, newImageInitHeight)];
//            springAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, newImageInitWidth, newImageInitHeight)];
            [weakSelf.imageView pop_addAnimation:springAnimation forKey:@"ImageViewBrowserSpring"];
        }
    }];
}

- (void)dismissWithFrame:(CGRect)frame {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.backgroundColor = [UIColor clearColor];
    }];
    POPBasicAnimation *basicAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
    basicAnimation.fromValue = [NSValue valueWithCGRect:self.imageView.frame];
    basicAnimation.toValue = [NSValue valueWithCGRect:frame];
    basicAnimation.duration = 0.3;
    [self.imageView pop_addAnimation:basicAnimation forKey:@"ImageViewBrowserBasic"];
}

// 双击缩放
- (void)doubleClickWithScale:(CGFloat)scale {
    _scale = scale;
    [self setZoomScale:scale animated:YES];
    _isScaled = !_isScaled;
}

// 捏合手势
- (void)zoomImage:(UIPinchGestureRecognizer *)recognizer
{
    CGFloat scale = recognizer.scale;
    CGFloat temp = _scale + (scale - 1);
    [self setImageViewScale:temp];
    recognizer.scale = 1.0;
}

- (void)setImageViewScale:(CGFloat)scale {
    if ((scale < self.minimumZoomScale) || (scale > self.maximumZoomScale)) return;

    [self setZoomScale:scale animated:NO];
}



- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

#pragma mark -
#pragma mark UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // 设置图片居中显示
    CGFloat offsetX = (CGFloat)((scrollView.bounds.size.width > scrollView.contentSize.width)?(scrollView.bounds.size.width - scrollView.contentSize.width)/2.0 : 0.0);
    CGFloat offsetY = (CGFloat)((scrollView.bounds.size.height > scrollView.contentSize.height)?(scrollView.bounds.size.height - scrollView.contentSize.height)/2.0 : 0.0);
    self.imageView.center = CGPointMake(scrollView.contentSize.width/2 + offsetX,scrollView.contentSize.height/2 + offsetY);
}

#pragma mark -
#pragma mark UIGestureRecognizerDelegate


@end
