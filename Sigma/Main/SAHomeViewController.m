//
//  SAHomeViewController.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/1.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SAHomeViewController.h"
#import "SASignUpViewController.h"
#import "SASignInViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

#define LOGO_IMAGE_SIZE 173
#define BUTTON_PADDING 20
#define SCROLL_VIEW_PADDING_BOTTON 12
#define BUTTON_WIDTH ((SCREEN_WIDTH-3*BUTTON_PADDING)/2)
#define BUTTON_HEIGHT 50
#define BUTTON_RADIUS 5
#define BUTTON_SIGNUP_BG_COLOR [UIColor colorWithRed:0.16 green:0.15 blue:0.14 alpha:0.5]
#define BUTTON_SIGNUP_TITLE_COLOR [UIColor colorWithRed:0.44 green:0.42 blue:0.41 alpha:1.00]
#define BUTTON_SIGNIN_BG_COLOR [UIColor colorWithRed:0.44 green:0.42 blue:0.41 alpha:0.5]
#define BUTTON_SIGNIN_TITLE_COLOR [UIColor colorWithRed:0.16 green:0.15 blue:0.14 alpha:1.00]
#define LABEL_HEIGHT 60
#define PAGE_CONTROL_HEIGHT 13
#define PAGE_NUM 4
#define PAGE_CONTROL_ACTIVE_COLOR [UIColor colorWithRed:0.16 green:0.15 blue:0.14 alpha:1.00]
#define PAGE_CONTROL_COLOR [UIColor colorWithRed:0.44 green:0.42 blue:0.41 alpha:1.00]

@interface SAHomeViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, strong) UIView *alphaView;
@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *signUpBtn; //注册
@property (nonatomic, strong) UIButton *signInBtn; // 登录
@property (nonatomic, strong) AVAudioSession *avaudioSession;

@end

@implementation SAHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];

    [self startTimer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self.moviePlayer play];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.moviePlayer stop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {

    // 添加logo
    [self.alphaView addSubview:self.logoView];

    // 添加底部滚动视图
    [self.alphaView addSubview:self.scrollView];

    // 添加切换button
    [self.alphaView addSubview:self.pageControl];

    // 添加注册按钮
    [self.alphaView addSubview:self.signUpBtn];

    // 添加登录按钮
    [self.alphaView addSubview:self.signInBtn];

    [self.moviePlayer.view addSubview:self.alphaView];
    
    [self.view addSubview:_moviePlayer.view];
}

- (UIImageView *)logoView {
    if (!_logoView) {
        _logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
        _logoView.frame = CGRectMake((SCREEN_WIDTH-LOGO_IMAGE_SIZE)/2, 100, LOGO_IMAGE_SIZE, LOGO_IMAGE_SIZE);
    }
    return _logoView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT-BUTTON_PADDING-BUTTON_HEIGHT-SCROLL_VIEW_PADDING_BOTTON))];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;

        _scrollView.contentSize = CGSizeMake(4*SCREEN_WIDTH, (SCREEN_HEIGHT-BUTTON_PADDING-BUTTON_HEIGHT-SCROLL_VIEW_PADDING_BOTTON));
        _scrollView.contentOffset = CGPointMake(0, 0);

        _scrollView.pagingEnabled = YES;

        _scrollView.delegate = self;

        [self addLabelsToScrollView];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, (self.scrollView.contentSize.height-PAGE_CONTROL_HEIGHT), SCREEN_WIDTH, PAGE_CONTROL_HEIGHT)];
        _pageControl.numberOfPages = PAGE_NUM;
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = PAGE_CONTROL_ACTIVE_COLOR;
        _pageControl.pageIndicatorTintColor = PAGE_CONTROL_COLOR;
    }
    return _pageControl;
}

