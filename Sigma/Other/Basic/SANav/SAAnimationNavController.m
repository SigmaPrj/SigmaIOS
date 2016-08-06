//
//  SAAnimationNavController.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/1.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SAAnimationNavController.h"
#import "SANavAnimation.h"

@interface SAAnimationNavController () <UINavigationControllerDelegate>

@property (nonatomic, strong) UIButton* centerButton;

@end

@implementation SAAnimationNavController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationBar.tintColor = [UIColor colorWithRed:0.16 green:0.15 blue:0.14 alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
-(void)pushViewController:(UIViewController *)viewController withCenterButton:(UIButton *)button{
    self.centerButton = button;
    self.delegate = self;

    [super pushViewController:viewController animated:YES];
}
#pragma mark UINavigationControllerDelegate
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    SANavAnimation* animation = [SANavAnimation new];
    animation.centerButton = self.centerButton;
    return animation;
}

@end
