//
//  SAImagesBrowser.m
//  Sigma
//
//  Created by 汤轶侬 on 16/7/29.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SAImagesBrowser.h"
#import "SAImageViewBrowser.h"
#import "SADynamicTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "POP.h"

#define IMAGES_BROWSER_BGCOLOR [UIColor colorWithRed:0 green:0 blue:0 alpha:0.95]
#define IMAGES_BROWSER_LABEL_COLOR [UIColor whiteColor]
#define IMAGES_BROWSER_LABEL_FONT_SIZE 16
#define IMAGES_BROWSER_LABEL_PADDING_TOP 20
#define IMAGES_BROWSER_PADDING_RIGHT 10
#define IMAGES_BROWSER_MORE_SIZE 20
#define IMAGES_BROWSER_PAGE_CONTROL_PADDING_BOTTOM 20
#define IMAGES_BROWSER_PAGE_CONTROL_PADDING_WIDTH 200
#define IMAGES_BROWSER_PAGE_CONTROL_PADDING_HEIGHT 14
#define IMAGES_BROWSER_PAGE_CONTROL_ACTIVE_COLOR [UIColor whiteColor]
#define IMAGES_BROWSER_PAGE_CONTROL_COLOR [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.6]

@interface SAImagesBrowser() <UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *pageLabel;
@property (nonatomic, strong) UIButton *moreOpts;

@end


@implementation SAImagesBrowser

- (instancetype)init {
    self = [super init];
    if (self) {
        self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.view.backgroundColor = IMAGES_BROWSER_BGCOLOR;
    }

    return self;
}

- (void)setupUI {
    [self.view addSubview:self.scrollView];
    if (self.imagesCount > 0) {
        [self.view addSubview:self.pageControl];
        [self.view addSubview:self.pageLabel];
    }
    [self.view addSubview:self.moreOpts];
}

- (void)show {
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    [window addSubview:self];
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *mvc = vc.childViewControllers[1];
    UIViewController *nowVC = mvc.visibleViewController;
    [nowVC presentViewController:self animated:NO completion:nil];

    [self setupUI];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _scrollView.maximumZoomScale = 1.0;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;

        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;

        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*self.imagesCount, SCREEN_HEIGHT);
        _scrollView.contentOffset = CGPointMake(SCREEN_WIDTH*(self.currentImageIndex), 0);

        // 添加图片
        for (int i = 0; i < self.imagesCount; ++i) {
            SAImageViewBrowser *imageViewBrowser = [[SAImageViewBrowser alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            imageViewBrowser.tag = i;

            // 单击图片
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapImage:)];

            // 双击放大图片
            UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapImage:)];
            doubleTap.numberOfTapsRequired = 2;

            [singleTap requireGestureRecognizerToFail:doubleTap];

            [imageViewBrowser addGestureRecognizer:singleTap];
            [imageViewBrowser addGestureRecognizer:doubleTap];
            [_scrollView addSubview:imageViewBrowser];
        }
        
        // 移动图片
        [self showImageAtIndex:(NSUInteger)self.currentImageIndex];
    }
    return _scrollView;
}

- (UILabel *)pageLabel {
    if (!_pageLabel) {
        _pageLabel = [[UILabel alloc] init];
        _pageLabel.textColor = IMAGES_BROWSER_LABEL_COLOR;
        _pageLabel.font = [UIFont systemFontOfSize:IMAGES_BROWSER_LABEL_FONT_SIZE];
        CGSize maxSize = CGSizeMake(SCREEN_WIDTH, 0);
        CGRect rect;
        NSString *str = @"10/10";
        rect = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:IMAGES_BROWSER_LABEL_FONT_SIZE]} context:nil];
        rect.origin.y = IMAGES_BROWSER_LABEL_PADDING_TOP;
        rect.origin.x = (SCREEN_WIDTH-Width(rect))/2;
        _pageLabel.frame = rect;
        _pageLabel.text = [NSString stringWithFormat:@"%d/%d", (self.currentImageIndex+1), self.imagesCount];
        _pageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _pageLabel;
}

