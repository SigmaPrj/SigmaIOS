//
//  SATabBarViewController.m
//  Sigmaprj
//
//  Created by Terence on 16/7/13.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SATabBarViewController.h"

@interface SATabBarViewController ()

@end

@implementation SATabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}


/**
 *  初始化TabBar
 *
 *  @param viewController  viewController
 *  @param title           对应的title
 *  @param imageName       tabbar上的图片名
 *  @param selectedImgName 被选择之后的图片名
 */
-(void)initTabbarWithViewController:(UIViewController*)viewController
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

    SANavigationController *navi = [[SANavigationController alloc] initWithRootViewController:viewController];

    viewController.title = title;
}

@end
