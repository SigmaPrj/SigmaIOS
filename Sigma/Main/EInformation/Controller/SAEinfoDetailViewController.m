//
//  SAEinfoDetailViewController.m
//  Sigma
//
//  Created by Terence on 16/7/26.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAEinfoDetailViewController.h"

@interface SAEinfoDetailViewController ()

@property(nonatomic, strong)UILabel* desc;

@end

@implementation SAEinfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLeftNavigationItemWithTitle:nil imageName:@"back.png"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.desc];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(UILabel*)desc{
    if (!_desc) {
        _desc = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 100, 200, 40)];
        _desc.backgroundColor = [UIColor yellowColor];
        
    }
    
    return _desc;
}

@end
