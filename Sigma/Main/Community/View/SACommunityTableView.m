//
//  SACommunityTableView.m
//  Sigma
//
//  Created by 汤轶侬 on 16/7/20.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SACommunityTableView.h"
#import "SACommunityTableHeaderView.h"
#import "SACommunityTableHeaderView.h"

#define COMMUNITY_TABLE_HEADER_VIEW 170

@interface SACommunityTableView()

@property (nonatomic, strong) SACommunityTableHeaderView *headerView;

@end

@implementation SACommunityTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        self.tableHeaderView = self.headerView;
    }
    
    return self;
}

- (SACommunityTableHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[SACommunityTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, COMMUNITY_TABLE_HEADER_VIEW)];
    }
    
    return _headerView;
}

@end
