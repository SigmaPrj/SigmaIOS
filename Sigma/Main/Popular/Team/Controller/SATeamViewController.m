//
//  SATeamViewController.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/4.
//  Copyright (c) 2016 sigma. All rights reserved.
//

//#import <XMNChat/XMNChat.h>
#import <JMessage/JMessage.h>
#import "SATeamViewController.h"
#import "UIView+HRExtention.h"
#import "SATeamMessageView.h"
#import "SATeamFriendView.h"
#import "SATeamTeamView.h"
#import "SAMessageModel.h"
#import "ChatCollectionViewController.h"
#import "XTPopView.h"
#import "JCAlertView.h"
#import "SATeamRequest.h"
#import "CLProgressHUD.h"
#import "SAFriendModel.h"
#import "SAFriendCell.h"
#import "SAFriendFrameModel.h"
#import "SAUserDataManager.h"
#import "SATeamAddUserView.h"
#import "SATeamJoinGroupView.h"
#import "SATeamCreateGroupView.h"

#define KStatusHeight 20
#define KNavBarHeight 44
#define ICON_BTN_SIZE 30

@interface SATeamViewController () <SATeamMessageViewDelegate, selectIndexPathDelegate, SATeamFriendViewDelegate, SATeamAddUserViewDelegate, SATeamJoinGroupViewDelegate, SATeamCreateGroupViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *customBtn;
@property (nonatomic, strong) XTPopView *popView;

@property (nonatomic, strong) JCAlertView *alertView1;
@property (nonatomic, strong) JCAlertView *alertView2;
@property (nonatomic, strong) JCAlertView *alertView3;

@end

@implementation SATeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = NO;

    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.scrollView];

    [self.navigationController.navigationBar setTintColor:SIGMA_FONT_COLOR];

    self.title = @"消息";

    // 设置title
    [self setupTitle];

    // 设置右上角
    [self setupRightTopBtn];

    // 添加监听事件
    [self addAllNotifications];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)dealloc {
    [self removeAllNotifications];
}

