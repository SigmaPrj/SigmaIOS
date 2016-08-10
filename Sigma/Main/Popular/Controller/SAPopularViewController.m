//
//  SAPopularViewController.m
//  Sigmaprj
//
//  Created by Terence on 16/7/13.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <JMessage/JMessage.h>
#import "SAPopularViewController.h"
#import "SAPopularTableView.h"
#import "SourceSubViewController.h"
#import "SAPublishViewController.h"
#import "SAPopularCell.h"
#import "SAPopularModel.h"
#import "SAPopularClassCell.h"
#import "SAPopularResourceCell.h"
#import "SAPopularEventCell.h"
#import "SAPopularRequest.h"
#import "SAPopularHeaderView.h"
#import "SourceSubViewController.h"
#import "CourseController.h"
#import "SAPopularQuestionModel.h"
#import "SAPopularClassModel.h"
#import "SAPopularResourceModel.h"
#import "TimelineViewController.h"
#import "SAAnimationNavController.h"
#import "SATeamViewController.h"
#import "SAAnimationButton.h"
#import "SAUserDataManager.h"

#define HEADER_OF_SECTION_X 0
#define HEADER_OF_SECTION_Y 0
#define HEADERVIEW_HEIGHT (280)

@interface SAPopularViewController ()<UITableViewDelegate, UITableViewDataSource,SAPopularHeaderViewDelegate>

@property (nonatomic, strong)SAPopularTableView *tableView;
@property (nonatomic, strong) NSMutableArray* datas;
@property (nonatomic, strong) NSArray* titleArray;
@property (nonatomic, strong) SAPopularHeaderView* headerView;

@property (nonatomic, strong) NSMutableArray* quesArray;
@property (nonatomic, strong) NSMutableArray* classArray;
@property (nonatomic, strong) NSMutableArray* resourcArray;




@end

@implementation SAPopularViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.view addSubview:self.tableView];
    
    
    // 添加通知
    [self addAllNotification];
    
    // 发送数据请求
    [self sendRequest];
    
    [self initUI];
    [self initData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self removeAllNotification];
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
        _tableView = [[SAPopularTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-65) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        _tableView.tableHeaderView = self.headerView;
        
    }
    
    return _tableView;
}


/**
 *  发送请求
 *
 *  @return void
 */
- (void)sendRequest {
    
    // 热门问答请求
    [SAPopularRequest requestQuestionData];
    
    [SAPopularRequest requestVideoData];
    
    [SAPopularRequest requestResourceData];
}

#pragma mark - 添加通知
- (void) addAllNotification {
    
    // 添加热门问答通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataSuccessHandler:) name:NOTI_POPULAR_QUESTION_DATA object:nil];
    
    // 添加热门课程通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataSuccessHandler:) name:NOTI_POPULAR_VIDEO_DATA object:nil];
    
    // 添加热门资源通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataSuccessHandler:) name:NOTI_POPULAR_RESOURCE_DATA object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataErrorHandler:) name:REQUEST_DATA_ERROR object:nil];
}

- (void) removeAllNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}





- (void) receiveDataSuccessHandler:(NSNotification *)noti{
    if ([noti.name isEqualToString:NOTI_POPULAR_QUESTION_DATA]) {
        if ([noti.userInfo[@"status"] intValue] == 1) {
            // 加载用户数据成功
            NSLog(@"question success");
            
            // 字典转入模型
            [self setQuesData:noti.userInfo[@"data"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                 [self.tableView reloadData];

            });
        }
    }
    
    if ([noti.name isEqualToString:NOTI_POPULAR_VIDEO_DATA]) {
        if ([noti.userInfo[@"status"] intValue] == 1) {
            // 加载课程数据成功
            NSLog(@"video success");
            [self setClassData:noti.userInfo[@"data"]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                
            });
            
        }
    }
    
    if ([noti.name isEqualToString:NOTI_POPULAR_RESOURCE_DATA]) {
        if ([noti.userInfo[@"status"] intValue] == 1) {
            // 加载用户数据成功
            NSLog(@"resource success");
            [self setResourceArray:noti.userInfo[@"data"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                
            });
        }
    }
}


- (void) receiveDataErrorHandler:notification {
    NSLog(@"数据加载失败!");
}


