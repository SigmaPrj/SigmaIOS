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

#define COMMUNITY_TOP 64
#define COMMUNITY_BOTTOM 44

@interface SACommunityViewController ()

@property (nonatomic, strong) SACommunityTableView *communityTableView;

@end

@implementation SACommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self render];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self render];
    
    // 添加通知
    [self addAllNotification];
    
    // 发送数据请求
    [self sendRequest];
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
    }
    return _communityTableView;
}

- (void)sendRequest {
    // 发送请求
    [SACommunityRequest requestHeaderUserData:1];
}

# pragma -
# pragma 通知
- (void) addAllNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataSuccessHandler:) name:NOTI_COMMUNITY_USER_DATA object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataSuccessHandler:) name:NOTI_COMMUNITY_DYNAMICS_DATA object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataSuccessHandler:) name:NOTI_COMMUNITY_DYNAMIC_COMMENTS_DATA object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataErrorHandler:) name:REQUEST_DATA_ERROR object:nil];
}

- (void) removeAllNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)receiveDataSuccessHandler:(NSNotification *)noti {
    NSLog(@"%@", noti);
    // table view header数据
    if ([noti.name isEqualToString:NOTI_COMMUNITY_USER_DATA]) {
        [self.communityTableView setHeaderData:noti.userInfo];
    }
    
    if ([noti.name isEqualToString:NOTI_COMMUNITY_DYNAMICS_DATA]) {
        NSLog(@"请求的动态数据: %@", noti.userInfo);
        // TODO : 设置数据
//        [self.communityTableView setDynamicData:];
    }
}

- (void)receiveDataErrorHandler:(NSNotification *)notification {
    NSLog(@"数据加载失败!");
}

@end
