//
//  SACommunityTableView.m
//  Sigma
//
//  Created by 汤轶侬 on 16/7/15.
//  Copyright (c) 2016 Terence. All rights reserved.
//

#import "SACommunityTableView.h"
#import "SACommunityHeaderView.h"
#import "View+MASAdditions.h"


@interface SACommunityTableView() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) SACommunityHeaderView *headerView;

@end

@implementation SACommunityTableView

- (instancetype)init {
    self = [super initWithFrame:CGRectZero style:UITableViewStylePlain];
    if (self) {

        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;

        self.separatorStyle = UITableViewCellSeparatorStyleNone;

        self.tableHeaderView = self.headerView;

        [self.headerView mas_remakeConstraints:^(MASConstraintMaker *maker) {
            maker.left.top.right.equalTo(self);
            maker.height.mas_equalTo(COMMUNITY_HEADER_VIEW_HEIGHT);
        }];

        [self.headerView updateConstraints];
    }

    return self;
}

- (SACommunityHeaderView *)headerView {
    if (!_headerView) {
        // FIXME: 模拟数据
        _headerView = [[SACommunityHeaderView alloc] initWithUsername:@"blackcater"
                                                              bgImage:@"community_test_bg.png"
                                                          avatarImage:@"community_test_avatar.png"];
    }
    return _headerView;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {


    [super updateConstraints];
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


#pragma mark -
#pragma mark UITableViewDelegate

/*- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}*/

@end
