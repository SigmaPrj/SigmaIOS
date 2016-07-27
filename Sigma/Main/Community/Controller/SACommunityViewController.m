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
#import "UIView+SAPublishBtnFrame.h"

#define COMMUNITY_BOTTOM 64

@interface SACommunityViewController ()

@property (nonatomic, strong) SACommunityTableView *communityTableView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, assign) BOOL firstRequest;

@end

@implementation SACommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self render];

    self.firstRequest = YES;

    // 添加通知
    [self addAllNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (self.firstRequest) {
        [self sendRequest];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    // 移除所有事件监听
    [self removeAllNotification];
    [super viewWillDisappear:animated];
}

- (void)render {
    [self.view addSubview:self.communityTableView];

    [self.maskView addSubview:self.indicatorView];
    [self.view addSubview:self.maskView];

    // 开始显示加载动画
    [self startLoading];
}

// 惰性加载
- (SACommunityTableView *)communityTableView {
    if (!_communityTableView) {
        _communityTableView = [[SACommunityTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT-COMMUNITY_BOTTOM-49)) style:UITableViewStylePlain];
        _communityTableView.showsHorizontalScrollIndicator = NO;
        _communityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _communityTableView;
}

// 遮罩层
- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT-COMMUNITY_BOTTOM))];
        _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    }
    return _maskView;
}

// 加载视图
- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [_indicatorView setCenterX:SCREEN_WIDTH/2];
        [_indicatorView setCenterY:200];
    }
    return _indicatorView;
}

- (void)startLoading {
    [self.indicatorView startAnimating];
}

- (void)endLoading {
    [self.indicatorView stopAnimating];
}

/**
 * 发送请求
 */
- (void)sendRequest {
    // 发送请求

    // 请求用户数据
    [SACommunityRequest requestHeaderUserData:28];

    // 请求dynamic数据
    [SACommunityRequest requestDynamics:@{@"t": @(503781928)} user_id:28 token:@"b42754e673e94f5eaef972c4ae4a4c06"];
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
        } else {
            [self alert:@"用户数据加载失败" message:noti.userInfo[@"error"]];
        }
    }
    
    if ([noti.name isEqualToString:NOTI_COMMUNITY_DYNAMICS_DATA]) {
        if ([noti.userInfo[@"status"] intValue] == 1) {
            // 加载动态数据成功
            [self.communityTableView setDynamicData:noti.userInfo[@"data"]];
            if (self.firstRequest) {
                // 停止加载动画
                self.firstRequest = NO;
                [self deleteMaskView];
            }
        } else {
            [self alert:@"动态数据加载失败" message:noti.userInfo[@"error"]];
        }
    }
}

/**
 * 删除遮罩层
 */
- (void)deleteMaskView {
    [self endLoading];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.3 animations:^{
        weakSelf.maskView.alpha = 0;
    } completion:^(BOOL finished) {
        // 删除视图
        [weakSelf.indicatorView removeFromSuperview];
        [weakSelf.maskView removeFromSuperview];
    }];
}


/*!
 * 从服务器获取数据失败
 * @param notification
 */
- (void)receiveDataErrorHandler:(NSNotification *)notification {
    NSLog(@"%@", notification.userInfo);
    int code = [notification.userInfo[@"code"] intValue];
    switch (code) {
        case 404:
            [self.communityTableView stopLoading];
            [self alert:@"已是最新数据!" message:@""];
            break;
        case 400:
            [self alert:@"你没有权限这么做!" message:@""];
            break;
        default:
            [self alert:@"数据加载失败" message:@"你的网络好像出现了问题，请检查之后再试!"];
            break;
    }
}

/**
 * 首页自定义弹窗
 *
 * @param title
 * @param msg
 */
- (void)alert:(NSString *)title message:(NSString *)msg {
    // alert controller
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];

    __weak typeof(self) weakSelf = self;
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"算了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [weakSelf deleteMaskView];
    }];

    UIAlertAction *retryAction = [UIAlertAction actionWithTitle:@"重试" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [weakSelf sendRequest];
    }];

    [alertController addAction:cancelAction];
    [alertController addAction:retryAction];

    [self presentViewController:alertController animated:YES completion:nil];
}

@end
