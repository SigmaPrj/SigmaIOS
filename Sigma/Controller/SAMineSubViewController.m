//
//  SAMineSubViewController.m
//  Sigma
//
//  Created by Ace Hsieh on 7/17/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import "SAMineSubViewController.h"

@interface SAMineSubViewController ()

@end

@implementation SAMineSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title=self.titleLabel;
    
    self.view.backgroundColor=[UIColor grayColor];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

@end