- (void)setupRightTopBtn {
    self.view.backgroundColor = [UIColor whiteColor];
    _customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _customBtn.frame = CGRectMake(0, 0, 40, 40);
    [_customBtn setTitle:@"➕" forState:UIControlStateNormal];
    [_customBtn addTarget:self action:@selector(addBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:_customBtn];
    self.navigationItem.rightBarButtonItem = btn;
}

- (void)addBtnClicked:(UIButton *)btn {
    CGPoint point = CGPointMake(btn.center.x , btn.frame.origin.y+55);
    _popView = [[XTPopView alloc] initWithOrigin:point Width:130 Height:40 * 4 Type:XTTypeOfUpRight Color:[UIColor colorWithRed:0.2737 green:0.2737 blue:0.2737 alpha:1.0]];
    _popView.dataArray = @[@"添加好友",@"邀请入队", @"创建队伍", @"扫一扫"];
    _popView.images = @[@"add_person",@"join_group", @"create_group", @"scan"];
    _popView.fontSize = 13;
    _popView.row_height = 40;
    _popView.titleTextColor = [UIColor whiteColor];
    _popView.delegate = self;
    [_popView popView];
}

#pragma mark -
#pragma mark selectIndexPathDelegate
- (void)selectIndexPathRow:(NSInteger)index {
    [_popView dismiss];
    switch (index) {
        case 0:
        {
            NSLog(@"添加好友");
            SATeamAddUserView *addUserView = [[SATeamAddUserView alloc] initWithFrame:CGRectMake(0, 0, 300, 0)];
            addUserView.delegate = self;
            _alertView1 = [[JCAlertView alloc] initWithCustomView:addUserView dismissWhenTouchedBackground:YES];
            [_alertView1 show];
        }
            break;
        case 1:
        {
            NSLog(@"邀请入队");
            SATeamJoinGroupView *joinGroupView = [[SATeamJoinGroupView alloc] initWithFrame:CGRectMake(0, 0, 300, 0)];
            joinGroupView.delegate = self;
            _alertView2 = [[JCAlertView alloc] initWithCustomView:joinGroupView dismissWhenTouchedBackground:YES];
            [_alertView2 show];
        }
            break;
        case 2:
        {
            NSLog(@"创建队伍");
            SATeamCreateGroupView *createGroupView = [[SATeamCreateGroupView alloc] initWithFrame:CGRectMake(0, 0, 300, 0)];
            createGroupView.delegate = self;
            _alertView3 = [[JCAlertView alloc] initWithCustomView:createGroupView dismissWhenTouchedBackground:YES];
            [_alertView3 show];
        }
            break;
        case 3:
        {
            NSLog(@"扫一扫");
        }
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark SATeamAddUserViewDelegate
- (void)addCustomView:(SATeamAddUserView *)addUserView cancelBtnDidClicked:(UIButton *)cancelBtn {
    [_alertView1 dismissWithCompletion:nil];
}

- (void)addCustomView:(SATeamAddUserView *)addUserView sureBtnDidClicked:(UIButton *)sureBtn username:(NSString *)username {

    __weak typeof(self) weakSelf = self;
    [JMSGConversation createSingleConversationWithUsername:username completionHandler:^(id resultObject, NSError *error) {
        if (!error) {
            // 请求添加好友
            [_alertView1 dismissWithCompletion:nil];
            
            [SATeamRequest addFriend:username];
        } else {
            NSLog(@"单人聊天创建失败!\nerror : %ld ; %@", (long)error.code, error.description);
        }
    }];
}

#pragma mark -
#pragma mark SATeamJoinGroupViewDelegate
- (void)joinCustomView:(SATeamJoinGroupView *)joinGroupView cancelBtnDidClicked:(UIButton *)cancelBtn {
    [_alertView2 dismissWithCompletion:nil];
}

- (void)joinCustomView:(SATeamJoinGroupView *)joinGroupView sureBtnDidClicked:(UIButton *)sureBtn group:(NSString *)group username:(NSString *)username {
    JMSGConversation *groupConversation = [JMSGConversation groupConversationWithGroupId:group];
    __weak typeof(self) weakSelf = self;
    [((JMSGGroup *) (groupConversation.target)) addMembersWithUsernameArray:@[username] completionHandler:^(id resultObject, NSError *error) {
        if (!error) {
            [_alertView2 dismissWithCompletion:nil];
            [CLProgressHUD showSuccessInView:weakSelf.view delegate:weakSelf title:@"队员添加成功!" duration:.5];
        } else {
            [CLProgressHUD showSuccessInView:weakSelf.view delegate:weakSelf title:@"队员添加失败!" duration:.5];
        }
    }];

}

#pragma mark -
#pragma mark SATeamCreateGroupViewDelegate
- (void)createCustomView:(SATeamCreateGroupView *)createGroupView cancelBtnDidClicked:(UIButton *)cancelBtn {
    [_alertView3 dismissWithCompletion:nil];
}

- (void)createCustomView:(SATeamCreateGroupView *)createGroupView sureBtnDidClicked:(UIButton *)sureBtn groupName:(NSString *)groupName groupDesc:(NSString *)groupDesc username:(NSString *)username {
    __weak typeof(self) weakSelf = self;
    [JMSGGroup createGroupWithName:groupName desc:groupDesc memberArray:@[username] completionHandler:^(id resultObject, NSError *error) {
        if (!error) {
            [_alertView3 dismissWithCompletion:^{
                // 显示加载图片
                [CLProgressHUD showInView:weakSelf.view delegate:weakSelf tag:8 title:@"正在创建队伍..."];

                NSString *groupId = ((JMSGGroup *)resultObject).gid;
                NSDictionary *userData = [SAUserDataManager readUser];

                NSDictionary *params = @{
                        @"group_id" : groupId,
                        @"group_name" : groupName,
                        @"desc" : groupDesc,
                        @"avatar" : @"http://oaetkzt9k.bkt.clouddn.com/avatar60@3x.png",
                        @"creator" : userData[@"username"]
                };

                // 添加组信息到数据库
                [SATeamRequest createGroup:params];
            }];

        } else {
            [CLProgressHUD showErrorInView:weakSelf.view delegate:weakSelf title:@"队伍创建失败!" duration:.5];
        }
    }];
}

-(void) setupTitle {
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"消息",@"好友", @"队伍"]];
    //设置宽度
    segment.width = 180;
    //设置选中和普通状态 文字颜色为白色
    [segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.44 green:0.42 blue:0.41 alpha:0.5]} forState:UIControlStateNormal];
    [segment setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateSelected];
    [segment setTintColor:[UIColor colorWithRed:0.16 green:0.15 blue:0.14 alpha:0.5]];

    //默认选中第0个
    segment.selectedSegmentIndex = 0;

    //添加
    self.navigationItem.titleView = segment;
    _segment = segment;
    //添加点击方法
    [segment addTarget:self action:@selector(segmentClick) forControlEvents:UIControlEventValueChanged];
}

