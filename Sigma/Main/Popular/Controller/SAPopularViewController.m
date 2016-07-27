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
#import "SAPopularCell.h"
#import "SAPopularModel.h"
#import "SAPopularClassCell.h"
#import "SAPopularResourceCell.h"
#import "SAPopularEventCell.h"


#define HEADER_OF_SECTION_X 0
#define HEADER_OF_SECTION_Y 0


@interface SAPopularViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)SAPopularTableView *tableView;
@property (nonatomic, strong) NSMutableArray* datas;
@property (nonatomic, strong) NSMutableArray* titleDatas;
//@property (nonatomic, strong) SAPopularHeaderView* headerView;
@property (nonatomic ,strong) NSArray* titleArray;

@end

@implementation SAPopularViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *b = [[UIBarButtonItem alloc] initWithTitle:@"test" style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    self.navigationItem.rightBarButtonItem = b;
    
//    [self.view addSubview:self.tableView];
    
    [self initUI];
    [self initData];
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

-(NSMutableArray*)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    
    return _datas;
}


-(SAPopularTableView*)tableView{
    if (!_tableView) {
        _tableView = [[SAPopularTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
    }
    
    return _tableView;
}


/**
 *  初始化数据
 */
-(void)initData{
    
    _titleArray = @[@"热门问答", @"热门课程", @"热门资源", @"热门活动"];
    
    NSDictionary* dict1 = @{
                            @"AvataImgName":@"avata.jpg",
                            @"nickName":@"ttt",
                            @"cellBackgroundImgName":@"bg1.jpg",
                            @"title":@".NET？",
                            @"desc":@"神秘的.net",
                            @"number":@"999",
                            @"type":@"1"
                            };
    
    
    NSDictionary* dict2 = @{
                            @"AvataImgName":@"avata.jpg",
                            @"nickName":@"不正常人类",
                            @"cellBackgroundImgName":@"bg4.jpg",
                            @"title":@"突破思维局限",
                            @"desc":@"如何突破思维局限",
                            @"number":@"91",
                            @"type":@"1"
                            };
    
    
    NSDictionary* dict3 = @{
                            @"AvataImgName":@"avata.jpg",
                            @"nickName":@"IOS开发工程师",
                            @"cellBackgroundImgName":@"bg4.jpg",
                            @"title":@"IOS开发指南",
                            @"desc":@"5年经验工程师带你开发",
                            @"number":@"1888",
                            @"type":@"2"
                            };
    
    
    NSDictionary* dict4 = @{
                            @"AvataImgName":@"avata.jpg",
                            @"nickName":@"前端大神",
                            @"cellBackgroundImgName":@"bg4.jpg",
                            @"title":@"前端开发",
                            @"desc":@"讲解前端开发的技巧",
                            @"number":@"666",
                            @"type":@"2"
                            };
    
    NSDictionary* dict5 =  @{
                             @"AvataImgName":@"avata.jpg",
                             @"nickName":@"Java",
                             @"cellBackgroundImgName":@"bg3.jpg",
                             @"title":@"JavaScript高级程序设计",
                             @"desc":@"必备数据",
                             @"number":@"666",
                             @"type":@"3"
                             };
    
    NSDictionary* dict6 = @{
                            @"AvataImgName":@"avata.jpg",
                            @"nickName":@"阿里",
                            @"cellBackgroundImgName":@"bg.jpg",
                            @"title":@"云计算和分布式",
                            @"desc":@"当前最火的云计算讲座",
                            @"number":@"129",
                            @"type":@"4"
                            };
    
    
    NSDictionary* dict7 = @{
                            @"AvataImgName":@"avata.jpg",
                            @"nickName":@"tx",
                            @"cellBackgroundImgName":@"bg.jpg",
                            @"title":@"做好产品经理",
                            @"desc":@"如何做一个产品经理",
                            @"number":@"354",
                            @"type":@"2"
                            };
    
    
    NSArray* dictArray = @[dict1,dict2,dict3,dict4,dict5,dict6,dict7];
    
    NSMutableArray* questionArray = [[NSMutableArray alloc] init];
    NSMutableArray* classArray = [[NSMutableArray alloc] init];
    NSMutableArray* resourceArray = [[NSMutableArray alloc] init];
    NSMutableArray* eventArray = [[NSMutableArray alloc] init];
    
    
    /**
     *  遍历dictArray取出各部分对应的dict并转换成Model，并加入对应数组
     */
    for (int i = 0; i < dictArray.count; i++) {
        SAPopularModel *model = [[SAPopularModel alloc] initWithDict:[dictArray objectAtIndex:i]];
        if (model.type == 1) {
            [questionArray addObject:model];
            model.cellHeight = [self getHeight:model];
        }else if (model.type == 2){
            [classArray addObject:model];
            model.cellHeight = [self getHeight:model];
        }else if (model.type == 3){
            [resourceArray addObject:model];
            model.cellHeight = [self getHeight:model];
        }else if (model.type == 4){
            [eventArray addObject:model];
            model.cellHeight = [self getHeight:model];
        }
        
    }
    
    [self.datas addObjectsFromArray:@[questionArray,classArray,resourceArray,eventArray]];
    
    
    
    
}

#pragma mark- UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.datas[(NSInteger)section] count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    NSInteger index = indexPath.row;
    SAPopularModel *cdata = (SAPopularModel*)[self.datas[(NSUInteger)section] objectAtIndex:(NSUInteger)index];
    
    switch (section) {
        case 0:
        {
            static NSString *cellIdentifier = @"SAPopularQuestionCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                SAPopularCell* popularCell = [[SAPopularCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
                [popularCell setData:cdata];
                cell = [popularCell initUI];
            }
            return cell;
        }
            break;
            
        case 1:
        {
            static NSString *cellIdentifier = @"SAPopularClassCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                SAPopularClassCell* classCell = [[SAPopularClassCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
                [classCell setData:cdata];
                cell = [classCell initUI];
                
            }
            return cell;
        }
            break;
            
        case 2:
        {
            static NSString *cellIdentifier = @"SAPopularResourceCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                SAPopularResourceCell* resourceCell = [[SAPopularResourceCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
                [resourceCell setData:cdata];
                cell = [resourceCell initUI];
                
            }
            return cell;
        }
            break;
            
        case 3:
        {
            static NSString *cellIdentifier = @"SAPopularEventCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                SAPopularEventCell* eventCell = [[SAPopularEventCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
                [eventCell setData:cdata];
                cell = [eventCell initUI];
            }
            return cell;
        }
            break;
        default:
            break;
    }
    
    return nil;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datas.count;
}

