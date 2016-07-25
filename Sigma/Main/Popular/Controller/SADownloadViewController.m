//
//  SADownloadViewController.m
//  Sigma
//
//  Created by Terence on 16/7/22.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SADownloadViewController.h"

@implementation SADownloadViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.158  green:0.215  blue:0.386 alpha:1];
    [self setNavigationbar];
    
}

- (void)setNavigationbar
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, 55)];
    navigationBar.tintColor = [UIColor grayColor];    //创建UINavigationItem;
    UINavigationItem * navigationBarTitle = [[UINavigationItem alloc] initWithTitle:@"下载"];
    [navigationBar pushNavigationItem: navigationBarTitle animated:YES];
    [self.view addSubview: navigationBar];
    //创建UIBarButton 可根据需要选择适合自己的样式
    //    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"关闭" target:self action:@selector(navigationBackButton:)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(navigationBackButton:)];
    
    //设置barbutton
    navigationBarTitle.leftBarButtonItem = item;
    [navigationBar setItems:[NSArray arrayWithObject: navigationBarTitle]];
    
}

-(void)navigationBackButton:(id)sender{
    
    if (sender && [sender isKindOfClass:[UIBarButtonItem class]]) {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
        [_delegate DownloadDismissViewController];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


@end
