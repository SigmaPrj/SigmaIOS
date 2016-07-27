//
//  SAPopularViewController.m
//  Sigmaprj
//
//  Created by Terence on 16/7/13.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAPopularViewController.h"
#import "SAPopularTableView.h"
#import "SAPopularHeaderView.h"
#import "SourceSubViewController.h"
//#import "SourceSubViewController.h"

#define HEADERVIEW_HEIGHT (280)

@interface SAPopularViewController ()<SAPopularHeaderViewDelegate>

@property(nonatomic, strong)SAPopularTableView *tableView;
@property (nonatomic, strong) SAPopularHeaderView* headerView;

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
        
        _tableView.tableHeaderView = self.headerView;
        
    }
    
    return _tableView;
}

-(SAPopularHeaderView*)headerView{
    if (!_headerView) {
        _headerView = [[SAPopularHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEADERVIEW_HEIGHT)];
                _headerView.delegate = self;
        
        //        _headerView.backgroundColor = [UIColor redColor];
        
    }
    
    return _headerView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - SAPopularHeaderViewDelegate
-(void)sourceButtonInHeadViewClicked{
    self.hidesBottomBarWhenPushed = YES;
    SourceSubViewController* sourceSubViewController = [[SourceSubViewController alloc] init];
    [self.navigationController pushViewController:sourceSubViewController animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

@end
