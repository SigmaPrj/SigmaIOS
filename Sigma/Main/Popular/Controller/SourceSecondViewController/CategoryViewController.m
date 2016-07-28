//
//  CategoryViewController.m
//  Sigma
//
//  Created by 韩佳成 on 16/7/19.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryHeadView.h"
#import "SourceCommonDefine.h"
#import "CategoryViewCell.h"
#import "SourceEngineInterface.h"
#import "CategoryInfo.h"
#import "SearchViewOfCategoryController.h"

@interface CategoryViewController()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView* tableView;

@property(nonatomic,strong)CategoryHeadView* categoryHeadView;

@property(nonatomic,strong)NSMutableArray* dataArray;

@end

@implementation CategoryViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initUI{
    self.title = @"分类";
    [self createRightButtonOfSearch];
    [self.view addSubview:self.tableView];
//    self.tableView.tableHeaderView = self.categoryHeadView;
    
    self.dataArray = [[[SourceEngineInterface shareInstances] categoryPageWithData] mutableCopy];
    if(self.dataArray && self.dataArray.count>0){
        [self.tableView reloadData];
    }
}

//在navigationbar上的右侧创建搜索按钮
-(void)createRightButtonOfSearch{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"putongjieguo.png"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClicked:)];
}

//实现搜索按钮的事件
-(void)rightBarButtonClicked:(id)sender{
    if(sender && [sender isKindOfClass:[UIBarButtonItem class]]){
        SearchViewOfCategoryController* searchController = [[SearchViewOfCategoryController alloc] init];
        [self.navigationController pushViewController:searchController animated:YES];
    }
}

//延时加载tableview
-(UITableView*)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        _tableView.backgroundColor = [UIColor whiteColor];
        
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

//延时加载headView
-(CategoryHeadView*)categoryHeadView{
    if(_categoryHeadView == nil){
        _categoryHeadView = [[CategoryHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CATEGORYHEAD_HEIGHT)];
    }
    return _categoryHeadView;
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellIdentifier = @"mycell";
    CategoryViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell){
         cell = [[CategoryViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        if((indexPath.row>=0) && (indexPath.row < self.dataArray.count)){
            
            NSDictionary* dict = [self.dataArray objectAtIndex:indexPath.row];
            CategoryInfo* categoryInfo = [[CategoryInfo alloc] initWithDictionary:dict];
            cell.categoryInfor = categoryInfo;
            [cell showCategoryCell];
            self.tableView.rowHeight = 450*(SCREEN_WIDTH/SCREEN_HEIGHT);
        }
    }
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
