//
//  SASignUpViewController.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/1.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SASignUpViewController.h"
#import "UIView+HRExtention.h"
#import "SASignUpWithTelephoneView.h"
#import "SASignUpWithEmailView.h"
#import "SASignUpWithCustomView.h"
#import "CLProgressHUD.h"
#import "SASignUpRequest.h"
#import "SASignUpUserInfoController.h"
#import "SAUserDataManager.h"

#define KStatusHeight 20
#define KNavBarHeight 44

@interface SASignUpViewController ()<UIScrollViewDelegate, SASignUpWithTelephoneViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger registerUserId; // 注册的用户id
@property (nonatomic, copy) NSString *username;

@end

@implementation SASignUpViewController

static NSString * const reuseIdentifier = @"SignUpCollectionCell";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = NO;

    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.scrollView];
    //设置title
    [self setupTitle];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // 添加监听事件
    [self addAllNotifications];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    // 清除监听事件
    [self removeAllNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setupTitle {
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"电话",@"邮箱", @"其他"]];
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
    CGPoint offsetPoint = CGPointMake(self.segment.selectedSegmentIndex * SCREEN_WIDTH, -(KStatusHeight+KNavBarHeight));
    [self.scrollView setContentOffset:offsetPoint];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, 0);
        _scrollView.contentOffset = CGPointMake(0, 0);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.alwaysBounceHorizontal = NO;
        _scrollView.alwaysBounceVertical = NO;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;

        [self addViewsToScrollView];
    }
    return _scrollView;
}

- (void)addViewsToScrollView {
    for (int i = 0; i <3; ++i) {
        UIView *signUpView;
        switch (i) {
            case 0:
            {
                // 根据电话号码进行设定
                signUpView = [[SASignUpWithTelephoneView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT(self.scrollView)-KStatusHeight-KNavBarHeight)];
                ((SASignUpWithTelephoneView *)signUpView).delegate = self;
            }
                break;
            case 1:
            {
                // 根据邮箱注册
                signUpView = [[SASignUpWithEmailView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, HEIGHT(self.scrollView)-KStatusHeight-KNavBarHeight)];
            }
                break;
            case 2:
            {
                // 根据自定义账号
                signUpView = [[SASignUpWithCustomView alloc] initWithFrame:CGRectMake(2*SCREEN_WIDTH, 0, SCREEN_WIDTH, HEIGHT(self.scrollView)-KStatusHeight-KNavBarHeight)];
            }
                break;
            default:
                break;
        }

        [self.scrollView addSubview:signUpView];
    }
}

#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x;
    self.segment.selectedSegmentIndex = (NSInteger)ceil(offset/SCREEN_WIDTH);
}

#pragma mark -
#pragma mark Notifications
- (void)addAllNotifications {
    // 手机注册
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneRegisterSuccess:) name:NOTI_SIGNUP_PHONE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneRegisterFailed:) name:NOTI_SIGNUP_PHONE_ERROR object:nil];

    // 邮箱注册

    // 自定义用户注册

    // 用户信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveUserDataSuccess:) name:NOTI_SIGNUP_USER object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveUserDataFailed:) name:NOTI_SIGNUP_USER_ERROR object:nil];

}

- (void)removeAllNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark SASignUpWithTelephoneViewDelegate
- (void)phoneRegisterBtnClicked:(SASignUpWithTelephoneView *)phoneView phone:(NSString *)phone{
//    // 测试
//    SASignUpUserInfoController *userInfoController = [[SASignUpUserInfoController alloc] init];
//    [self.navigationController pushViewController:userInfoController animated:YES];

    _username = phone;
    // 显示加载HUD
    [CLProgressHUD showInView:self.view delegate:self tag:44 title:@"正在注册..."];

    // 发送注册请求
    [self sendPhoneRegisterRequest:phone];

}

- (void)phoneRegisterSuccess:(NSNotification *)notification {
    if ([notification.userInfo[@"code"] intValue] == 200) {
        // 注册成功
        [CLProgressHUD dismissHUDByTag:44 delegate:self inView:self.view];

        _registerUserId = [[notification.userInfo valueForKeyPath:@"data.user_id"] intValue];
        [SAUserDataManager saveUserData:@{
                @"user" : @{
                        @"id" : @(_registerUserId),
                        @"username" : self.username
                }
        }];

        // 进入用户信息设置页面
        SASignUpUserInfoController *userInfoController = [[SASignUpUserInfoController alloc] init];
        [self.navigationController pushViewController:userInfoController animated:YES];
    } else {
        [CLProgressHUD dismissHUDByTag:44 delegate:self inView:self.view];
        [CLProgressHUD showErrorInView:self.view delegate:self title:@"注册失败!" duration:.4];
    }
}

- (void)phoneRegisterFailed:(NSNotification *)notification {
    [CLProgressHUD dismissHUDByTag:44 delegate:self inView:self.view];
    [CLProgressHUD showErrorInView:self.view delegate:self title:@"注册失败!" duration:.4];
}

- (void)sendPhoneRegisterRequest:(NSString *)phone {
    [SASignUpRequest registerWithPhone:phone];
}

- (void)receiveUserDataSuccess:(NSNotification *)notification{
    [MBProgressHUD hideHUDForView:self.view animated:YES];


}

- (void)receiveUserDataFailed:(NSNotification *)notification {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
