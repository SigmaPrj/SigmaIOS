//
//  VideoOfCourseController.m
//  Sigma
//
//  Created by 韩佳成 on 16/8/5.
//  Copyright © 2016年 韩佳成. All rights reserved.
//

#import "VideoOfCourseController.h"
#import "CourseFirstViewController.h"
#import "CourseSecondViewController.h"
#import "CourseEngine.h"
#import "VideoInfo.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "XCAVPlayerView.h"
#import <MediaPlayer/MediaPlayer.h>

@interface VideoOfCourseController ()<UIScrollViewDelegate>

////视频放置的view
//@property(nonatomic,strong)MPMoviePlayerController* moviePlayer;

//视频播放的url地址(网络)
@property(nonatomic,copy)NSString* movieUrlPath;

//选择分类的滑动控制器
@property(nonatomic,strong)UIScrollView* scrollView;

//简介界面的控制器
@property(nonatomic,strong)CourseFirstViewController* firstViewController;

//评论界面的控制器
@property(nonatomic,strong)CourseSecondViewController* secondViewController;

//scrollview的标签
@property(nonatomic,strong)UISegmentedControl* segmentedControl;

@property(nonatomic,strong)UITableView* tableView;

@property(nonatomic,strong)NSMutableArray* dataArray;

@property(nonatomic,strong)VideoInfo* videoInfo;

@property (nonatomic, strong) XCAVPlayerView *playerView;

@end

@implementation VideoOfCourseController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(statuesBarChanged:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    self.playerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 370*(SCREEN_WIDTH/SCREEN_HEIGHT));
//     NSURL *videoURL = [[NSBundle mainBundle] URLForResource:@"150511_JiveBike" withExtension:@"mov"];
    self.playerView.playerUrl = [NSURL URLWithString:self.movieUrlPath];
//    self.playerView.playerUrl = videoURL;
//    [self.playerView play];
    [self.playerView resume];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.playerView pause];
//    [[self.playerView getPlayerItem] cancelPendingSeeks];
//    [[self.playerView getPlayerItem].asset cancelLoading];
//    [self.playerView removeDataSource];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
}

-(void)dealloc{
    [self.playerView removeDataSource];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)initUI{
    self.dataArray = [[[CourseEngine shareInstances] videoInfoWithData] mutableCopy];
    VideoInfo* videoInfo = (VideoInfo*)[self.dataArray objectAtIndex:0];
    self.videoInfo = videoInfo;
    self.movieUrlPath = self.videoInfo.courseVideoUrlPath;
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2, SCREEN_HEIGHT);
    [self.scrollView addSubview:self.firstViewController];
    [self.scrollView addSubview:self.secondViewController];
    [self.tableView addSubview:self.segmentedControl];
    
//    [self.view addSubview:self.moviePlayer];
//    [self.view addSubview:self.scrollView];
//    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2, SCREEN_HEIGHT);
//    [self.scrollView addSubview:self.firstViewController];
//    [self.scrollView addSubview:self.secondViewController];
//    [self.view addSubview:self.segmentedControl];
}

- (XCAVPlayerView *)playerView{
    if (!_playerView) {
        _playerView = [[XCAVPlayerView alloc]init];
        [self.tableView addSubview:_playerView];
    }
    return _playerView;
}

- (void)statuesBarChanged:(NSNotification *)sender{
    UIInterfaceOrientation statues = [UIApplication sharedApplication].statusBarOrientation;
    if (statues == UIInterfaceOrientationPortrait || statues == UIInterfaceOrientationPortraitUpsideDown) {
        self.playerView.frame = CGRectMake(0, 20.0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 0.58);
    }else if (statues == UIInterfaceOrientationLandscapeLeft || statues == UIInterfaceOrientationLandscapeRight){
        self.playerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    NSLog(@"%@--%@",object,[change description]);
}

- (void)moviePlayDidEnd:(NSNotification *)noti{
    
}

////延时加载视频控制器
//-(MPMoviePlayerController*)moviePlayer{
//    if(_moviePlayer){
//        NSURL* url = [NSURL URLWithString:self.movieUrlPath];
//        _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
//        _moviePlayer.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200*(SCREEN_WIDTH/SCREEN_HEIGHT));
//        _moviePlayer.view.backgroundColor = [UIColor blueColor];
//        [self.view addSubview:_moviePlayer.view];
//    }
//    return _moviePlayer;
//}

//延时加载scrollView
-(UIScrollView*)scrollView{
    if(_scrollView == nil){
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 400*(SCREEN_WIDTH/SCREEN_HEIGHT), SCREEN_WIDTH, SCREEN_HEIGHT)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentOffset = CGPointZero;
        _scrollView.scrollEnabled = YES;
        _scrollView.bounces = YES;
        
        _scrollView.delegate = self;

    }
    return _scrollView;
}

//延时加载简介界面的控制器
-(CourseFirstViewController*)firstViewController{
    if(_firstViewController == nil){
        _firstViewController = [[CourseFirstViewController alloc] initWithFrame:CGRectMake(0, 50*(SCREEN_WIDTH/SCREEN_HEIGHT), SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _firstViewController;
}

//延时加载评论界面的控制器
-(CourseSecondViewController*)secondViewController{
    if(_secondViewController == nil){
        _secondViewController = [[CourseSecondViewController alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 50*(SCREEN_WIDTH/SCREEN_HEIGHT), SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _secondViewController;
}

//延时加载scrollview的标签
-(UISegmentedControl*)segmentedControl{
    if(_segmentedControl == nil){
        NSArray* segmentedArray = [[NSArray alloc] initWithObjects:@"1",@"2", nil];
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
        _segmentedControl.frame = CGRectMake((SCREEN_WIDTH-300*(SCREEN_WIDTH/SCREEN_HEIGHT))/2, 400*(SCREEN_WIDTH/SCREEN_HEIGHT), 300*(SCREEN_WIDTH/SCREEN_HEIGHT), 50*(SCREEN_WIDTH/SCREEN_HEIGHT));
        [_segmentedControl setTitle:@"简介" forSegmentAtIndex:0];
        [_segmentedControl setTitle:@"作者信息" forSegmentAtIndex:1];
        _segmentedControl.tintColor = [UIColor colorWithRed:0.158  green:0.215  blue:0.386 alpha:1];
        _segmentedControl.selectedSegmentIndex = 0;//默认选中的按钮索引
        [_segmentedControl addTarget:self action:@selector(segmentSelect:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}

//实现segmentControl的事件
-(void)segmentSelect:(id)sender{
    if(sender && [sender isKindOfClass:[UISegmentedControl class]]){
        UISegmentedControl* seg = (UISegmentedControl*)sender;
        NSInteger index = seg.selectedSegmentIndex;
        CGRect frame = _scrollView.frame;
        frame.origin.x = index*CGRectGetWidth(_scrollView.frame);
        frame.origin.y = 0;
        [_scrollView scrollRectToVisible:frame animated:YES];
    }
}

//延时加载tableview
-(UITableView*)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offSetX = scrollView.contentOffset.x;
    NSInteger ratio = round(offSetX/SCREEN_WIDTH);
    _segmentedControl.selectedSegmentIndex = ratio;
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
