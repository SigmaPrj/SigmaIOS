//
//  SAQuesViewController.m
//  Sigma
//
//  Created by 韩佳成 on 16/7/28.
//  Copyright © 2016年 韩佳成. All rights reserved.
//

#import "SAMyQuestionViewController.h"
#import "SAMyQuestionCell.h"
#import "SAMyQuestionTableViewCell.h"
#import "SAMyQuestionViewEngine.h"

#import "MJRefresh.h"

#define MARGIN 15

static const CGFloat MJDuration = 1.5;


@interface SAMyQuestionViewController()<UITableViewDataSource, UITableViewDelegate,SAMyQuestionTableViewCellDelegate>

@property (nonatomic,strong)UITableView *questionTableView;
@property (nonatomic, strong)NSArray* dataArray;
@property(nonatomic,strong)UISearchBar *searchBar;


@end

@implementation SAMyQuestionViewController


- (void)viewDidLoad {
    [self initUI];
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{    
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)initUI{
    
    self.view.backgroundColor = [UIColor colorWithRed:235/255. green:235/255. blue:241/255. alpha:1.0];
    [self.view addSubview:self.questionTableView];
    
    self.navigationItem.titleView = self.searchBar;
    self.dataArray = [[SAMyQuestionViewEngine shareInstance] dataSection];
    if ([self isExisted:self.dataArray]) {
        [self.questionTableView reloadData];
    }
}

-(BOOL)isExisted:(NSArray*)array{
    if (array&&array.count>0) {
        return YES;
    }else{
        return NO;
    }
}

-(UISearchBar*)searchBar{
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(60, 5, SCREEN_WIDTH-120, 34)];
        
        _searchBar.placeholder  = @"搜索问答、文章、话题或用户";
        _searchBar.tintColor = [UIColor colorWithRed:235/255. green:235/255. blue:241/255. alpha:1.0];
    }
    return _searchBar;
}

-(UITableView*)questionTableView{
    if(_questionTableView == nil){
        _questionTableView = [[UITableView alloc]initWithFrame:CGRectMake(MARGIN, 0, SCREEN_WIDTH-MARGIN*2, SCREEN_HEIGHT)style:UITableViewStyleGrouped];
        _questionTableView.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
        
        _questionTableView.delegate = self;
        _questionTableView.dataSource = self;
        
        _questionTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        [_questionTableView setSeparatorColor:[UIColor whiteColor]];
        
        [self pullToRefresh];
    }
    
    return _questionTableView;
}

- (void)pullToRefresh
{
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.questionTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    // 马上进入刷新状态
    [self.questionTableView.mj_header beginRefreshing];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.questionTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置了底部inset
    self.questionTableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    // 忽略掉底部inset
    self.questionTableView.mj_footer.ignoredScrollViewContentInsetBottom = 30;
}

#pragma mark - UItableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIndentifier = @"homeCell";
    
    SAMyQuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    
    if (!cell) {
        cell = [[SAMyQuestionTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIndentifier];
        
        cell.delegate=self;
    }
    
    if ((indexPath.section >=0) && (indexPath.section < self.dataArray.count)) {
        
        SAMyQuestionCell* cellSection = (SAMyQuestionCell*)[self.dataArray objectAtIndex:indexPath.section];
        SAMyQuestionCell* data = [[SAMyQuestionCell alloc] init];
        
        data.title = cellSection.title;
        data.detail=cellSection.detail;
        data.headImgName=cellSection.headImgName;
        data.popularity=cellSection.popularity;
        
        cell.data = data;
        
        [cell showMyQuestionCell];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"didSelectRowAtIndexPath clicked");
}
#pragma mark 下拉刷新数据
- (void)loadNewData
{
//     1.添加假数据
//    for (int i = 0; i<5; i++) {
//        [self.dataArray addObj
//    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.questionTableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [tableView.mj_header endRefreshing];
    });
}
@end
