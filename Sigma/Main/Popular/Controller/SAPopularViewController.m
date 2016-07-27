//
//  SAPopularViewController.m
//  Sigmaprj
//
//  Created by Terence on 16/7/13.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAPopularViewController.h"
#import "SAPopularTableView.h"
<<<<<<< HEAD
=======
//#import "SourceSubViewController.h"
>>>>>>> d787fbe2857bff1496d4f47df3a1564cffaaa46d

@interface SAPopularViewController ()

@property(nonatomic, strong)SAPopularTableView *tableView;

@end

@implementation SAPopularViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

<<<<<<< HEAD
=======

>>>>>>> d787fbe2857bff1496d4f47df3a1564cffaaa46d
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