- (void)segmentClick{
    CGPoint offsetPoint = CGPointMake(self.segment.selectedSegmentIndex * SCREEN_WIDTH, 0);
    [self.scrollView setContentOffset:offsetPoint];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, 0);
        _scrollView.contentOffset = CGPointMake(0, 0);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.alwaysBounceHorizontal = NO;
        _scrollView.alwaysBounceVertical = NO;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = NO;

        [self addViewsToScrollView];
    }
    return _scrollView;
}

- (void)addViewsToScrollView {
    for (int i = 0; i <3; ++i) {
        UIView *teamView;
        switch (i) {
            case 0:
            {

                teamView = [[SATeamMessageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT(self.scrollView))];

                ((SATeamMessageView *)teamView).ownDelegate = self;
            }
                break;
            case 1:
            {

                teamView = [[SATeamFriendView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, HEIGHT(self.scrollView))];
                ((SATeamFriendView *)teamView).ownDelegate = self;

            }
                break;
            case 2:
            {

                teamView = [[SATeamTeamView alloc] initWithFrame:CGRectMake(2*SCREEN_WIDTH, 0, SCREEN_WIDTH, HEIGHT(self.scrollView))];

            }
                break;
            default:
                break;
        }

        [self.scrollView addSubview:teamView];
    }
}

#pragma mark -
#pragma mark SATeamMessageViewDelegate
- (void)messageCellDidClicked:(SAMessageModel *)messageModel {
    // TODO : 修改这儿


    ChatCollectionViewController *chatCollectionViewController = [[ChatCollectionViewController alloc] init];

    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatCollectionViewController animated:YES];
    self.hidesBottomBarWhenPushed = NO;


//    SATeamChatViewController *viewController = [[SATeamChatViewController alloc] initWithMessageModel:messageModel];
//    self.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:viewController animated:YES];
//    self.hidesBottomBarWhenPushed=NO;

/*    XMNChatController *chatController = [[XMNChatController alloc] initWithChatMode:XMNChatSingle];

    SAChatView *chatView = [[SAChatView alloc] initWithChatMode:XMNChatSingle];
    chatController.chatVM = chatView;
    chatView.messageModel = messageModel;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatController animated:YES];

    self.hidesBottomBarWhenPushed = NO;*/

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Notifications
- (void)addAllNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addFriendSuccess:) name:NOTI_TEAM_ADD_USER object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addFriendFailed:) name:NOTI_TEAM_ADD_USER_ERROR object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addTeamSuccess:) name:NOTI_TEAM_ADD_TEAM object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addTeamFailed:) name:NOTI_TEAM_ADD_TEAM_ERROR object:nil];
}

