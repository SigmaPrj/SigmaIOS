//
//  SAFooterLoadingView.m
//  Sigma
//
//  Created by 汤轶侬 on 16/7/27.
//  Copyright (c) 2016 blackcater. All rights reserved.
//

#import "SAFooterLoadingView.h"

#define FOOTER_VIEW_LOADING_IVIEW_SIZE 30

@interface SAFooterLoadingView()

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation SAFooterLoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor grayColor];
        [self addSubview:self.indicatorView];
    }
    return self;
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        CGFloat ivX = (WIDTH(self) - FOOTER_VIEW_LOADING_IVIEW_SIZE)/2;
        CGFloat ivY = (FOOTER_VIEW_LOADING_HEIGHT - FOOTER_VIEW_LOADING_IVIEW_SIZE)/2;
        _indicatorView.frame = CGRectMake(ivX, ivY, FOOTER_VIEW_LOADING_IVIEW_SIZE, FOOTER_VIEW_LOADING_IVIEW_SIZE);
    }
    return _indicatorView;
}

- (void)startAnimation {
    [self.indicatorView startAnimating];
    if ([self.delegate respondsToSelector:@selector(endFooterLoadingAnimation:)]) {
        [self.delegate endFooterLoadingAnimation:self];
    }
}

- (void)stopAnimation {
    [self.indicatorView stopAnimating];
}

@end
