//
//  SAEInfomationViewController.m
//  Sigmaprj
//
//  Created by Terence on 16/7/13.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAEInfomationViewController.h"
#import "SAEInformationTableView.h"
#import "EInformationTopBarView.h"

@interface SAEInfomationViewController () <EInformationTopBarViewDelegate>

@property (nonatomic, strong)SAEInformationTableView* tableView;
@property (nonatomic, strong)EInformationTopBarView* topbarview;
@property (nonatomic, strong) NSArray *categories;

@end

@implementation SAEInfomationViewController

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
        self.view.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    
    return self;
}

-(void)initUI{
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.topbarview];
}

- (NSArray *)categories {
    if (!_categories) {
        _categories = @[@"创新创业", @"商业营销", @"软件开发", @"英语演讲", @"竞技游戏", @"数学建模"];
    }
    
    return _categories;
}

-(SAEInformationTableView*)tableView{
    if (!_tableView) {
        _tableView = [[SAEInformationTableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, (SCREEN_HEIGHT-50)) style:UITableViewStylePlain];
//        _tableView.backgroundColor = [UIColor yellowColor];
    }
    
    return _tableView;
}

-(EInformationTopBarView*)topbarview{
    if (!_topbarview) {
        
        _topbarview = [[EInformationTopBarView alloc] initWithFrame:CGRectMake(0, 63, SCREEN_WIDTH, 42) categoreis:self.categories];
        _topbarview.backgroundColor = [UIColor whiteColor];
        _topbarview.delegate = self;
    }
    
    return _topbarview;
}


#pragma mark - EInformationTopBarViewDelegate
-(void)btnClickedWithTag:(int)tag{
    NSLog(@"%d",tag);
}


@end