#pragma mark -
#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SAPopularModel *model = [self.datas[indexPath.section] objectAtIndex:indexPath.row];
    return model.cellHeight;
}

- (double)getHeight:(SAPopularModel *)model {
    UIImage *image = [UIImage imageNamed:model.cellBackgroundImgName];
    return (image.size.height/2+20);
}

/**
 *  设置section的header
 *
 *  @param tableView <#tableView description#>
 *  @param section   <#section description#>
 *
 *  @return <#return value description#>
 */
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(HEADER_OF_SECTION_X, HEADER_OF_SECTION_Y, SCREEN_WIDTH, 100)];
        view.backgroundColor = [UIColor yellowColor];
        
        
        UIView* line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:0.572  green:0.573  blue:0.572 alpha:0.9];
        UILabel *categoryTitle = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 0, 200, 45)];
        categoryTitle.backgroundColor = [UIColor clearColor];
        
        //        [categoryTitle setText:@"热门活动"];
        [categoryTitle setText:[self.titleArray objectAtIndex:0]];
        [categoryTitle setFont:[UIFont systemFontOfSize:15.f]];
        categoryTitle.textAlignment = NSTextAlignmentCenter;
        
        
        UIView* leftLine = [[UIView alloc] initWithFrame:CGRectMake(30, categoryTitle.frame.size.height/2, 20, 1)];
        leftLine.backgroundColor = [UIColor blackColor];
        
        UIView* rightLine = [[UIView alloc] initWithFrame:CGRectMake(150, categoryTitle.frame.size.height/2, 20, 1)];
        rightLine.backgroundColor = [UIColor blackColor];
        
        
        UIButton* MoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 65 , 15, 40, 15)];
        [MoreBtn setImage:[UIImage imageNamed:@"morebtn.jpg"] forState:UIControlStateNormal];
        [MoreBtn addTarget:self action:@selector(quesBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [categoryTitle addSubview:leftLine];
        [categoryTitle addSubview:rightLine];
        [view addSubview:categoryTitle];
        [view addSubview:line];
        [view addSubview:MoreBtn];
        return view;
    }else if(section == 1){
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(HEADER_OF_SECTION_X, HEADER_OF_SECTION_Y, SCREEN_WIDTH, 100)];
        view.backgroundColor = [UIColor whiteColor];
        
        
        UIView* line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:0.572  green:0.573  blue:0.572 alpha:0.9];
        UILabel *categoryTitle = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 0, 200, 45)];
        categoryTitle.backgroundColor = [UIColor clearColor];
        
        [categoryTitle setText:[self.titleArray objectAtIndex:1]];
        [categoryTitle setFont:[UIFont systemFontOfSize:15.f]];
        categoryTitle.textAlignment = NSTextAlignmentCenter;
        
        UIView* leftLine = [[UIView alloc] initWithFrame:CGRectMake(30, categoryTitle.frame.size.height/2, 20, 1)];
        leftLine.backgroundColor = [UIColor blackColor];
        
        UIView* rightLine = [[UIView alloc] initWithFrame:CGRectMake(150, categoryTitle.frame.size.height/2, 20, 1)];
        rightLine.backgroundColor = [UIColor blackColor];
        
        
        UIButton* MoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 65 , 15, 40, 15)];
        [MoreBtn setImage:[UIImage imageNamed:@"morebtn.jpg"] forState:UIControlStateNormal];
        [MoreBtn addTarget:self action:@selector(classBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [categoryTitle addSubview:leftLine];
        [categoryTitle addSubview:rightLine];
        [view addSubview:categoryTitle];
        //        [view addSubview:line];
        [view addSubview:MoreBtn];
        return view;
    }else if(section == 2){
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(HEADER_OF_SECTION_X, HEADER_OF_SECTION_Y, SCREEN_WIDTH, 100)];
        view.backgroundColor = [UIColor whiteColor];
        
        
        UIView* line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:0.572  green:0.573  blue:0.572 alpha:0.9];
        UILabel *categoryTitle = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 0, 200, 45)];
        categoryTitle.backgroundColor = [UIColor clearColor];
        
        
        [categoryTitle setText:[self.titleArray objectAtIndex:2]];
        [categoryTitle setFont:[UIFont systemFontOfSize:15.f]];
        categoryTitle.textAlignment = NSTextAlignmentCenter;
        
        UIView* leftLine = [[UIView alloc] initWithFrame:CGRectMake(30, categoryTitle.frame.size.height/2, 20, 1)];
        leftLine.backgroundColor = [UIColor blackColor];
        
        UIView* rightLine = [[UIView alloc] initWithFrame:CGRectMake(150, categoryTitle.frame.size.height/2, 20, 1)];
        rightLine.backgroundColor = [UIColor blackColor];
        
        
        UIButton* MoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 65 , 15, 40, 15)];
        [MoreBtn setImage:[UIImage imageNamed:@"morebtn.jpg"] forState:UIControlStateNormal];
        
        [categoryTitle addSubview:leftLine];
        [categoryTitle addSubview:rightLine];
        [view addSubview:categoryTitle];
        //        [view addSubview:line];
        [view addSubview:MoreBtn];
        return view;
    }else if(section == 3){
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(HEADER_OF_SECTION_X, HEADER_OF_SECTION_Y, SCREEN_WIDTH, 100)];
        view.backgroundColor = [UIColor whiteColor];
        
        
        UIView* line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:0.572  green:0.573  blue:0.572 alpha:0.9];
        UILabel *categoryTitle = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 0, 200, 45)];
        categoryTitle.backgroundColor = [UIColor clearColor];
        
        [categoryTitle setText:[self.titleArray objectAtIndex:3]];
        [categoryTitle setFont:[UIFont systemFontOfSize:15.f]];
        categoryTitle.textAlignment = NSTextAlignmentCenter;
        
        UIView* leftLine = [[UIView alloc] initWithFrame:CGRectMake(30, categoryTitle.frame.size.height/2, 20, 1)];
        leftLine.backgroundColor = [UIColor blackColor];
        
        UIView* rightLine = [[UIView alloc] initWithFrame:CGRectMake(150, categoryTitle.frame.size.height/2, 20, 1)];
        rightLine.backgroundColor = [UIColor blackColor];
        
        
        UIButton* MoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 65 , 15, 40, 15)];
        [MoreBtn setImage:[UIImage imageNamed:@"morebtn.jpg"] forState:UIControlStateNormal];
        
        [categoryTitle addSubview:leftLine];
        [categoryTitle addSubview:rightLine];
        [view addSubview:categoryTitle];
        //        [view addSubview:line];
        [view addSubview:MoreBtn];
        return view;
    }
    
    return nil;
}


-(void)quesBtnClick{
    NSLog(@"quesmorebtn click");
}

-(void)classBtnClick{
    NSLog(@"classmorebtn click");
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}


@end
