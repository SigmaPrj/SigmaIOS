//
//  SACommunityTableView.m
//  Sigma
//
//  Created by 汤轶侬 on 16/7/20.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SACommunityTableView.h"
#import "SACommunityUserModel.h"
#import "SACommunityTableHeaderView.h"

@interface SACommunityTableView()

@property (nonatomic, strong) SACommunityTableHeaderView *headerView;

@property (nonatomic, strong) NSDictionary* userDict; // 头部用户数据
@property (nonatomic, strong) NSArray* dynamicArray; // 动态内容数据

@end

@implementation SACommunityTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        self.tableHeaderView = self.headerView;
        
        // 加载数据
        [self initData];
    }
    
    return self;
}

- (void)initData {
    // 加载用户数据
    _userDict = @{@"user_id":@1, @"nickname": @"blackcater", @"image":@"community_test_avatar.png", @"bgImage":@"community_test_bg.png", @"is_approved":@1};
    
    // 加载动态数据
    
    // 显示数据
    [self renderData];
}

// 构造模型，显示数据和布局
- (void)renderData {
    self.headerView.userModel = [SACommunityUserModel userModelWithDict:self.userDict];
}

- (SACommunityTableHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[SACommunityTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, COMMUNITY_HEADER_VIEW_HEIGHT)];
    }
    
    return _headerView;
}

@end
