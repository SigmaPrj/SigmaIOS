//
//  SAPopularViewController.m
//  Sigmaprj
//
//  Created by Terence on 16/7/13.
//  Copyright © 2016年 Terence. All rights reserved.
//

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
        _tableView = [[SAPopularTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50) style:UITableViewStyleGrouped];
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
    int randomNum = [self getRandomNumber:2 to:4];
    for (int i = 0; i < classArray.count - randomNum; i++) {
        SAPopularClassModel *classModel = [SAPopularClassModel classWithDict:classArray[(NSInteger)i]];
        [self.classArray addObject:classModel];
    }
}


- (void)setResourceArray:(NSArray *)resourceArray{
    int randomNum = [self getRandomNumber:2 to:4];
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
                            @"desc":@"Sequi voluptatem voluptatem consequatur voluptas. Quod et quia aut expedita nisi libero quasi autem. Consequatur nostrum eos molestias iure. Tempora cumque non aut debitis ipsa exercitationem in.\nEst voluptates aliquam voluptatem. Minima sequi praesentium eum et cumque. Maiores commodi quas itaque et.\nQui dolores sunt et a quasi non. Iste at id dolor neque sed maxime. Ullam et quo unde rerum voluptatibus necessitatibus. Odio laboriosam iure neque assumenda commodi quis.\nId repellendus voluptatum similique quisquam tenetur voluptas ex magnam. Repudiandae ea ipsum fuga id. Consequatur enim dignissimos modi dicta asperiores. Aliquid aut non odio neque.\nSit debitis dignissimos maxime deserunt natus facilis voluptatum quia. Nisi ut exercitationem odio possimus eum nulla. Ad id amet velit aut autem quam officiis iusto. Molestiae nam et facilis repudiandae a praesentium.\nAtque corrupti distinctio sunt temporibus animi eius assumenda. Fugiat accusamus culpa velit ab est. Fugit placeat accusantium dolorum fugiat consequatur veritatis dolor soluta. Qui deleniti sit laborum ut ex blanditiis",
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
                            @"cellBackgroundImgName":@"bg1.jpg",
                            @"title":@"做好产品经理",
                            @"desc":@"如何做一个产品经理",
                            @"number":@"354",
                            @"type":@"2",
                            };
    
    
    NSArray* dictArray = @[dict1,dict2,dict3,dict4,dict5,dict6,dict7];
    
//    NSMutableArray* questionArray = [[NSMutableArray alloc] init];
//    NSMutableArray* classArray = [[NSMutableArray alloc] init];
    NSMutableArray* resourceArray = [[NSMutableArray alloc] init];
//    NSMutableArray* eventArray = [[NSMutableArray alloc] init];
    
    
    /**
     *  遍历dictArray取出各部分对应的dict并转换成Model，并加入对应数组
     */
    for (int i = 0; i < dictArray.count; i++) {
        SAPopularModel *model = [[SAPopularModel alloc] initWithDict:[dictArray objectAtIndex:i]];
        if (model.type == 1) {
//            [questionArray addObject:model];
//            model.cellHeight = [self getHeight:model];
        }else if (model.type == 2){
//            [classArray addObject:model];
//            model.cellHeight = [self getHeight:model];
        }else if (model.type == 3){
//            [resourceArray addObject:model];
//            model.cellHeight = [self getHeight:model];
        }
//        else if (model.type == 4){
//            [eventArray addObject:model];
//            model.cellHeight = [self getHeight:model];
//        }
        
    }
    
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
        return (view.frame.size.height/2 + 20);
        
    }else if (indexPath.section == 1){        
        UIImageView* view = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg4.jpg"]];
        // 背景图尺寸是350，比bg4 （328）大 22
        return (view.frame.size.height/2 + 20+22);

    }else{
        UIImageView* view = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg4.jpg"]];
        return (view.frame.size.height/2 + 20);
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

@end
