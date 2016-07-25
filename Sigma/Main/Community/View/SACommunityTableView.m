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
#import "SADynamicModel.h"
#import "SADynamicFrameModel.h"

@interface SACommunityTableView()

@property (nonatomic, strong) SACommunityTableHeaderView *headerView;

@property (nonatomic, strong) NSDictionary* userDict; // 头部用户数据

@property (nonatomic, strong) NSMutableArray* dynamicArray; // 动态内容数据

@end

@implementation SACommunityTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        self.tableHeaderView = self.headerView;
    }
    
    return self;
}

- (void)setHeaderData:(NSDictionary *)dict {
    _userDict = dict;
    
    [self renderHeaderData];
}

- (void)setDynamicData:(NSArray *)dynamicArray {
    for (int i = 0; i < dynamicArray.count; ++i) {
        SADynamicModel *dynamicModel = [SADynamicModel dynamicWithDict:dynamicArray[(NSUInteger)i]];
        SADynamicFrameModel *frameModel = [[SADynamicFrameModel alloc] init];
        frameModel.dynamicModel = dynamicModel;
        [self.dynamicArray addObject:frameModel];
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

- (SACommunityTableHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[SACommunityTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, COMMUNITY_HEADER_VIEW_HEIGHT)];
    }
    
    return _headerView;
}

@end
