//
//  SAHeaderLoadingView.m
//  Sigma
//
//  Created by 汤轶侬 on 16/7/26.
//  Copyright (c) 2016 blackcater. All rights reserved.
//

#import "SAHeaderLoadingView.h"

#define HEADER_LOADING_MID_VIEW_WIDTH 45
#define HEADER_LOADING_MID_VIEW_HEIGHT 45
#define HEADER_LOADING_OUTER_VIEW_WIDTH 70
#define HEADER_LOADING_VIEW_LABEL_PADDING 5
#define HEADER_LOADING_TITLE_FONT_SIZE 10
#define HEADER_LOADING_TITLE_FONT_COLOR [UIColor colorWithRed:0.69 green:0.69 blue:0.69 alpha:1.00]

@interface SAHeaderLoadingView()

@property (nonatomic, strong) UIImageView *outView;
@property (nonatomic, strong) UIImageView *midView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, copy) NSString *title;
// 定时器
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation SAHeaderLoadingView

- (instancetype)initWithTitle:(NSString *)title frame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _title = title;

        [self addSubview:self.outView];
        [self addSubview:self.midView];
        [self addSubview:self.titleLabel];

        // 设置标题
        CGRect titleRect = [title boundingRectWithSize:CGSizeMake(WIDTH(self), (HEADER_LOADING_TITLE_FONT_SIZE+HEADER_LOADING_VIEW_LABEL_PADDING)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:HEADER_LOADING_TITLE_FONT_SIZE]} context:nil];
        self.titleLabel.text = title;
        self.titleLabel.textColor = HEADER_LOADING_TITLE_FONT_COLOR;
        self.titleLabel.font = [UIFont systemFontOfSize:HEADER_LOADING_TITLE_FONT_SIZE];

        titleRect.origin.x = (WIDTH(self) - titleRect.size.width)/2;
        titleRect.origin.y = MaxY(self.outView) + HEADER_LOADING_VIEW_LABEL_PADDING;

        self.titleLabel.frame = titleRect;
    }
    return self;
}

+ (instancetype)loadingWithTitle:(NSString *)title frame:(CGRect)frame {
    return [[self alloc] initWithTitle:title frame:frame];
}

- (UIImageView *)outView {
    if (!_outView) {
        _outView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"outcircle"]];
        CGFloat outViewX = (self.frame.size.width - HEADER_LOADING_OUTER_VIEW_WIDTH)/2;
        CGFloat outViewY = (self.frame.size.height - HEADER_LOADING_OUTER_VIEW_WIDTH - 2*HEADER_LOADING_VIEW_LABEL_PADDING - HEADER_LOADING_TITLE_FONT_SIZE)/2;
        _outView.frame = CGRectMake(outViewX, outViewY, HEADER_LOADING_OUTER_VIEW_WIDTH, HEADER_LOADING_OUTER_VIEW_WIDTH);
    }
    return _outView;
}

- (UIImageView *)midView {
    if (!_midView) {
        _midView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"midicon"]];
        CGFloat midViewX = MinX(self.outView) + (WIDTH(self.outView) - HEADER_LOADING_MID_VIEW_WIDTH)/2;
        CGFloat midViewY = MinY(self.outView) + (HEIGHT(self.outView) - HEADER_LOADING_MID_VIEW_HEIGHT)/2;
        _midView.frame = CGRectMake(midViewX, midViewY, HEADER_LOADING_MID_VIEW_WIDTH, HEADER_LOADING_MID_VIEW_HEIGHT);
    }
    return _midView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.alpha = 0;
    }
    return _titleLabel;
}

#pragma timer
- (void)startTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(rotateOutViewContinue) userInfo:nil repeats:YES];

    NSRunLoop *mainRunLoop = [NSRunLoop mainRunLoop];
    [mainRunLoop addTimer:_timer forMode:NSRunLoopCommonModes];

    [_timer fire];
}

- (void)stopTimer {
    [_timer invalidate];
}

#pragma mark 动画处理
- (void)startAnimation {
    [self startTimer];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakSelf.titleLabel.alpha = 1;
        weakSelf.titleLabel.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished1) {
        [UIView animateWithDuration:.25 delay:.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            weakSelf.titleLabel.alpha = 1;
            weakSelf.titleLabel.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished2) {
            // 发送请求
            if ([weakSelf.delegate respondsToSelector:@selector(endHeaderLoadingAnimation:)]) {
                [weakSelf.delegate endHeaderLoadingAnimation:weakSelf];
            }
        }];
    }];
}

- (void)stopAnimation {
    [self stopTimer];

    self.titleLabel.alpha = 0;
}


- (void)prepareAnimation {
    self.titleLabel.text = @"可以松开我了~";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakSelf.titleLabel.alpha = 1;
    } completion:nil];
}

- (void)endPrepareAnimation {
    self.titleLabel.text = self.title;
    self.titleLabel.alpha = 0;
}

/*!
 * ---------------
 * 旋转处理
 * ---------------
 */

- (void)roateOutView:(CGFloat)offsetY {
    UIView *outView = self.outView;
    CGFloat offset = -offsetY;
    outView.transform = CGAffineTransformMakeRotation(4*(offset/LOADING_HEADER_VIEW_HEIGHT));
}

// 连续不断转
- (void)rotateOutViewContinue {
    UIView *outView = self.outView;
    outView.transform = CGAffineTransformRotate(outView.transform, 0.2);
}

@end
