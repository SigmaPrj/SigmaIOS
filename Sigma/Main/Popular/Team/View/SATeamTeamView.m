//
//  SATeamTeamView.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/4.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <JMessage/JMessage.h>
#import "SATeamTeamView.h"
#import "CLProgressHUD.h"
#import "SATeamRequest.h"
#import "SATeamModel.h"
#import "SATeamFrameModel.h"
#import "SATeamCell.h"

#define CELL_HEIGHT 55

@interface SATeamTeamView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *teams;

@end

@implementation SATeamTeamView

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

- (void)setupUI {
    [self addSubview:self.tableView];
}

- (void)sendRequest {
    __weak typeof(self) weakSelf = self;
    [JMSGGroup myGroupArray:^(id resultObject, NSError *error) {
        if (!error) {
            NSArray *groups = resultObject;

            NSString *groupsStr = [groups componentsJoinedByString:@","];

            [SATeamRequest getGroups:groupsStr];

        } else {
            [CLProgressHUD showErrorInView:weakSelf delegate:weakSelf title:@"队伍加载失败!" duration:.5];
        }
    }];
}

- (void)dealloc {
    [self removeAllNotifications];
}

- (void)setupGroups:(NSMutableArray *)groups {
    for (int i = 0; i < groups.count; ++i) {
        SATeamModel *teamModel = [SATeamModel teamWithDict:groups[(NSUInteger)i]];
        SATeamFrameModel *frameModel = [[SATeamFrameModel alloc] init];
        frameModel.teamModel = teamModel;

        [self.teams addObject:frameModel];
    }

    [self.tableView reloadData];
}

- (NSMutableArray *)teams {
    if (!_teams) {
        _teams = [NSMutableArray array];
    }
    return _teams;
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


- (void)receiveGroupsSuccess:(NSNotification *)notification {
    if ([notification.userInfo[@"code"] intValue] == 200){
        [self setupGroups:notification.userInfo[@"data"]];
    } else {
        [CLProgressHUD showErrorInView:self delegate:self title:@"队伍加载失败!" duration:.5];
    }
}

- (void)receiveGroupsFailed:(NSNotification *)notification {
    [CLProgressHUD showErrorInView:self delegate:self title:@"请稍后再试!" duration:.5];
}

#pragma mark -
#pragma mark Notifications
- (void)addAllNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveGroupsSuccess:) name:NOTI_TEAM_GROUP object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveGroupsFailed:) name:NOTI_TEAM_GROUP_ERROR object:nil];
}

- (void)removeAllNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SATeamCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    [cell setSelected:!cell.isSelected];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT;
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.teams.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"TeamCell";

    SATeamCell *teamCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!teamCell) {
        teamCell = [[SATeamCell alloc] init];
    }

    teamCell.frameModel = self.teams[(NSUInteger)indexPath.row];

    return teamCell;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


@end
