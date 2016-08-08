//
//  SATeamMessageView.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/4.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SATeamMessageView.h"
#import "SAMessageCell.h"
#import "CLProgressHUD.h"
#import "SATeamRequest.h"
#import "SAUserDataManager.h"
#import "SAMessageModel.h"
#import "SAMessageModel.h"
#import "SAMessageFrameModel.h"

#define CELL_HEIGHT 75

@interface SATeamMessageView() <UITableViewDelegate, UITableViewDataSource, SAMessageCellDelegate>

@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic, strong) SAMessageCell *lastSwipeCell;

@end

@implementation SATeamMessageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.scrollEnabled = YES;

        self.separatorStyle = UITableViewCellSeparatorStyleNone;

        self.backgroundColor = [UIColor whiteColor];

        self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        self.useHeaderLoading = YES;

        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        self.useFooterLoading = YES;

        self.delegate = self;
        self.dataSource = self;
        
        self.userInteractionEnabled = YES;

        [self addAllNotifications];
        [self sendRequest];

        [CLProgressHUD showInView:self delegate:self tag:1 title:@"正在加载..."];
    }
    return self;
}

- (NSMutableArray *)messages {
    if (!_messages) {
        _messages = [NSMutableArray array];
    }
    return _messages;
}

- (void)sendRequest {
    NSDictionary *userDict = [SAUserDataManager readUser];
    [SATeamRequest requestAllMessages:[userDict[@"id"] intValue]];
}

- (void)setMessagesData:(NSArray *)datas {
    for (int i = 0; i < datas.count; ++i) {
        SAMessageModel *messageModel = [SAMessageModel messageWithDict:datas[(NSUInteger)i]];
        SAMessageFrameModel *frameModel = [[SAMessageFrameModel alloc] init];
        frameModel.messageModel = messageModel;
        [self.messages addObject:frameModel];
    }
    [self reloadData];
}

#pragma mark -
#pragma mark notifications
- (void)receiveMessagesSuccess:(NSNotification *)noti {
    if ([noti.userInfo[@"code"] intValue] == 200) {
        // 成功
        [self setMessagesData:noti.userInfo[@"data"]];
        [CLProgressHUD dismissHUDByTag:1 delegate:self inView:self];
        [CLProgressHUD showSuccessInView:self delegate:self title:@"加载成功!" duration:0.4];
        return;
    } else {
        [CLProgressHUD dismissHUDByTag:1 delegate:self inView:self];
        [CLProgressHUD showErrorInView:self delegate:self title:@"稍后再试!" duration:0.4];
    }
}

- (void)receiveMessagesError:(NSNotification *)noti {
    [CLProgressHUD dismissHUDByTag:1 delegate:self inView:self];
    [CLProgressHUD showErrorInView:self delegate:self title:@"网络出现问题, 稍后再试!" duration:0.4];
}

- (void) addAllNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessagesSuccess:) name:NOTI_TEAM_MESSAGES object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessagesError:) name:NOTI_TEAM_MESSAGES_ERROR object:nil];
}

- (void) removeAllNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SAMessageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:!cell.isSelected];

    // 回位上次滑动
    if (self.lastSwipeCell) {
        [self.lastSwipeCell resetOffset];
    }
}

#pragma mark -
#pragma mark
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MessageCell";
    SAMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[SAMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }

    cell.frameModel = self.messages[(NSUInteger)indexPath.row];
    cell.delegate = self;
    cell.tag = indexPath.row;
    cell.userInteractionEnabled = YES;

    // 点击事件
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClicked:)];
    gestureRecognizer.numberOfTapsRequired = 1;
    [cell addGestureRecognizer:gestureRecognizer];

    return cell;
}

- (void)cellClicked:(UIGestureRecognizer *)gestureRecognizer {
    /*SAMessageCell *cell = (SAMessageCell *)gestureRecognizer.view;
    // 进入聊天界面
    if ([self.ownDelegate respondsToSelector:@selector(messageCellDidClicked:)]) {
        [self.ownDelegate messageCellDidClicked:cell.frameModel.messageModel];
    }*/
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark -
#pragma mark SAMessageCellDelegate
- (void)cellWillSwipe:(SAMessageCell *)cell {
    if (self.lastSwipeCell) {
        [self.lastSwipeCell resetOffset];
    }
    self.lastSwipeCell = cell;
}

- (void)delBtnDidClicked:(SAMessageCell *)cell {
    [self.messages removeObjectAtIndex:(NSUInteger)cell.tag];
    [self deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:cell.tag inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
}

- (void)topBtnDidClicked:(SAMessageCell *)cell {
    [self.messages removeObjectAtIndex:(NSUInteger)cell.tag];
    [self deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:cell.tag inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    [self.messages insertObject:cell.frameModel atIndex:0];
    [self insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)dealloc {
    [self removeAllNotifications];
}

@end
