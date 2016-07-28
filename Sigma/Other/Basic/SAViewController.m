//
//  SAViewController.m
//  Sigma
//
//  Created by Terence on 16/7/13.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAViewController.h"

@interface SAViewController ()

@end

@implementation SAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

/**
 *  初始化公共操作
 */
-(instancetype)init{
    self = [super init];
    if (self){
        // 设置背景颜色和大小
        self.view.backgroundColor = COLOR_RGB(245, 245, 245);
        self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }

    return self;
}

/**
 * 添加搜索按钮
 */
-(void)addSearchBarButton {

}
@end
