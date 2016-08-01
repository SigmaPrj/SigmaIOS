//
//  SACommunityTableView.m
//  Sigma
//
//  Created by 汤轶侬 on 16/7/20.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SACommunityTableView.h"
#import "SACommunityUserModel.h"
#import "SADynamicModel.h"
#import "SADynamicModel.h"
#import "SACommunityTableHeaderView.h"
#import "SACommunityTableFooterView.h"
#import "SADynamicModel.h"
#import "SADynamicFrameModel.h"
#import "SADynamicTableViewCell.h"
#import "SAHeaderLoadingView.h"
#import "SAFooterLoadingView.h"
#import "SACommunityRequest.h"



@interface SACommunityTableView() <UITableViewDataSource, UITableViewDelegate, SAHeaderLoadingViewDelegate, SAFooterLoadingViewDelegate, SADynamicTableViewCellDelegate>

@property (nonatomic, strong) SACommunityTableHeaderView *headerView;
// 头部加载
@property (nonatomic, strong) SAHeaderLoadingView *headerLoadingView;

@property (nonatomic, strong) SACommunityTableFooterView *footerView;
// 底部加载
@property (nonatomic, strong) SAFooterLoadingView *footerLoadingView;

@property (nonatomic, strong) NSDictionary* userDict; // 头部用户数据

@property (nonatomic, strong) NSMutableArray* dynamicArray; // 动态内容数据

@property (nonatomic, assign) NSTimeInterval time; // 存储请求时间点

@end

@implementation SACommunityTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];

    if (self) {
        [self  addSubview:self.headerLoadingView];
        self.tableHeaderView = self.headerView;
        [self.footerView  addSubview:self.footerLoadingView];
        self.tableFooterView = self.footerView;

        self.dataSource = self;
        self.delegate = self;

        // 上拉刷新 代理
        self.headerLoadingView.delegate = self;
        // 下拉加载 代理
        self.footerLoadingView.delegate = self;
    }

    return self;
}

- (void)setHeaderData:(NSDictionary *)dict {
    _userDict = dict;

    [self renderHeaderData];
}

- (void)setDynamicData:(NSArray *)dynamicArray {

    if (self.dynamicArray.count == 0) {
        // 添加数据
        for (int i = 0; i < dynamicArray.count; ++i) {
            SADynamicModel *dynamicModel = [SADynamicModel dynamicWithDict:dynamicArray[(NSUInteger)i]];
            SADynamicFrameModel *frameModel = [[SADynamicFrameModel alloc] init];
            frameModel.dynamicModel = dynamicModel;
            [self.dynamicArray addObject:frameModel];
        }
        SADynamicFrameModel *firstDynamicFrameModel = self.dynamicArray.firstObject;
        self.time = (NSTimeInterval)firstDynamicFrameModel.dynamicModel.publish_time;
        [self reloadData];
        return;
    }

    NSDictionary *firstNewDynamicModel = dynamicArray.firstObject;
    NSDictionary *lastNewDynamicModel = dynamicArray.lastObject;
    SADynamicFrameModel *firstDynamicFrameModel = self.dynamicArray.firstObject;

    if ([firstNewDynamicModel[@"publish_date"] intValue] > firstDynamicFrameModel.dynamicModel.publish_time) {
        // 上拉刷新数据
        self.time = (NSTimeInterval)[lastNewDynamicModel[@"publish_date"] intValue];
        // 添加数据
        for (int i = 0; i < dynamicArray.count; ++i) {
            SADynamicModel *dynamicModel = [SADynamicModel dynamicWithDict:dynamicArray[(NSUInteger)i]];
            SADynamicFrameModel *frameModel = [[SADynamicFrameModel alloc] init];
            frameModel.dynamicModel = dynamicModel;
            [self.dynamicArray insertObject:frameModel atIndex:0];
            [self insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        }
    } else {
        // 下拉加载
        self.time = (NSTimeInterval) firstDynamicFrameModel.dynamicModel.publish_time;
        // 添加数据
        for (int i = 0; i < dynamicArray.count; ++i) {
            SADynamicModel *dynamicModel = [SADynamicModel dynamicWithDict:dynamicArray[(NSUInteger) i]];
            SADynamicFrameModel *frameModel = [[SADynamicFrameModel alloc] init];
            frameModel.dynamicModel = dynamicModel;
            [self.dynamicArray addObject:frameModel];
            [self insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:(self.dynamicArray.count-1) inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        }
    }
    
    [self stopLoading];
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

- (void)stopLoading {
    if (self.contentOffset.y <= 0) {
        [self endHeaderLoading];
    } else {
        [self endFooterLoading];
    }
}

// 构造模型，显示数据和布局
- (void)renderHeaderData {
    self.headerView.userModel = [SACommunityUserModel userModelWithDict:self.userDict];
}

- (NSMutableArray *)dynamicArray {
    if (!_dynamicArray) {
        _dynamicArray = [NSMutableArray array];
    }
    return _dynamicArray;
}

// headerView
- (SACommunityTableHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[SACommunityTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, COMMUNITY_HEADER_VIEW_HEIGHT)];
    }
    
    return _headerView;
}

// 上拉刷新组件
- (SAHeaderLoadingView *)headerLoadingView {
    if (!_headerLoadingView) {
        _headerLoadingView = [SAHeaderLoadingView loadingWithTitle:@"正在玩命的加载数据~" frame:CGRectMake(0, -LOADING_HEADER_VIEW_HEIGHT, SCREEN_WIDTH, LOADING_HEADER_VIEW_HEIGHT)];
    }
    return _headerLoadingView;
}

// 下拉加载组件
- (SACommunityTableFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[SACommunityTableFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, 0)];
    }

    return _footerView;
}

