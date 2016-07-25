//
//  SAPopularViewController.m
//  Sigmaprj
//
//  Created by Terence on 16/7/13.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAPopularViewController.h"
#import "SAPopularTableView.h"
#import "SAPublishViewController.h"
#import "testController.h"

@interface SAPopularViewController ()

@property(nonatomic, strong)SAPopularTableView *tableView;

@end

@implementation SAPopularViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *b = [[UIBarButtonItem alloc] initWithTitle:@"test" style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    self.navigationItem.rightBarButtonItem = b;
    

}

-(void)pop{
    NSLog(@"pop");
    
    
    testController* tvc = [[testController alloc] init];
    tvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tvc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


-(instancetype)init{
    self = [super init];
    
    if (self) {
        [self initUI];
    }
    
    return self;
}

-(void)initUI{
    [self.view addSubview:self.tableView];
   
}

-(SAPopularTableView*)tableView{
    if (!_tableView) {
        _tableView = [[SAPopularTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
//        _tableView.backgroundColor = [UIColor yellowColor];
        
    }
    
    return _tableView;
}




@end