/**
 *  生成随机数，看抽取几个数据
 *
 *  @param from 起始index
 *  @param to 终止index
 *
 *  @return
 */
-(int)getRandomNumber:(int)from to:(int)to

{
    
    return (int)(from + (arc4random() % (to - from + 1)));
    
}


/**
 *  传入quesArray并且赋值给模型，最后放进quesArray数组里
 *
 *  @param quesArray
 */
- (void)setQuesData:(NSArray *)quesArray{
    int randomNum = [self getRandomNumber:1 to:3];
    
    for (int i = 0; i < quesArray.count-randomNum; i++) {
        SAPopularQuestionModel *quesModel = [SAPopularQuestionModel quesWithDict:quesArray[(NSInteger)i]];
        // quesArray用于存放quesModel
        [self.quesArray addObject:quesModel];
    }
}

/**
 *  课程数组生成
 *
 *  @param classArray
 */
- (void)setClassData:(NSArray*)classArray{
    int randomNum = [self getRandomNumber:1 to:3];
    for (int i = 0; i < classArray.count - randomNum; i++) {
        SAPopularClassModel *classModel = [SAPopularClassModel classWithDict:classArray[(NSInteger)i]];
        [self.classArray addObject:classModel];
    }
}


- (void)setResourceArray:(NSArray *)resourceArray{
    int randomNum = [self getRandomNumber:1 to:4];
    for (int i = 0; i < resourceArray.count - randomNum; i++) {
        SAPopularResourceModel *resourcemodel = [SAPopularResourceModel resourceWithDict:resourceArray[(NSInteger)i]];
        [self.resourcArray addObject:resourcemodel];
    }
}

/**
 *  question 数组懒加载
 *
 *  @return _quesArray
 */
- (NSMutableArray*)quesArray{
    if (!_quesArray) {
        _quesArray = [NSMutableArray array];
    }
    return _quesArray;
}


/**
 *  class 数组懒加载
 *
 *  @return _classArray
 */
- (NSMutableArray*)classArray{
    if (!_classArray) {
        _classArray = [NSMutableArray array];
    }
    return _classArray;
}

/**
 *  resource 数组懒加载
 *
 *  @return _resource
 */
- (NSMutableArray*)resourcArray{
    if (!_resourcArray) {
        _resourcArray = [NSMutableArray array];
    }
    return _resourcArray;
}


/**
 *  初始化数据
 */
-(void)initData{
    
    _titleArray = @[@"热门问答", @"热门课程", @"热门资源"];
    [self.datas addObjectsFromArray:@[self.quesArray,self.classArray,self.resourcArray]];
}

#pragma mark- UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.datas[(NSInteger)section] count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    NSInteger index = indexPath.row;
//    SAPopularModel *cdata = (SAPopularModel*)[self.datas[(NSUInteger)section] objectAtIndex:(NSUInteger)index];
    
    // 问答model
    SAPopularQuestionModel *qdata = [self.datas[(NSUInteger)section] objectAtIndex:(NSUInteger)index];

    // 课程model
    SAPopularClassModel *classdata = [self.datas[(NSUInteger)section] objectAtIndex:(NSUInteger)index];
    
    // 资源model
    SAPopularResourceModel *resourcedata = [self.datas[(NSUInteger)section] objectAtIndex:(NSUInteger)index];
    
    switch (section) {
        case 0:
        {
            static NSString *cellIdentifier = @"SAPopularQuestionCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                SAPopularCell* popularCell = [[SAPopularCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
//                [popularCell setData:cdata];
                [popularCell setQuesData:qdata];
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
                [classCell setClassData:classdata];
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
//                [resourceCell setData:cdata];
                [resourceCell setResourceData:resourcedata];
                cell = [resourceCell initUI];
                
            }
            return cell;
        }
            break;
            
            
//        活动页不放在首页了 
//        case 3:
//        {
//            static NSString *cellIdentifier = @"SAPopularEventCell";
//            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//            if (cell == nil) {
//                SAPopularEventCell* eventCell = [[SAPopularEventCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
//                [eventCell setData:cdata];
//                cell = [eventCell initUI];
//            }
//            return cell;
//        }
//            break;
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
    
    if (indexPath.section == 0) {
        // 取得section0中cell的高度
        UIImageView* view = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg4.jpg"]];
        return (view.frame.size.height/2 + 13);
        
    }else if (indexPath.section == 1){        
        UIImageView* view = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg4.jpg"]];
        // 背景图尺寸是350，比bg4 （328）大 22
        return (view.frame.size.height/2 + 20);

    }else{
        UIImageView* view = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg4.jpg"]];
        return (view.frame.size.height/2 + 13);
    }
}

