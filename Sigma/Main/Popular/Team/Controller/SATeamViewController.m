//
//  SATeamViewController.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/4.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SATeamViewController.h"
#import "UIView+HRExtention.h"
#import "SATeamMessageView.h"
#import "SATeamFriendView.h"
#import "SATeamTeamView.h"
#import "SAUserDataManager.h"
#import "UIImageView+WebCache.h"

#define KStatusHeight 20
#define KNavBarHeight 44
#define ICON_BTN_SIZE 30

@interface SATeamViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *iconBtn;

@end

@implementation SATeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = NO;

    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.scrollView];

    [self.navigationController.navigationBar setTintColor:SIGMA_FONT_COLOR];

    // 设置title
    [self setupTitle];
    // 设置头像
    [self settingIconImage];
}

- (void)settingIconImage{
    self.navigationItem.hidesBackButton = YES;
    [self.navigationController.navigationBar addSubview:self.iconBtn];
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

- (UIButton *)iconBtn {
    if (!_iconBtn) {
        _iconBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, (40-ICON_BTN_SIZE)/2, ICON_BTN_SIZE, ICON_BTN_SIZE)];
        _iconBtn.backgroundColor = SIGMA_BG_COLOR;
        _iconBtn.layer.cornerRadius = ICON_BTN_SIZE/2;
        _iconBtn.clipsToBounds = YES;

        NSDictionary *userDic = [SAUserDataManager readUser];
        NSString *imageUrl = userDic[@"image"];
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        [_iconBtn setBackgroundImage:imageView.image forState:UIControlStateNormal];

        [_iconBtn addTarget:self action:@selector(iconBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _iconBtn;
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

- (void)iconBtnClicked:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
    [self.iconBtn removeFromSuperview];
}

- (void)addViewsToScrollView {
    for (int i = 0; i <3; ++i) {
        UIView *teamView;
        switch (i) {
            case 0:
            {
                teamView = [[SATeamMessageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT(self.scrollView)-KNavBarHeight)];
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
