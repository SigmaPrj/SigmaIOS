//
//  SATeamViewController.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/4.
//  Copyright (c) 2016 sigma. All rights reserved.
//

//#import <XMNChat/XMNChat.h>
#import "SATeamViewController.h"
#import "UIView+HRExtention.h"
#import "SATeamMessageView.h"
#import "SATeamFriendView.h"
#import "SATeamTeamView.h"
#import "SAMessageModel.h"
#import "ChatCollectionViewController.h"
//#import "SAChatView.h"

#define KStatusHeight 20
#define KNavBarHeight 44
#define ICON_BTN_SIZE 30

@interface SATeamViewController () <SATeamMessageViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

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
                teamView = [[SATeamMessageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT(self.scrollView)-KNavBarHeight)];
                ((SATeamMessageView *)teamView).ownDelegate = self;
            }
                break;
            case 1:
            {
                teamView = [[SATeamFriendView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, HEIGHT(self.scrollView)-KNavBarHeight)];
            }
                break;
            case 2:
            {
                teamView = [[SATeamTeamView alloc] initWithFrame:CGRectMake(2*SCREEN_WIDTH, 0, SCREEN_WIDTH, HEIGHT(self.scrollView)-KNavBarHeight)];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