- (UIButton *)moreOpts {
    if (!_moreOpts) {
        _moreOpts = [[UIButton alloc] init];
        _moreOpts.frame = CGRectMake((SCREEN_WIDTH-IMAGES_BROWSER_PADDING_RIGHT-IMAGES_BROWSER_MORE_SIZE), IMAGES_BROWSER_LABEL_PADDING_TOP, IMAGES_BROWSER_MORE_SIZE, IMAGES_BROWSER_MORE_SIZE);
        [_moreOpts setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
        [_moreOpts addTarget:self action:@selector(moreOptsClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreOpts;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, (SCREEN_HEIGHT-IMAGES_BROWSER_PAGE_CONTROL_PADDING_BOTTOM), IMAGES_BROWSER_PAGE_CONTROL_PADDING_WIDTH, IMAGES_BROWSER_PAGE_CONTROL_PADDING_HEIGHT)];
        _pageControl.numberOfPages = self.imagesCount;
        _pageControl.currentPage = (NSInteger)self.currentImageIndex;
        _pageControl.currentPageIndicatorTintColor = IMAGES_BROWSER_PAGE_CONTROL_ACTIVE_COLOR;
        _pageControl.pageIndicatorTintColor = IMAGES_BROWSER_PAGE_CONTROL_COLOR;
    }
    return _pageControl;
}

- (void)showScreen {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.5 delay:.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakSelf.moreOpts.alpha = 1.0;
        if (weakSelf.imagesCount > 0) {
            weakSelf.pageControl.alpha = 1.0;
            weakSelf.pageLabel.alpha = 1.0;
        }
    } completion:^(BOOL finished) {}];
}

- (void)clearScreen:(double)delay {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.5 delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakSelf.moreOpts.alpha = 0.0;
        if (weakSelf.imagesCount > 0) {
            weakSelf.pageControl.alpha = 0.0;
            weakSelf.pageLabel.alpha = 0.0;
        }
    } completion:^(BOOL finished) {}];
}

/*!
 * 去除图片浏览器
 */
- (void)dismiss {
//    [self removeFromSuperview];
    [self dismissViewControllerAnimated:NO completion:nil];
}

/**
 * 手势
 */
- (void)singleTapImage:(UITapGestureRecognizer *)recognizer {
    [self clearScreen:0.5];
    // 将图片缩回原处
    __weak typeof(self) weakSelf = self;
    SAImageViewBrowser *imageViewBrowser = (SAImageViewBrowser *)recognizer.view;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.view.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [weakSelf dismiss];
    }];
    [imageViewBrowser dismissWithFrame:[self getImageFrameAtIndex:(NSUInteger)imageViewBrowser.tag]];
}

- (void)doubleTapImage:(UITapGestureRecognizer *)recognizer {
    // 双击缩放
    SAImageViewBrowser *imageViewBrowser = (SAImageViewBrowser *)recognizer.view;
    CGFloat scale;
    if (imageViewBrowser.isScaled) {
        scale = 1.0;
    } else {
        scale = 1.4;
    }
    [imageViewBrowser doubleClickWithScale:scale];
}

/**
 * 显示第n个图片
 */
- (void)showImageAtIndex:(NSUInteger)index {
    SAImageViewBrowser *imageViewBrowser = self.scrollView.subviews[index];
    if (imageViewBrowser.hasLoaded) return;
    SADynamicTableViewCell *cell = (SADynamicTableViewCell *)self.sourceImagesView;
    UIImageView *imageView = cell.imagesViewArray[index];
    [imageViewBrowser setImageWithUrl:imageView.sd_imageURL placeholderImage:imageView.image frame:[self getImageFrameAtIndex:index]];
}

/**
 * 获取第n个图片的frame
 */
- (CGRect)getImageFrameAtIndex:(NSUInteger)index {
    SADynamicTableViewCell *cell = (SADynamicTableViewCell *)self.sourceImagesView;
    UITableView *tableView = (UITableView *)cell.delegate;
    UIImageView *imageView = cell.imagesViewArray[index];
    CGRect rect;
    rect.origin.x = imageView.frame.origin.x;
    rect.origin.y = (64 + cell.frame.origin.y + imageView.frame.origin.y-tableView.contentOffset.y);
    rect.size = imageView.frame.size;
    return rect;
}

/*!
 * 处理图片点击
 * @param btn
 */
- (void)moreOptsClicked:(UIButton *)btn {
    // 显示弹窗
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"图片操作" message:@"你可以进行如下操作" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"保存图片");
        // TODO : 将图片保存到相册
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"分享图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"分享图片");
        // TODO : 将图片分享
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
//    [alertController addAction:action4];
    [self presentViewController:alertController animated:YES completion:^{

    }];
}

#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int index = (int) ceil(scrollView.contentOffset.x/SCREEN_WIDTH);
    if (self.scrollView.subviews.count > 0) {
        self.pageControl.currentPage = index;
        self.pageLabel.text = [NSString stringWithFormat:@"%d/%d", (index+1), self.imagesCount];
        [self showImageAtIndex:(NSUInteger)index];
    }
    [self showScreen];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self clearScreen:0.5];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
}

@end
