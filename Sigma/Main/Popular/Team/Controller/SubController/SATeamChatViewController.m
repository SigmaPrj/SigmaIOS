//
//  SATeamChatViewController.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/5.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SATeamChatViewController.h"
#import "SAMessageModel.h"
#import "SATeamChatTableView.h"
#import "SATeamChatBar.h"
#import "UIView+HRExtention.h"
#import "SATeamRequest.h"
#import "SAUserDataManager.h"
#import "CLProgressHUD.h"

@interface SATeamChatViewController ()

@property (nonatomic, assign) int uid;
@property (nonatomic, strong) SAMessageModel *messageModel;
@property (nonatomic, strong) SATeamChatTableView *tableView;
@property (nonatomic, strong) SATeamChatBar *chatBar;

@end

@implementation SATeamChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)initWithMessageModel:(SAMessageModel *)messageModel{
    self = [super init];
    if (self) {
        _uid = messageModel.user_id;
        _messageModel = messageModel;

        self.title = messageModel.nickname;
        self.navigationController.navigationBar.tintColor = SIGMA_FONT_COLOR;
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ChatBackground"]];
        self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.view setUserInteractionEnabled:YES];

        [self setupUI];
        [self addAllNotifications];
        [self sendRequest];
    }
    return self;
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.chatBar];
}

- (SATeamChatTableView *)tableView {
    if (!_tableView) {
        _tableView = [[SATeamChatTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-50) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ChatBackground"]];
        _tableView.messageModel = self.messageModel;

        // 点击
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewClicked:)];
        gestureRecognizer.numberOfTapsRequired = 1;
        [_tableView addGestureRecognizer:gestureRecognizer];
    }
    return _tableView;
}

- (SATeamChatBar *)chatBar {
    if (!_chatBar) {
        _chatBar = [[SATeamChatBar alloc] initWithFrame: CGRectMake(0, SCREEN_HEIGHT-64-50, SCREEN_WIDTH, 50)];
    }
    return _chatBar;
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    CGRect beginRect = [dict[@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue];
    CGRect endRect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    double offsetY = beginRect.origin.y - endRect.origin.y;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:[dict[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue] animations:^{
        weakSelf.chatBar.y = (CGFloat)(endRect.origin.y - 50 -64);
        weakSelf.tableView.height = (CGFloat)(weakSelf.tableView.height-offsetY);
    }];
}

- (void)sendRequest {
    [SATeamRequest requestMessagesOfUser:[SAUserDataManager readUserId] sUser:self.uid];
    [CLProgressHUD showInView:self.view delegate:self tag:1 title:@"正在加载..."];
}

#pragma mark -
#pragma mark notifications
- (void)receiveUserMessagesSuccess:(NSNotification *)notification {
    if ([notification.userInfo[@"code"] intValue] == 200) {
        [self.tableView setDatas:notification.userInfo[@"data"]];
    }
    [CLProgressHUD dismissHUDByTag:1 delegate:self inView:self.view];

}

- (void)receiveUserMessagesError:(NSNotification *)notification {
    [CLProgressHUD dismissHUDByTag:1 delegate:self inView:self.view];
    [CLProgressHUD showErrorInView:self.view delegate:self title:@"数据加载失败!" duration:0.4];
}

- (void)addAllNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveUserMessagesSuccess:) name:NOTI_TEAM_USER_MESSAGES object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveUserMessagesError:) name:NOTI_TEAM_USER_MESSAGES_ERROR object:nil];
}

- (void)removeAllNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc {
    [self removeAllNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableViewClicked:(UITapGestureRecognizer *)recognizer {
    [self.chatBar reset];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
