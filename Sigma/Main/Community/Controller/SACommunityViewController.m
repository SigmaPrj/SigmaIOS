//
//  SACommunityViewController.m
//  Sigmaprj
//
//  Created by Terence on 16/7/13.
//  Copyright © 2016年 Sigma. All rights reserved.
//  @author : blackcater
//

#import "SACommunityViewController.h"
#import "SACommunityTableView.h"

#define COMMUNITY_TOP 64
#define COMMUNITY_BOTTOM 44

@interface SACommunityViewController ()

@property (nonatomic, strong) SACommunityTableView *tableView;

@end

@implementation SACommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self render];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self render];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)render {

    [self.view addSubview:self.tableView];
}

// 惰性加载
- (SACommunityTableView *)tableView {
    if (!_tableView) {
        _tableView = [[SACommunityTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT-COMMUNITY_BOTTOM)) style:UITableViewStylePlain];
    }
    return _tableView;
}

@end
