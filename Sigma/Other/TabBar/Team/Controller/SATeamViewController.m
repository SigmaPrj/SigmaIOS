//
//  SATeamViewController.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/4.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SATeamViewController.h"

@interface SATeamViewController ()

@end

@implementation SATeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
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
