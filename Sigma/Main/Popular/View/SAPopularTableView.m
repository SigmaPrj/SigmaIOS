//
//  SAPopularTableView.m
//  Sigma
//
//  Created by Terence on 16/7/14.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAPopularTableView.h"
#import "SAPopularHeaderView.h"
#import "SAPopularCell.h"
#import "SAPopularModel.h"
#import "SAPopularClassCell.h"
#import "SAPopularResourceCell.h"
#import "SAPopularEventCell.h"

#define HEADERVIEW_HEIGHT (280)
@interface SAPopularTableView () <UITableViewDelegate, UITableViewDataSource>

//@property (nonatomic, strong)

// 数据
@property (nonatomic, strong) NSMutableArray* datas;
@property (nonatomic, strong) NSMutableArray* titleDatas;
@property (nonatomic, strong) SAPopularHeaderView* headerView;
@property (nonatomic ,strong) NSArray* titleArray;

@end

@implementation SAPopularTableView



/**
 *  重写Init方法
 *
 *  @param frame <#frame description#>
 *  @param style <#style description#>
 *
 *  @return <#return value description#>
 */
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        
        self.backgroundColor = COLOR_RGB(245, 245, 245);
        
        self.minimumZoomScale = 1.0;
        self.maximumZoomScale = 1.0;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        // 不要cell间的分割线
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableHeaderView = self.headerView;
        
        self.delegate = self;
        self.dataSource = self;
        
        [self initData];
    }
    
    return self;
}


-(NSMutableArray*)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    
    return _datas;
}

-(SAPopularHeaderView*)headerView{
    if (!_headerView) {
        _headerView = [[SAPopularHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEADERVIEW_HEIGHT)];
        
//        _headerView.backgroundColor = [UIColor redColor];
        
    }
    
    return _headerView;
}


/**
 *  初始化数据
 */
-(void)initData{
    SAPopularModel *model1 = [[SAPopularModel alloc] init];
    model1.AvataImgName = @"avata.jpg";
    model1.nickName = @"不正常人类";
    model1.cellBackgroundImgName = @"bg.jpg";
    model1.title = @"突破思维局限";
    model1.desc = @"如何突破思维局限？？？？";
    model1.number = 1000;
    model1.cellHeight = [self getHeight:model1];
    model1.type = 1;
    
    SAPopularModel *model2 = [[SAPopularModel alloc] init];
    model2.AvataImgName = @"avata.jpg";
    model2.nickName = @"IOS开发工程师";
    model2.cellBackgroundImgName = @"bg1.jpg";
    model2.title = @"IOS开发指南";
    model2.desc = @"IOS大牛教你开发Apple App";
    model2.number = 50;
    model2.cellHeight = [self getHeight:model1];
    model2.type = 2;
    
    
    SAPopularModel *model3 = [[SAPopularModel alloc] init];
    model3.AvataImgName = @"avata.jpg";
    model3.nickName = @"前端菜鸟";
    model3.cellBackgroundImgName = @"bg3.jpg";
    model3.title = @"Javascript高级程序设计";
    model3.desc = @"前端红宝书";
    model3.number = 10;
    model3.cellHeight = [self getHeight:model1];
    model3.type = 3;
    
    
    SAPopularModel *model4 = [[SAPopularModel alloc] init];
    model4.AvataImgName = @"avata.jpg";
    model4.nickName = @"sss";
    model4.cellBackgroundImgName = @"bg4.jpg";
    model4.title = @"前端经验分享";
    model4.desc = @"与大神面对面谈技术";
    model4.number = 100;
    model4.cellHeight = [self getHeight:model1];
    model4.type = 4;
    
    NSArray *array1 = @[model1];
    NSArray *array2 = @[model2];
    NSArray *array3 = @[model3];
    NSArray *array4 = @[model4];
    
     _titleArray = @[@"热门问答", @"热门课程", @"热门资源", @"热门活动"];
    [self.datas addObjectsFromArray:@[array1, array2, array3, array4]];
   
    
}

#pragma mark- UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.datas[(NSInteger)section] count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"SAPopularCell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    NSInteger section = indexPath.section;
    NSInteger index = indexPath.row;
    
    if (!cell) {
        if (indexPath.section >=0 && indexPath.row >= 0 && section < self.datas.count && index < [self.datas[(NSUInteger)section] count]) {
            SAPopularModel *cdata = (SAPopularModel*)[self.datas[(NSUInteger)section] objectAtIndex:(NSUInteger)index];

            switch (cdata.type) {
                case 1:
                {
                    SAPopularCell* popularCell = [[SAPopularCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
                    [popularCell setData:cdata];
                    cell = [popularCell initUI];
                }
                    break;
                case 2:
                {
                    SAPopularClassCell* classCell = [[SAPopularClassCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
                    [classCell setData:cdata];
                    cell = [classCell initUI];
                }
                    break;
                case 3:
                {
                    SAPopularResourceCell* resourceCell = [[SAPopularResourceCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
                    [resourceCell setData:cdata];
                    cell = [resourceCell initUI];
                }
                    break;
                case 4:
                {
                    SAPopularEventCell* eventCell = [[SAPopularEventCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
                    [eventCell setData:cdata];
                    cell = [eventCell initUI];
                }
                default:
                    break;
            }
            
           
        }else{
            cell = nil;
        }
    }
    
    return cell;
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
        
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        view.backgroundColor = [UIColor whiteColor];
        
        
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
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        view.backgroundColor = [UIColor whiteColor];
        
        
        UIView* line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:0.572  green:0.573  blue:0.572 alpha:0.9];
        UILabel *categoryTitle = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 0, 200, 45)];
        categoryTitle.backgroundColor = [UIColor clearColor];
//        [categoryTitle setText:@"热门课程"];
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
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        view.backgroundColor = [UIColor whiteColor];
        
        
        UIView* line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:0.572  green:0.573  blue:0.572 alpha:0.9];
        UILabel *categoryTitle = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 0, 200, 45)];
        categoryTitle.backgroundColor = [UIColor clearColor];
//        [categoryTitle setText:@"热门课程"];
        
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
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        view.backgroundColor = [UIColor whiteColor];
        
        
        UIView* line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:0.572  green:0.573  blue:0.572 alpha:0.9];
        UILabel *categoryTitle = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 0, 200, 45)];
        categoryTitle.backgroundColor = [UIColor clearColor];
//        [categoryTitle setText:@"热门课程"];
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
