//
//  SATabBarViewController.m
//  Sigmaprj
//
//  <该文件可被删除了，采用新的自定义tabbar>
//
//  Created by Terence on 16/7/13.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SATabBarViewController.h"
#import "SACommunityViewController.h"
#import "SAEInfomationViewController.h"
#import "SAViewController.h"
#import "SAMeViewController.h"
#import "SAPopularViewController.h"
#import "SANavigationController.h"
#import "SAViewController.h"


@interface SATabBarViewController ()


@end

@implementation SATabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initControllers];


}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


-(void)initControllers{
    // 热门tabbar
    SAPopularViewController *popularViewController = [[SAPopularViewController alloc] init];
    [self initTabbarWithViewController:popularViewController title:@"热门" image:@"discovery_normal.png" selectedImgName:@"discovery_selected.png"];

    SACommunityViewController *communityViewController = [[SACommunityViewController alloc] init];
    [self initTabbarWithViewController:communityViewController title:@"社区" image:@"discovery_normal.png" selectedImgName:@"discovery_selected.png"];

    SAEInfomationViewController *infomationViewController = [[SAEInfomationViewController alloc] init];
    [self initTabbarWithViewController:infomationViewController title:@"资讯" image:@"discovery_normal.png" selectedImgName:@"discovery_selected.png"];

    SAMeViewController *meViewController = [[SAMeViewController alloc] init];
    [self initTabbarWithViewController:meViewController title:@"我的" image:@"discovery_normal.png" selectedImgName:@"discovery_selected.png"];



}

/**
 *  初始化TabBar
 *
 *  @param viewController  viewController
 *  @param title           对应的title
 *  @param imageName       tabbar上的图片名
 *  @param selectedImgName 被选择之后的图片名
 */
-(void)initTabbarWithViewController:(SAViewController*)viewController
                              title:(NSString*)title
                              image:(NSString*)imageName
                    selectedImgName:(NSString*)selectedImgName{

    /**
     *  取消系统自带渲染
     */
    viewController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    /**
     * tabbar 按钮颜色
     */
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = SIGMA_COLOR;
    [viewController.tabBarItem setTitleTextAttributes:dic forState:UIControlStateSelected];
    dic[NSForegroundColorAttributeName] = SIGMA_COLOR;
    [viewController.tabBarItem setTitleTextAttributes:dic forState:UIControlStateNormal];
    viewController.title = title;


    SANavigationController* navi = [[SANavigationController alloc]initWithRootViewController:viewController];
    
    UIColor * color = [UIColor blackColor];
    //这里我们设置的是颜色，还可以设置shadow等，具体可以参见api
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    navi.navigationBar.titleTextAttributes = dict;
    
    [self addChildViewController:navi];

}



@end
