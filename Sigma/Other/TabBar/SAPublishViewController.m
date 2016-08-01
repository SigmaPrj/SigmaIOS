//
//  SAPublishViewController.m
//  Sigma
//
//  Created by Terence on 16/7/17.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAPublishViewController.h"
#import "SAPublishViewButton.h"
#import "POP.h"
#import "UIView+SAPublishBtnFrame.h"
#import "SARootViewController.h"
#import "SACollectionViewController.h"
#import "SADownloadViewController.h"
#import "SAComposeViewController.h"
#import "SAQuestionViewController.h"


@interface SAPublishViewController ()<SAPDelegate,SADownloadViewControllerDelegate,SAComposevcDelegate,SAQuestionvcDelegate>

@property(nonatomic, weak)UIImageView* imageView;

@end

static NSInteger SpringFactor = 2;
static CGFloat SpringDelay = 0.03;

@implementation SAPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.userInteractionEnabled = NO;
    
    
    // 初始化btn 图片和title
    NSArray *images = @[@"tabbar_compose_idea.png", @"tabbar_compose_book.png", @"btn_download_normal.png", @"tabbar_compose_lbs.png", @"messagescenter_good.png", @"tabbar_compose_friend.png"];
    NSArray *titles = @[@"发布", @"提问",@"下载", @"签到", @"收藏", @"返回"];
    
    NSUInteger cols = 3;
    CGFloat btnW = 60;
    CGFloat btnH = btnW + 50;
    CGFloat beginMargin = 40;
    CGFloat middleMargin = (SCREEN_WIDTH - 2 * beginMargin - cols *btnW)/(cols - 1);
    CGFloat btnStartY = (SCREEN_HEIGHT - 2 * btnH) * 0.5 + 30;
    
    for (int i = 0; i < images.count; i++) {
        
        SAPublishViewButton *btn = [SAPublishViewButton buttonWithType:UIButtonTypeCustom];
        
        // 算当前列数
        NSInteger col = i % cols;
        // 当前行数
        NSInteger row = i / cols;
        
            CGFloat btnX = col * (middleMargin + btnW) + beginMargin;
            CGFloat btnY = row * btnH + btnStartY;
            
            [self.view addSubview:btn];
            
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
             
            [btn addTarget:self action:@selector(chickBtnDown:) forControlEvents:UIControlEventTouchDown];
            
            [btn addTarget:self action:@selector(chickBtnUpInside:) forControlEvents:UIControlEventTouchUpInside];
            
            btn.tag = i;
            
            CGFloat benginBtnY = btnStartY + SCREEN_HEIGHT;
            
            /**
             *  添加动画
             *
             *  @return
             */
            
            POPSpringAnimation *anima = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
            
            anima.fromValue = [NSValue valueWithCGRect:CGRectMake(btnX, benginBtnY, btnW, btnH)];
            
            anima.toValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnY, btnW, btnH)];
            
            anima.springSpeed = SpringFactor;
            
            anima.springBounciness = SpringDelay;
            
            anima.beginTime = CACurrentMediaTime() + i * SpringDelay;
            
            [btn pop_addAnimation:anima forKey:nil];
            
            
            
            // 动画完成的回调
            [anima setCompletionBlock:^(POPAnimation *anima, BOOL finish) {
                
            }];
        
    }
    
    /** 添加sloganView指示条 */
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    
    sloganView.y = - SCREEN_WIDTH;
    
    [self.view addSubview:sloganView];
    
    CGFloat centerX = SCREEN_WIDTH * 0.5;
    
    CGFloat centerEndY = SCREEN_HEIGHT * 0.15;
    
    CGFloat centerBenginY = centerEndY - SCREEN_HEIGHT;
    
    /** 添加动画 */
    POPSpringAnimation *anima = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anima.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBenginY)];
    anima.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anima.springBounciness = SpringDelay;
    anima.beginTime = CACurrentMediaTime() + SpringDelay * images.count;
    
    anima.springSpeed = SpringFactor;
    
    [sloganView pop_addAnimation:anima forKey:nil];
    
    [anima setCompletionBlock:^(POPAnimation *anima, BOOL finish) {
        
        /** 动画完成后 */
        self.view.userInteractionEnabled = YES;
    }];
}