- (UIButton *)signUpBtn {
    if (!_signUpBtn) {
        _signUpBtn = [[UIButton alloc] initWithFrame:CGRectMake(BUTTON_PADDING, SCREEN_HEIGHT-BUTTON_PADDING-BUTTON_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT)];
        _signUpBtn.layer.cornerRadius = BUTTON_RADIUS;
        _signUpBtn.backgroundColor = BUTTON_SIGNUP_BG_COLOR;
        _signUpBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_signUpBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_signUpBtn setTitleColor:BUTTON_SIGNUP_TITLE_COLOR forState:UIControlStateNormal];
        // 添加按钮点击事件
        _signUpBtn.tag = 1;
        [_signUpBtn addTarget:self action:@selector(buttonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signUpBtn;
}

- (UIButton *)signInBtn {
    if (!_signInBtn){
        _signInBtn = [[UIButton alloc] initWithFrame:CGRectMake(2*BUTTON_PADDING+BUTTON_WIDTH, SCREEN_HEIGHT-BUTTON_PADDING-BUTTON_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT)];
        _signInBtn.layer.cornerRadius = BUTTON_RADIUS;
        _signInBtn.backgroundColor = BUTTON_SIGNIN_BG_COLOR;
        _signInBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_signInBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_signInBtn setTitleColor:BUTTON_SIGNIN_TITLE_COLOR forState:UIControlStateNormal];
        // 添加按钮点击事件
        _signInBtn.tag = 2;
        [_signInBtn addTarget:self action:@selector(buttonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signInBtn;
}

- (UIView *)alphaView {
    if (!_alphaView) {
        _alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _alphaView.backgroundColor = [UIColor clearColor];
    }
    return _alphaView;
}

- (AVAudioSession *)avaudioSession {
    if (!_avaudioSession) {
        _avaudioSession = [AVAudioSession sharedInstance];
        NSError *error = nil;
        [_avaudioSession setCategory:AVAudioSessionCategoryAmbient error:&error];
    }
    return _avaudioSession;
}

- (MPMoviePlayerController *)moviePlayer {
    if (!_moviePlayer) {
        // 播放音频
        NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"bg.mp4" ofType:nil];
        
        NSURL *url = [NSURL fileURLWithPath:urlStr];
        
        _moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:url];
        //    _moviePlayer.controlStyle = MPMovieControlStyleDefault;
        [_moviePlayer play];
        [_moviePlayer.view setFrame:self.view.bounds];
        _moviePlayer.shouldAutoplay = YES;
        [_moviePlayer setControlStyle:MPMovieControlStyleNone];
        [_moviePlayer setFullscreen:YES];
        
        [_moviePlayer setRepeatMode:MPMovieRepeatModeOne];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playbackStateChanged)
                                                     name:MPMoviePlayerPlaybackStateDidChangeNotification
                                                   object:_moviePlayer];
    }
    return _moviePlayer;
}

- (void)addLabelsToScrollView {
    NSArray *labelsTitle = @[
            @"找不到队友? 加入我们",
            @"想学习知识? 加入我们",
            @"不知道比赛信息? 加入我们",
            @"有问题寻求解答? 加入我们"
    ];

    for (int i = 0; i < PAGE_NUM; ++i) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH, (self.scrollView.contentSize.height-LABEL_HEIGHT), SCREEN_WIDTH, LABEL_HEIGHT)];
        label.text = labelsTitle[(NSUInteger)i];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:22];
        [self.scrollView addSubview:label];
    }
}

-(void)playbackStateChanged{
    //取得目前状态
    MPMoviePlaybackState playbackState = [_moviePlayer playbackState];

    //状态类型
    switch (playbackState) {
        case MPMoviePlaybackStateStopped:
            [_moviePlayer play];
            break;

        case MPMoviePlaybackStatePlaying:
            NSLog(@"播放中");
            break;

        case MPMoviePlaybackStatePaused:
            [_moviePlayer play];
            break;

        case MPMoviePlaybackStateInterrupted:
            NSLog(@"播放被中断");
            break;

        case MPMoviePlaybackStateSeekingForward:
            NSLog(@"往前快转");
            break;

        case MPMoviePlaybackStateSeekingBackward:
            NSLog(@"往后快转");
            break;

        default:
            NSLog(@"无法辨识的状态");
            break;
    }
}


-(void)buttonClickHandler:(UIButton *)btn {
    switch (btn.tag) {
        case 1:
        {
            // 注册按钮
            SASignUpViewController *telephoneViewController = [[SASignUpViewController alloc] init];
            [self.navigationController pushViewController:telephoneViewController animated:YES];
        }
            break;
        case 2:
        {
            // 登录按钮
            SASignInViewController *signInViewController = [[SASignInViewController alloc] init];
            [self.navigationController pushViewController:signInViewController animated:YES];
        }
            break;
        default:
            break;
    }
}

//ios以后隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark -
#pragma mark timer
- (void) startTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(pageChangeHandler) userInfo:nil repeats:YES];
    NSRunLoop *mainRunLoop = [NSRunLoop mainRunLoop];
    [mainRunLoop addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    [_timer invalidate];
}

- (void)pageChangeHandler {
    int index = (int)ceil(self.scrollView.contentOffset.x/SCREEN_WIDTH);
    if (index >= (PAGE_NUM-1)) {
        index = 0;
    } else {
        index++;
    }
    self.pageControl.currentPage = index;
    [self.scrollView setContentOffset:CGPointMake(index*SCREEN_WIDTH, 0) animated:YES];
}

#pragma mark -
#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int index = (int)ceil(scrollView.contentOffset.x/SCREEN_WIDTH);
    self.pageControl.currentPage = index;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self startTimer];
}


@end