/**
 *  这个要被删除 了
 *
 *  @param model SAPopularModel --- 暂时好像也没用
 *
 *  @return cellHeight
 */
- (double)getHeight:(SAPopularModel *)model {
    UIImage *image = [UIImage imageNamed:model.cellBackgroundImgName];
    return (image.size.height/2+20);
}

/**
 *  取得classCell的高度 --- 暂时好像也没用
 *
 *  @param model <#model description#>
 *
 *  @return <#return value description#>
 */
- (double)getClassCellHeight:(SAPopularClassModel *)model{
    UIImage *image = [UIImage imageNamed:model.bg_image];
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
    }
//    else if(section == 3){
//        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(HEADER_OF_SECTION_X, HEADER_OF_SECTION_Y, SCREEN_WIDTH, 100)];
//        view.backgroundColor = [UIColor whiteColor];
//        
//        
//        UIView* line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
//        line.backgroundColor = [UIColor colorWithRed:0.572  green:0.573  blue:0.572 alpha:0.9];
//        UILabel *categoryTitle = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 0, 200, 45)];
//        categoryTitle.backgroundColor = [UIColor clearColor];
//        
//        [categoryTitle setText:[self.titleArray objectAtIndex:3]];
//        [categoryTitle setFont:[UIFont systemFontOfSize:15.f]];
//        categoryTitle.textAlignment = NSTextAlignmentCenter;
//        
//        UIView* leftLine = [[UIView alloc] initWithFrame:CGRectMake(30, categoryTitle.frame.size.height/2, 20, 1)];
//        leftLine.backgroundColor = [UIColor blackColor];
//        
//        UIView* rightLine = [[UIView alloc] initWithFrame:CGRectMake(150, categoryTitle.frame.size.height/2, 20, 1)];
//        rightLine.backgroundColor = [UIColor blackColor];
//        
//        
//        UIButton* MoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 65 , 15, 40, 15)];
//        [MoreBtn setImage:[UIImage imageNamed:@"morebtn.jpg"] forState:UIControlStateNormal];
//        
//        [categoryTitle addSubview:leftLine];
//        [categoryTitle addSubview:rightLine];
//        [view addSubview:categoryTitle];
//        //        [view addSubview:line];
//        [view addSubview:MoreBtn];
//        return view;
//    }
    
    return nil;
}


-(void)quesBtnClick{
    NSLog(@"quesmorebtn click");
}

-(SAPopularHeaderView*)headerView{
    if (!_headerView) {
        _headerView = [[SAPopularHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEADERVIEW_HEIGHT)];
                _headerView.delegate = self;
        
        //        _headerView.backgroundColor = [UIColor redColor];
        
    }
    
    return _headerView;

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


#pragma mark - SAPopularHeaderViewDelegate
//资源按钮的点击事件
-(void)sourceButtonInHeadViewClicked{
    self.hidesBottomBarWhenPushed = YES;
    SourceSubViewController* sourceSubViewController = [[SourceSubViewController alloc] init];
    [self.navigationController pushViewController:sourceSubViewController animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

//课程按钮的点击事件
-(void)classButtonClicked{
    self.hidesBottomBarWhenPushed = YES;
    CourseController* courseController = [[CourseController alloc] init];
    [self.navigationController pushViewController:courseController animated:YES];
    self.hidesBottomBarWhenPushed = NO;

}

//问题按钮的点击事件
-(void)popularQuestionBtnClicked{
    self.hidesBottomBarWhenPushed = YES;
    TimelineViewController* vc = [[TimelineViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

-(void)teamButtonClicked:(UIButton *)btn {
    NSDictionary *dict = [SAUserDataManager readUser];
    [JMSGUser loginWithUsername:[NSString stringWithFormat:@"%@", dict[@"username"]] password:dict[@"password"] completionHandler:^(id resultObject, NSError *error) {
        SATeamViewController *teamViewController = [[SATeamViewController alloc] init];
        [self.navigationController pushViewController:teamViewController animated:YES];
    }];
}

@end
