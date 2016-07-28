//
//  CourseController.m
//  Sigma
//
//  Created by 韩佳成 on 16/7/26.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "CourseController.h"
#import "CourseMainPageHeadView.h"
#import "CourseCommonDefine.h"
#import "CourseEngine.h"
#import "MainPageTableCell.h"
#import "MainPageCellInfo.h"
#import "MainPageCellModel.h"
#import "CourseSearchViewController.h"

@interface CourseController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView* mainPagetableView;

//主页的headview
@property(nonatomic,strong)CourseMainPageHeadView* headView;

//cell的array
@property(nonatomic,strong)NSMutableArray* cellDataArray;


@end

@implementation CourseController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createRightSearchButton];
}

-(void)initUI{
    self.title = @"课程";
    [self.view addSubview:self.mainPagetableView];
    [self.mainPagetableView.tableHeaderView addSubview:self.headView];
    
    self.cellDataArray = [[[CourseEngine shareInstances] cellWithData] mutableCopy];
    if(self.cellDataArray && self.cellDataArray.count>0){
        [self.mainPagetableView reloadData];
    }
}

//创建navigatiobar上右侧的搜索按钮
-(void)createRightSearchButton{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"putongjieguo.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClicked:)];
}

//实现搜索按钮事件
-(void)rightButtonClicked:(id)sender{
    if(sender && [sender isKindOfClass:[UIBarButtonItem class]]){
        self.hidesBottomBarWhenPushed = YES;
        CourseSearchViewController* courseSearchViewController = [[CourseSearchViewController alloc] init];
        [self.navigationController pushViewController:courseSearchViewController animated:YES];
    }
}

//延时加载tableView
-(UITableView*)mainPagetableView{
    if(_mainPagetableView == nil){
        _mainPagetableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        
        _mainPagetableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCROLL_HEIGHT)];
        _mainPagetableView.backgroundColor = [UIColor whiteColor];
        _mainPagetableView.showsHorizontalScrollIndicator = NO;
        _mainPagetableView.showsVerticalScrollIndicator = NO;
        
        _mainPagetableView.dataSource = self;
        _mainPagetableView.delegate = self;
        
    }
    return _mainPagetableView;
}

//延时加载headview
-(CourseMainPageHeadView*)headView{
    if(_headView == nil){
         _headView = [[CourseMainPageHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCROLL_HEIGHT)];
    }
    return _headView;
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellDataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellIdentifier = @"myCell";
    
    MainPageTableCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell){
        cell = [[MainPageTableCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        if((indexPath.row>=0) && (indexPath.row < self.cellDataArray.count)){
            MainPageCellModel* mainPageCellModel = (MainPageCellModel*)[self.cellDataArray objectAtIndex:indexPath.row];
            
            MainPageCellInfo* mainPageCellInfo = [[MainPageCellInfo alloc] init];
            mainPageCellInfo.imageName = mainPageCellModel.imageName;
            mainPageCellInfo.className = mainPageCellModel.className;
            mainPageCellInfo.numOfStudy = mainPageCellModel.numOfStudy;
            
            cell.mainPageCellInfo = mainPageCellInfo;
            [cell showMainPageViewCell];
            self.mainPagetableView.rowHeight = CELL_HEIGHT;
        }
    }
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
