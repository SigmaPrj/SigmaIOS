//
//  SARootViewController.m
//  Sigma
//
//  Created by Terence on 16/7/13.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SARootViewController.h"
#import "SACustomTabBar.h"
#import "SACommunityViewController.h"
#import "SAEInfomationViewController.h"
#import "SAViewController.h"
#import "SAMeViewController.h"
#import "SAPopularViewController.h"
#import "SANavigationController.h"
#import "SAViewController.h"


@interface SARootViewController ()

@end

@implementation SARootViewController


/**
 *  页面初始加载
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    SACustomTabBar* tabBar = [[SACustomTabBar alloc] initWithFrame:self.tabBar.frame];
    [self setValue:tabBar forKey:@"tabBar"];
    
    
    // pluson的点击事件
    tabBar.clickBlock = ^(){
        NSLog(@"plus btn clicked");
    };
    
    // 标题
    NSArray* titles = @[@"热门", @"社区", @"资讯", @"我的"];
    
    /**
     *  类名
     */
    NSArray* classNames = @[@"SAPopularViewController", @"SACommunityViewController", @"SAEInfomationViewController", @"SAMeViewController"];
    NSArray* images = @[@"tabbar_home",@"toolbar_compose",@"tabbar_discover",@"tabbar_profile"];
    
    NSMutableArray* mutableArray = [NSMutableArray array];
    
    for (int index = 0; index < classNames.count; index++) {
        NSString* selectedImg = [NSString stringWithFormat:@"%@_selected", [images objectAtIndex:index]];
        id nav = [self viewControllerWithClassName:[classNames objectAtIndex:index] image:[self changeImage:images[index]] selectedImage:[self changeImage:selectedImg] title:[titles objectAtIndex:index]];
        
        [mutableArray addObject:nav];
    }
    
    self.viewControllers = mutableArray;
//    self.tabBar.tintColor = [UIColor colorWithRed:1  green:0.510  blue:0 alpha:1];
    self.tabBar.tintColor = SIGMA_COLOR;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  初始化NavigationController
 *
 *  @param className     类名
 *  @param image         Tabbar图片名
 *  @param selectedImage Tabbar被点击的图片名
 *  @param title         Navigationbar上的标题
 *
 *  @return NaviviewController
 */
-(UINavigationController*)viewControllerWithClassName:(NSString*)className image:(UIImage*)image selectedImage:(UIImage*)selectedImage title:(NSString*)title{
    Class class = NSClassFromString(className);
    id pClass = [[class alloc] init];
    [pClass setTabBarItem: [[UITabBarItem alloc] initWithTitle: title image:image selectedImage:selectedImage]];
    [pClass setTitle: title];
    UINavigationController *NaviviewController = [[UINavigationController alloc] initWithRootViewController: pClass];
    return NaviviewController;
}


/**
 *
 *
 *  @param image 图片名
 *
 *  @return 返回图片
 */
-(UIImage*)changeImage:(NSString*)image{
    return [UIImage imageNamed:[NSString stringWithFormat:@"%@", image]];
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
