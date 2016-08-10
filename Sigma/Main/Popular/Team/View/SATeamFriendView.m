//
//  SATeamFriendView.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/4.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SATeamFriendView.h"
#import "SATeamRequest.h"
#import "CLProgressHUD.h"
#import "SAGroupModel.h"
#import "SAFriendCell.h"
#import "SAFriendHeaderView.h"

#define CELL_HEIGHT 55
#define HEADER_HEIGHT 45

@interface SATeamFriendView() <UITableViewDelegate, UITableViewDataSource, SAFriendHeaderViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *groups;

@end

@implementation SATeamFriendView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        [self setupUI];

        [self addAllNotifications];

        [self sendRequest];
    }
    return self;
}

- (void)dealloc {
    [self removeAllNotifications];
}

- (void)setupUI {
    [self addSubview:self.tableView];
}

- (NSMutableArray *)groups {
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (void)setupFriends:(NSMutableArray *)groups {
    for (int i = 0; i < groups.count; ++i) {
        SAGroupModel *groupModel = [SAGroupModel groupsModelWith:groups[(NSUInteger)i]];
        [self.groups addObject:groupModel];
    }

    [self.tableView reloadData];
}

- (void)sendRequest {
    // 显示 加载图片
    [CLProgressHUD showInView:self delegate:self tag:1 title:@"获取好友列表..."];

    [SATeamRequest getFriends];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-44) style:UITableViewStylePlain];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.bounces = NO;

        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark -- 获取朋友信息
- (void)receiveFriendsSuccess:(NSNotification *)notification {
    if ([notification.userInfo[@"code"] intValue] == 200) {
        [self setupFriends:notification.userInfo[@"data"]];
        [CLProgressHUD dismissHUDByTag:1 delegate:self inView:self];
    } else {
        [CLProgressHUD dismissHUDByTag:1 delegate:self inView:self];
        [CLProgressHUD showErrorInView:self delegate:self title:@"加载失败!" duration:.5];
    }
}

- (void)receiveFriendsFailed:(NSNotification *)notification {
    [CLProgressHUD dismissHUDByTag:1 delegate:self inView:self];
    [CLProgressHUD showErrorInView:self delegate:self title:@"请稍后再试!" duration:.5];
}

#pragma mark -
#pragma mark Notifications
- (void)addAllNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveFriendsSuccess:) name:NOTI_TEAM_FRIEND object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveFriendsFailed:) name:NOTI_TEAM_FRIEND_ERROR object:nil];
}

- (void)removeAllNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HEADER_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *headerIdentifier = @"FriendHeaderView";
    SAFriendHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];

    if (!headerView) {
        headerView = [[SAFriendHeaderView alloc] initWithReuseIdentifier:headerIdentifier];
    }

    headerView.delegate = self;

    SAGroupModel *groupModel = (SAGroupModel *)self.groups[(NSUInteger)section];

    headerView.groupModel = groupModel;

    headerView.tag = section;

    headerView.rotageImageView = groupModel.isExplain;

    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SAFriendCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    [cell setSelected:!cell.isSelected];

    if ([self.ownDelegate respondsToSelector:@selector(friendView:cellDidClicked:)]) {
        [self.ownDelegate friendView:self cellDidClicked:cell];
    }
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SAGroupModel *groupModel = (SAGroupModel *)self.groups[(NSUInteger)section];
    return groupModel.isExplain ? groupModel.friends.count : 0;
//    return  groupModel.friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"friendCell";
    SAFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!cell) {
        cell = [[SAFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    SAGroupModel *groupModel = (SAGroupModel *)self.groups[(NSUInteger)indexPath.section];
    SAFriendFrameModel *frameModel = groupModel.friends[(NSUInteger)indexPath.row];

    cell.frameModel = frameModel;

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

#pragma mark -
#pragma mark SAFriendHeaderViewDelegate
- (void)friendHeaderView:(SAFriendHeaderView *)friendHeaderView didClickButton:(UIButton *)button {
    friendHeaderView.rotageImageView = YES;

    NSInteger section = friendHeaderView.tag;

    SAGroupModel *groupModel = self.groups[(NSUInteger)section];

    groupModel.explain = !groupModel.isExplain;

    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:(NSUInteger)section];

    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}

@end