- (void)removeAllNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark --NOTI_TEAM_ADD_TEAM
- (void)addTeamSuccess:(NSNotification *)notification {
    if ([notification.userInfo[@"code"] intValue] == 200) {
        [CLProgressHUD dismissHUDByTag:8 delegate:self inView:self.view];
        [CLProgressHUD showSuccessInView:self.view delegate:self title:@"队伍创建成功!" duration:.5];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_TEAM_CREATE_TEAM object:nil userInfo:notification.userInfo[@"data"]];
    } else {
        [CLProgressHUD dismissHUDByTag:8 delegate:self inView:self.view];
        [CLProgressHUD showErrorInView:self.view delegate:self title:@"队伍创建失败!" duration:.5];
    }
}

- (void)addTeamFailed:(NSNotification *)notification {
    [CLProgressHUD dismissHUDByTag:8 delegate:self inView:self.view];
    [CLProgressHUD showErrorInView:self.view delegate:self title:@"请稍后再试!" duration:.5];
}

#pragma mark -- NOTI_TEAM_ADD_USER
- (void)addFriendSuccess:(NSNotification *)notification {
    if ([notification.userInfo[@"code"] intValue] == 200) {

        // 添加用户成功 跳转到对话页面
        NSDictionary *userDict = notification.userInfo[@"data"][@"user"];
        NSDictionary *friendDict = notification.userInfo[@"data"][@"friend"];
        NSDictionary *userData = notification.userInfo[@"data"][@"userData"];

        // 通知本地添加好友
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_TEAM_USER_ADD object:nil userInfo:userData];

        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            ChatCollectionViewController *chatCollectionViewController = [[ChatCollectionViewController alloc] init];
            [chatCollectionViewController setLeftUserData:[friendDict[@"id"] intValue] username:friendDict[@"username"] avatar:friendDict[@"image"] nickname:friendDict[@"nickname"]];
            [chatCollectionViewController setRightUserData:[userDict[@"id"] intValue] username:userDict[@"username"] avatar:userDict[@"image"] nickname:userDict[@"nickname"]];
            weakSelf.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:chatCollectionViewController animated:YES];
            weakSelf.hidesBottomBarWhenPushed = NO;
        });
    } else {
        [CLProgressHUD showErrorInView:self.view delegate:self title:@"添加失败!" duration:.5];
    }
}

- (void)addFriendFailed:(NSNotification *)notification {
    [CLProgressHUD showErrorInView:self.view delegate:self title:@"稍后再试!" duration:.5];
}

#pragma mark -
#pragma mark SATeamFriendViewDelegate
- (void)friendView:(SATeamFriendView *)friendView cellDidClicked:(SAFriendCell *)friendCell {
    SAFriendFrameModel *frameModel = friendCell.frameModel;
    SAFriendModel *friendModel = frameModel.friendModel;

    NSDictionary *userDict = [SAUserDataManager readUser];

    ChatCollectionViewController *chatCollectionViewController = [[ChatCollectionViewController alloc] init];
    [chatCollectionViewController setLeftUserData:friendModel.userId username:friendModel.username avatar:friendModel.avatar nickname:friendModel.nickname];
    [chatCollectionViewController setRightUserData:[userDict[@"id"] intValue] username:userDict[@"username"] avatar:userDict[@"image"] nickname:userDict[@"nickname"]];


    __weak typeof(self) weakSelf = self;
    NSString *usernameStr = [NSString stringWithFormat:@"%@", friendModel.username];
    [JMSGConversation createSingleConversationWithUsername:usernameStr completionHandler:^(id resultObject, NSError *error) {
        if (!error) {
            weakSelf.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:chatCollectionViewController animated:YES];
            weakSelf.hidesBottomBarWhenPushed = NO;
        } else {
            [CLProgressHUD showErrorInView:weakSelf.view delegate:weakSelf title:@"稍后再试!" duration:.5];
        }
    }];

}

@end
