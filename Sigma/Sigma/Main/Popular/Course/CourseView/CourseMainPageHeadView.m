//
//  CourseMainPageHeadView.m
//  Sigma
//
//  Created by 韩佳成 on 16/7/27.
//  Copyright © 2016年 Terence. All rights reserved.
//
#import "CourseMainPageHeadView.h"
#import "CourseCommonDefine.h"
#import "CourseEngine.h"
#import "ScrollViewImageInfo.h"


@interface CourseMainPageHeadView () <UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView* scrollView;

//scrollview图片的数组
@property(nonatomic,strong)NSMutableArray* scrollViewImageArray;

@property (nonatomic, weak) NSTimer *timer;

//scrollview当前的页面
@property(nonatomic,assign)int currentPage;

@end

@implementation CourseMainPageHeadView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.scrollView];
    
    self.scrollViewImageArray = [[[CourseEngine shareInstances] scrollViewWithData] mutableCopy];
    
    [self scrollWithImage];
}

//延时加载scollview
-(UIScrollView*)scrollView{
    if(_scrollView == nil){
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCROLL_HEIGHT)];
        
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        _scrollView.pagingEnabled = YES;
        _scrollView.contentOffset = CGPointZero;
        
        _scrollView.scrollEnabled = YES;
        _scrollView.bounces = YES;
        
        _scrollView.delegate =self;
        
        
    }
    return _scrollView;
}

-(void)scrollWithImage{
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*(self.scrollViewImageArray.count), SCROLL_HEIGHT);
    
    
    for(int index=0; index<self.scrollViewImageArray.count ; index++){
        ScrollViewImageInfo* scrollViewImageInfo = [[ScrollViewImageInfo alloc] init];
        scrollViewImageInfo = [self.scrollViewImageArray objectAtIndex:index];
        NSString* imageName = scrollViewImageInfo.imageName;
        
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(index*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCROLL_HEIGHT)];
        imageView.image = [UIImage imageNamed:imageName];
        [self.scrollView addSubview:imageView];
    }
}


#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat pageWidth = scrollView.frame.size.width;
    self.currentPage = (int)(floor((scrollView.contentOffset.x - pageWidth/2))/pageWidth+1);
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}


#pragma mark -
#pragma mark 定时器操作
- (void)startTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(changeScrollViewIndex) userInfo:nil repeats:YES];
}

- (void)stopTimer
{
    [_timer invalidate];
    _timer = nil;
}

- (void)changeScrollViewIndex {
    int index = self.currentPage;
    if ((index+1) >= self.scrollViewImageArray.count) {
        [UIView animateWithDuration:0.4 delay:0.0 options:(UIViewAnimationOptions) UIViewAnimationCurveEaseInOut animations:^{
            self.scrollView.contentOffset = CGPointMake(0, 0);
        }                completion:^(BOOL flag) {
        }];
        //        self.pageControl.currentPage = 0;
    } else {
        [UIView animateWithDuration:0.4 delay:0.0 options:(UIViewAnimationOptions) UIViewAnimationCurveEaseInOut animations:^{
            self.scrollView.contentOffset = CGPointMake((index+1)*SCREEN_WIDTH, 0);
        } completion:^(BOOL flag) {}];
    }
}


@end
