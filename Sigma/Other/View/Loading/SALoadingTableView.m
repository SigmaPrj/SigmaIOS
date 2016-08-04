//
//  SALoadingTableView.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/3.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SALoadingTableView.h"
#import "SAHeaderLoadingView.h"
#import "SAFooterLoadingView.h"

@interface SALoadingTableView() <SAHeaderLoadingViewDelegate, SAFooterLoadingViewDelegate>

// 头部加载
@property (nonatomic, strong) SAHeaderLoadingView *headerLoadingView;
// 底部加载
@property (nonatomic, strong) SAFooterLoadingView *footerLoadingView;

@end

@implementation SALoadingTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.headerLoadingView.delegate = self;
        self.footerLoadingView.delegate = self;
//        self.delegate = self;

        // 添加所有通知
        [self addAllNotifications];
    }
    return self;
}

- (void)setUseHeaderLoading:(BOOL)useHeaderLoading {
    if (useHeaderLoading) {
        [self.tableHeaderView addSubview:self.headerLoadingView];
    }
}

- (void)setUseFooterLoading:(BOOL)useFooterLoading {
    if (useFooterLoading) {
        [self.tableFooterView addSubview:self.footerLoadingView];
    }
}


- (void)endHeaderLoading {
    // 滚动到顶部
    self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self setContentOffset:CGPointMake(0 , 0) animated:YES];
}

- (void)endFooterLoading {
    // tableview底部
    self.contentInset = UIEdgeInsetsMake(0 , 0, 0, 0);
}

// 上拉刷新组件
- (SAHeaderLoadingView *)headerLoadingView {
    if (!_headerLoadingView) {
        _headerLoadingView = [SAHeaderLoadingView loadingWithTitle:@"正在玩命的加载数据~" frame:CGRectMake(0, -LOADING_HEADER_VIEW_HEIGHT, SCREEN_WIDTH, LOADING_HEADER_VIEW_HEIGHT)];
    }
    return _headerLoadingView;
}

// 下拉刷新组件
- (SAFooterLoadingView *)footerLoadingView {
    if (!_footerLoadingView) {
        _footerLoadingView = [[SAFooterLoadingView alloc] initWithFrame:CGRectMake(0, self.tableFooterView.frame.size.height, SCREEN_WIDTH, FOOTER_VIEW_LOADING_HEIGHT)];
    }
    return _footerLoadingView;
}

- (void)stopLoadingAnimate {
    if (self.contentOffset.y <= 0) {
        [self endHeaderLoading];
    } else {
        [self endFooterLoading];
    }
}


#pragma mark -
#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY <= 0) {
        // 旋转
        [self.headerLoadingView roateOutView:offsetY];
    }

    // 显示提示,可以松开
    if (offsetY <= -LOADING_HEADER_VIEW_HEIGHT) {
        [self.headerLoadingView prepareAnimation];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.headerLoadingView stopAnimation];
    [self.footerLoadingView stopAnimation];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY <= -LOADING_HEADER_VIEW_HEIGHT) {
        scrollView.contentInset = UIEdgeInsetsMake(110, 0, 0, 0);
        scrollView.scrollsToTop = NO;
    } else if(offsetY >= (scrollView.contentSize.height-scrollView.frame.size.height)) {
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, FOOTER_VIEW_LOADING_HEIGHT, 0);
        scrollView.scrollsToTop = NO;
    } else {
        [self resetLoadingState];
    }
}

- (void)resetLoadingState {
    self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.scrollsToTop = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY <= -LOADING_HEADER_VIEW_HEIGHT) {
        [self.headerLoadingView endPrepareAnimation];
        [self.headerLoadingView startAnimation];
    }

    if ((offsetY-10) >= (scrollView.contentSize.height-scrollView.frame.size.height)) {
        [self.footerLoadingView startAnimation];
    }
}

#pragma mark -
#pragma mark SAHeaderLoadingViewDelegate
- (void)endHeaderLoadingAnimation:(SAHeaderLoadingView *)headerLoadingView {
    // 加载最新数据
    if ([self.loadingDelegate respondsToSelector:@selector(endHeaderLoadingAnimation:)]) {
        [self.loadingDelegate endHeaderLoadingAnimation:headerLoadingView];
    }
}


#pragma mark -
#pragma mark SAFooterLoadingViewDelegate
- (void)endFooterLoadingAnimation:(SAFooterLoadingView *)footerLoadingView {
    // 下拉加载更多数据
    if ([self.loadingDelegate respondsToSelector:@selector(endFooterLoadingAnimation:)]) {
        [self.loadingDelegate endFooterLoadingAnimation:footerLoadingView];
    }
}

// 删除通知
- (void)addAllNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopLoadingAnimate) name:NOTI_END_LOADING object:nil];
}

- (void)removeAllNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc {
    [self removeAllNotifications];
}

@end
