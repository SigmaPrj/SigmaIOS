//
//  ContentOfSourceViewController.m
//  Sigma
//
//  Created by 韩佳成 on 16/7/22.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "ContentOfSourceViewController.h"
#import "ContentOfSourceHeadView.h"
#import "SourceCommonDefine.h"
#import "SourceEngineInterface.h"


@interface ContentOfSourceViewController ()

//这个界面的headview
@property(nonatomic,strong)ContentOfSourceHeadView* headView;

@property(nonatomic,strong)UITableView* tableView;

//cell的数据
@property(nonatomic,strong)NSMutableArray* dataArray;

@end

@implementation ContentOfSourceViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)initUI{
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
    
}

//延时加载headview
-(ContentOfSourceHeadView*)headView{
    if(_headView == nil){
        _headView = [[ContentOfSourceHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CONTENTOFSOURCEHEAD_HE)];
        _headView.backgroundColor = [UIColor whiteColor];
    }
    return _headView;
}

//延时加载tableview
-(UITableView*)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style: UITableViewStylePlain];
        
        _tableView.backgroundColor = [UIColor clearColor];
        
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        
        //取消分割线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
//        _tableView.dataSource = self;
//        _tableView.delegate = self;
    }
    return _tableView;
}

//#pragma mark - UITableViewDataSource
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.dataArray.count;
//}
//
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString* cellIdentifier = @"mycell";
//    return nil;
//}
//
//#pragma mark - UITableViewDelegate

@end
