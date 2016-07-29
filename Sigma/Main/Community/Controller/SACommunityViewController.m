//
//  SACommunityViewController.m
//  Sigmaprj
//
//  Created by Terence on 16/7/13.
//  Copyright © 2016年 Sigma. All rights reserved.
//  @author : blackcater
//

#import "SACommunityViewController.h"
#import "SACommunityTableView.h"
#import "SACommunityRequest.h"

#define COMMUNITY_BOTTOM 64

@interface SACommunityViewController ()

@property (nonatomic, strong) SACommunityTableView *communityTableView;

@end

@implementation SACommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加通知
    [self addAllNotification];
    
    // 发送数据请求
    [self sendRequest];
    
    [self render];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self render];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [self removeAllNotification];
    [super viewWillDisappear:animated];
}

- (void)render {
    [self.view addSubview:self.communityTableView];
}

// 惰性加载
- (SACommunityTableView *)communityTableView {
    if (!_communityTableView) {
        _communityTableView = [[SACommunityTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT-COMMUNITY_BOTTOM)) style:UITableViewStylePlain];
        _communityTableView.showsHorizontalScrollIndicator = NO;
        _communityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _communityTableView;
}

- (void)sendRequest {
    // 发送请求
    
    // 请求用户数据
    [SACommunityRequest requestHeaderUserData:28];
    
    // 请求dynamic数据
    [SACommunityRequest requestDynamics:nil user_id:28 token:@"b42754e673e94f5eaef972c4ae4a4c06"];
}

#pragma mark -
#pragma mark 通知
- (void) addAllNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataSuccessHandler:) name:NOTI_COMMUNITY_USER_DATA object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataSuccessHandler:) name:NOTI_COMMUNITY_DYNAMICS_DATA object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataSuccessHandler:) name:NOTI_COMMUNITY_DYNAMIC_COMMENTS_DATA object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataErrorHandler:) name:REQUEST_DATA_ERROR object:nil];
}

- (void) removeAllNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*!
 * 从服务器获取数据成功
 * @param noti
 */
- (void)receiveDataSuccessHandler:(NSNotification *)noti {
    // table view header数据
    if ([noti.name isEqualToString:NOTI_COMMUNITY_USER_DATA]) {
        if ([noti.userInfo[@"status"] intValue] == 1) {
            // 加载用户数据成功
            [self.communityTableView setHeaderData:noti.userInfo[@"data"]];
        }
    }
    
    if ([noti.name isEqualToString:NOTI_COMMUNITY_DYNAMICS_DATA]) {
        if ([noti.userInfo[@"status"] intValue] == 1) {
            // 加载动态数据成功
            [self.communityTableView setDynamicData:noti.userInfo[@"data"]];
        }
    }
}


/*!
 * 从服务器获取数据失败
 * @param notification
 */
- (void)receiveDataErrorHandler:(NSNotification *)notification {
    NSLog(@"数据加载失败!");
}

@end
