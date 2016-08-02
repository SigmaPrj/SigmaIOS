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
#import "SADynamicCommentController.h"
#import "SVProgressHUD.h"
#import "JCAlertView.h"

#define COMMUNITY_BOTTOM 64



@interface SACommunityViewController () <SACommunityTableViewDelegate>

@property (nonatomic, strong) SACommunityTableView *communityTableView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, assign) BOOL firstRequest;

@end

@implementation SACommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self render];

    self.firstRequest = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // 添加通知
    [self addAllNotification];
    
    if (self.firstRequest) {
        // 开始显示加载动画
        [self startLoading];

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

    [self.view addSubview:self.maskView];
}

// 惰性加载
- (SACommunityTableView *)communityTableView {
    if (!_communityTableView) {
        _communityTableView = [[SACommunityTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT-COMMUNITY_BOTTOM-49)) style:UITableViewStylePlain];
        _communityTableView.showsHorizontalScrollIndicator = NO;
        _communityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        _communityTableView.ownDelegate = self;
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

- (void)startLoading {
    [SVProgressHUD show];
}

- (void)endLoading {
    [SVProgressHUD dismiss];
}

/**
 * 发送请求
 */
- (void)sendRequest {
    // 发送请求

    // 请求用户数据
    [SACommunityRequest requestHeaderUserData:28];

    // 请求dynamic数据
    [SACommunityRequest requestDynamics:@{@"t": @(503781928)} user_id:28 token:@"700425ab1fa44d702d70b6d854995e77"];
}

#pragma mark -
#pragma mark 通知
- (void) addAllNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataSuccessHandler:) name:NOTI_COMMUNITY_USER_DATA object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataSuccessHandler:) name:NOTI_COMMUNITY_DYNAMICS_DATA object:nil];
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


/*!
 * 从服务器获取数据失败
 * @param notification
 */
- (void)receiveDataErrorHandler:(NSNotification *)notification {
    int code = [notification.userInfo[@"code"] intValue];
    switch (code) {
        case 404:
        {
            int requestType = [notification.userInfo[@"requestType"] intValue];
            if (requestType == FIRST_REQUEST) {
                [self alert:@"温馨提示" message:@"没有和你相关的动态, 去关注些人吧(～ o ～)~zZ~"];
            } else if (requestType == LOAD_NEW_REQUEST) {
                [self alert:@"温馨提示" message:@"已经是最新数据╮(╯_╰)╭"];
                [self.communityTableView resetLoadingState];
                self.communityTableView.contentOffset = CGPointMake(0, 0);
            } else {
                [self alert:@"温馨提示" message:@"木有数据啦~\\(≧▽≦)/~"];
                [self.communityTableView resetLoadingState];
            }
        }
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
 * 删除遮罩层
 */
- (void)deleteMaskView {
    [self endLoading];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.3 animations:^{
        weakSelf.maskView.alpha = 0;
    } completion:^(BOOL finished) {
        // 删除视图
        [weakSelf.maskView removeFromSuperview];
    }];
}


/**
 * 首页自定义弹窗
 *
 * @param title
 * @param msg
 */
- (void)alert:(NSString *)title message:(NSString *)msg {
    __weak typeof(self) weakSelf = self;
    [JCAlertView showTwoButtonsWithTitle:title Message:msg ButtonType:JCAlertViewButtonTypeCancel ButtonTitle:@"算了" Click:^{
        [weakSelf deleteMaskView];
    } ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"重试" Click:^{
        [weakSelf sendRequest];
    }];
}

#pragma mark -
#pragma mark SACommunityTableViewDelegate
- (void)commentBtnDidClicked:(NSInteger)dynamic_id dynamicModel:(SADynamicModel *)dynamicModel {
    SADynamicCommentController *commentController = [[SADynamicCommentController alloc] initWithDynamicId:dynamic_id dynamicModel:dynamicModel];
    commentController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:commentController animated:YES];
}

@end
