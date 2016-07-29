//
//  SARootViewController.m
//  根控制器负责 tabbr和navigation
//  Sigma
//
//  Created by Terence on 16/7/13.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SARootViewController.h"
#import "SACustomTabBar.h"
#import "SANavigationController.h"
#import "SAViewController.h"
#import "SAPublishViewController.h"
#import "SACollectionViewController.h"

@interface SARootViewController ()

@end

@implementation SARootViewController


/**
 *  页面初始加载
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    SACustomTabBar* tabBar = [[SACustomTabBar alloc] initWithFrame:self.tabBar.bounds];
    
    [self setValue:tabBar forKey:@"tabBar"];
    
//    [self.tabBar addSubview:tabBar];
    
    __weak typeof(self) weakself = self;
    
    // pluson的点击事件
    tabBar.clickBlock = ^(){
        NSLog(@"plus btn clicked");
        SAPublishViewController* saPublishViewController = [[SAPublishViewController alloc] init];
        
        [weakself presentViewController:saPublishViewController animated:NO completion:nil];
        

    };
    
    // 标题
    NSArray* titles = @[@"热门", @"动态", @"资讯", @"我的"];
    
    // tabbar 上四个对应的viewController的类名
    NSArray* classNames = @[@"SAPopularViewController", @"SACommunityViewController", @"SAEInfomationViewController", @"SAMeViewController"];
    
    //
    NSArray* images = @[@"square",@"circle",@"triangle",@"dimond"];
    
    NSMutableArray* mutableArray = [NSMutableArray array];
    
    // 初始化navigation导航栏
    for (int index = 0; index < classNames.count; index++) {
        NSString* selectedImg = [NSString stringWithFormat:@"%@_selected", images[(NSUInteger) index]];
        id nav = [self viewControllerWithClassName:classNames[(NSUInteger) index] image:[self changeImage:images[(NSUInteger) index]] selectedImage:[self changeImage:selectedImg] title:titles[(NSUInteger) index]];
        
        [mutableArray addObject:nav];
    }
    
    self.viewControllers = mutableArray;
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
    
    UINavigationController *NaviviewController = [[SANavigationController alloc] initWithRootViewController: pClass];
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