- (SAFooterLoadingView *)footerLoadingView {
    if (!_footerLoadingView) {
        _footerLoadingView = [[SAFooterLoadingView alloc] initWithFrame:CGRectMake(0, self.footerView.frame.size.height, SCREEN_WIDTH, FOOTER_VIEW_LOADING_HEIGHT)];
    }
    return _footerLoadingView;
}

#pragma mark -
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SADynamicFrameModel *frameModel = self.dynamicArray[(NSUInteger)indexPath.row];
    return [frameModel getTotalHeight];
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
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dynamicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"DynamicCell";

    SADynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil) {
        cell = [[SADynamicTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.frameModel = self.dynamicArray[(NSUInteger)indexPath.row];
    cell.delegate = self;

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark -
#pragma mark SAHeaderLoadingViewDelegate
- (void)endHeaderLoadingAnimation:(SAHeaderLoadingView *)loadingView {
    // 加载最新数据
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    [SACommunityRequest requestDynamics:@{@"t": @(self.time), @"now": @(now)} user_id:28 token:@"b42754e673e94f5eaef972c4ae4a4c06"];
}

#pragma mark -
#pragma mark SAFooterLoadingViewDelegate
- (void)endFooterLoadingAnimation:(SAFooterLoadingView *)footerLoadingView {
    // 下拉加载更多数据
    [SACommunityRequest requestDynamics:@{@"t": @(self.time), @"c": @(self.dynamicArray.count)} user_id:28 token:@"b42754e673e94f5eaef972c4ae4a4c06"];
}

#pragma mark -
#pragma mark SADynamicTableViewCellDelegate
- (void)commentBtnDidClicked:(SADynamicTableViewCell *)tableViewCell{
    int dynamic_id = tableViewCell.frameModel.dynamicModel.dynamic_id;
    SADynamicModel *dynamicModel = tableViewCell.frameModel.dynamicModel;

    if ([self.ownDelegate respondsToSelector:@selector(commentBtnDidClicked:dynamicModel:)]) {
        [self.ownDelegate commentBtnDidClicked:dynamic_id dynamicModel:dynamicModel];
    }
}

@end