- (void)cancelWithCompletionBlock:(void (^)())block
{
    self.view.userInteractionEnabled = NO;
    
    
    int index = 0;
    for (int i = index; i < self.view.subviews.count; i++) {
        UIView *view = self.view.subviews[i];
        
        POPSpringAnimation *anima = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
        
        anima.springBounciness = SpringDelay;
        
        anima.springSpeed = SpringFactor;
        
        anima.beginTime = CACurrentMediaTime() + (i - index) * SpringDelay;
        
        CGFloat endCenterY = view.centerY + SCREEN_HEIGHT;
        
        anima.toValue = [NSValue valueWithCGPoint:CGPointMake(view.centerX, endCenterY)];
        
        [view pop_addAnimation:anima forKey:nil];
        
        
        
        if (i == self.view.subviews.count - 1) { // 最后一个动画完成时
            
            [anima setCompletionBlock:^(POPAnimation *anima, BOOL finish) {
            block();
                
            }];
        }
        

        
    }
}


/**
 *  这里是点击按钮放大的效果
 *
 *  @param btn <#btn description#>
 */
- (void)chickBtnDown:(UIButton *)btn
{
    POPBasicAnimation *anima = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    anima.toValue = [NSValue valueWithCGSize:CGSizeMake(1.0, 1.0)];
    
    [btn pop_addAnimation:anima forKey:nil];
    
}


- (void)chickBtnUpInside:(UIButton *)btn
{
    POPBasicAnimation *anima = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    
    anima.toValue = [NSValue valueWithCGSize:CGSizeMake(1.1, 1.1)];
    
    [btn pop_addAnimation:anima forKey:nil];
    
    __weak typeof(self) weakself = self;

        
        POPBasicAnimation *anima2 = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
        
        anima2.toValue = @(0);
        
        [btn pop_addAnimation:anima2 forKey:nil];
        
        [anima2 setCompletionBlock:^(POPAnimation *anima, BOOL finish) {
            
            
            [self cancelWithCompletionBlock:^{
                // 切换对应控制器
                if (btn.tag == 0) {
                    NSLog(@"go to 0");
                    SAComposeViewController* composevc = [[SAComposeViewController alloc] init];
                    
                    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:composevc];
                    [weakself presentViewController:nav animated:YES completion:nil];
                    composevc.delegate = self;
                    
                }else if (btn.tag == 1){
                    NSLog(@"go to 1");                    
//                    [weakself dismissViewControllerAnimated:NO completion:nil];

                    SAQuestionViewController* questionvc = [[SAQuestionViewController alloc] init];
                    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:questionvc];
                    [weakself presentViewController:nav animated:YES completion:nil];
                    questionvc.delegate = self;
                   
                    NSLog(@"aaa");
                }else if (btn.tag == 2){
                    SADownloadViewController *sadownVc = [[SADownloadViewController alloc] init];
                    [weakself presentViewController:sadownVc animated:YES completion:nil];
                    sadownVc.delegate = self;
                    
                }else if (btn.tag == 3){
                    [weakself dismissViewControllerAnimated:NO completion:nil];
                }else if (btn.tag == 4){
                    
                    // 跳转到收藏界面
                    SACollectionViewController *savc = [[SACollectionViewController alloc] init];
                    [weakself presentViewController:savc animated:YES completion:nil];
                    savc.myDelegate = self;
                    
                }else if (btn.tag == 5){
                    [weakself dismissViewControllerAnimated:NO completion:nil];
                }
                
                
            }];
            
            
            
        }];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

}

#pragma mark - SAPDelegate collectionviewController的代理，负责dismiss publishViewController
- (void) CollectionDismissViewController {
    [self dismissViewControllerAnimated:NO completion:nil];
}


#pragma mark - SADownloadViewControllerDelegate
-(void)DownloadDismissViewController{
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - SAComposevcDelegate
-(void)ComposeDismisssViewController{
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - SAQuestionvcDelegate
-(void)questionDismissViewController{
    [self dismissViewControllerAnimated:NO completion:nil];
}


@end
