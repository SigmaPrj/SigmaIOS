//
//  SACollectionViewController.m
//  Sigma
//
//  Created by Terence on 16/7/19.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SACollectionViewController.h"

@implementation SACollectionViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationbar];
   
}

- (void)setNavigationbar
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, 55)];
    navigationBar.tintColor = [UIColor grayColor];    //创建UINavigationItem;
    UINavigationItem * navigationBarTitle = [[UINavigationItem alloc] initWithTitle:@"收藏"];
    [navigationBar pushNavigationItem: navigationBarTitle animated:YES];
    [self.view addSubview: navigationBar];
    //创建UIBarButton 可根据需要选择适合自己的样式
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(navigationBackButton:)];
    //设置barbutton
    navigationBarTitle.leftBarButtonItem = item;
    [navigationBar setItems:[NSArray arrayWithObject: navigationBarTitle]];
    
}

-(void)navigationBackButton:(id)sender{
    
    if (sender && [sender isKindOfClass:[UIBarButtonItem class]]) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

@end
