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
#import "MJRefresh.h"

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

-(void)loadNewData{
    
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
//    NSLog(@"%d",tag);
    if (tag == 1000) {
        NSDictionary* dict1 = @{
                                @"desc":@"第八届全国大学生数学竞赛111",
                                @"mainImgName":@"competition1.png",
                                @"number":@"198"
                                };
                                
                                
        NSDictionary* dict2 = @{
                                @"desc":@"2016携程云海大数据算法竞赛",
                                @"mainImgName":@"competition2.png",
                                @"number":@"2000"
                                };
                                
        NSDictionary* dict3 = @{
                                @"desc":@"全国大学生数学建模竞赛",
                                @"mainImgName":@"competition3.png",
                                @"number":@"10000"
                                };
                                
        NSDictionary* dict4 = @{
                                @"desc":@"\"华为杯\"东南大学第12届大学生程序设计大赛",
                                @"mainImgName":@"competition6.png",
                                @"number":@"100"
                                };
                                    
                                    
        NSDictionary* dict5 = @{
                                @"desc":@"2016年第12届百度之星编程大赛",
                                @"mainImgName":@"competition5.png",
                                @"number":@"2000"
                                };
                                    
        NSDictionary* dict6 = @{
                                @"desc":@"2016年第五届软件杯设计大赛选拔赛",
                                @"mainImgName":@"competition4.png",
                                @"number":@"2000"
                                };
                                
//                                    
        NSArray* dictArray = @[dict1, dict2, dict3, dict4, dict5, dict6];
        
        
        
        [self.tableView initData:dictArray];
        
    }else if (tag == 1001) {
        NSDictionary* dict1 = @{
                                @"desc":@"营销比赛1",
                                @"mainImgName":@"competition2.png",
                                @"number":@"211"
                                };
        
        
        NSDictionary* dict2 = @{
                                @"desc":@"营销2",
                                @"mainImgName":@"competition1.png",
                                @"number":@"123"
                                };
        
        NSDictionary* dict3 = @{
                                @"desc":@"营销3",
                                @"mainImgName":@"competition4.png",
                                @"number":@"1120"
                                };
        
        NSDictionary* dict4 = @{
                                @"desc":@"营销4",
                                @"mainImgName":@"competition3.png",
                                @"number":@"100"
                                };
        
//        
//        
        NSArray* dictArray = @[dict1, dict2, dict3, dict4];

        
        [self.tableView initData:dictArray];
//        [self.tableView reloadData];
      
        
    }else if (tag == 1002){
        NSDictionary* dict1 = @{
                                @"desc":@"软件1",
                                @"mainImgName":@"competition2.png",
                                @"number":@"211"
                                };
        
        
        NSDictionary* dict2 = @{
                                @"desc":@"软件2",
                                @"mainImgName":@"competition1.png",
                                @"number":@"123"
                                };
        
        NSDictionary* dict3 = @{
                                @"desc":@"软件3",
                                @"mainImgName":@"competition4.png",
                                @"number":@"1120"
                                };
        
        NSDictionary* dict4 = @{
                                @"desc":@"软件4",
                                @"mainImgName":@"competition3.png",
                                @"number":@"100"
                                };
        
        //
        //
        NSArray* dictArray = @[dict1, dict2, dict3, dict4];
        [self.tableView initData:dictArray];
    }
    
    [self.tableView reloadData];
}


@end
