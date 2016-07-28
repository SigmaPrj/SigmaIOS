//
//  SAQuestionViewController.m
//  Sigma
//
//  Created by Ace Hsieh on 7/27/16.
//  Copyright © 2016 blackcater. All rights reserved.
//

#import "SAQuestionViewController.h"
#import "SAQuestionCell.h"
#import "SAQuestionTableViewCell.h"
#import "SAQuestionViewEngine.h"

#define MARGIN 15


@interface SAQuestionViewController ()<UITableViewDataSource, UITableViewDelegate,SAQuestionTableViewCellDelegate>

@property (nonatomic,strong)UITableView *questionTableView;
@property (nonatomic, strong)NSArray* dataArray;
@property(nonatomic,strong)UISearchBar *searchBar;

@end

@implementation SAQuestionViewController

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
    self.dataArray = [[SAQuestionViewEngine shareInstance] dataSection];
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
    }
    
    return _questionTableView;
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
    
    SAQuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    
    if (!cell) {
        cell = [[SAQuestionTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIndentifier];
        
        cell.delegate=self;
    }
    
    if ((indexPath.section >=0) && (indexPath.section < self.dataArray.count)) {

        SAQuestionCell* cellSection = (SAQuestionCell*)[self.dataArray objectAtIndex:indexPath.section];
        SAQuestionCell* data = [[SAQuestionCell alloc] init];
        
        data.title = cellSection.title;
        data.detail=cellSection.detail;
        data.headImgName=cellSection.headImgName;
        data.popularity=cellSection.popularity;
        
        cell.data = data;
        
        [cell showQuestionCell];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"didSelectRowAtIndexPath clicked");
}

@end
