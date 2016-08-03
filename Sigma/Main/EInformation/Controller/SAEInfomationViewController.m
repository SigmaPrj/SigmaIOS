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
#import "SAEinfoDetailViewController.h"
#import "SAEInformationCell.h"
#import "SAEInformationModel.h"
#import "SAEInformationTypeRequest.h"
#import "SAEInformationTypeModel.h"

@interface SAEInfomationViewController () <EInformationTopBarViewDelegate, UITableViewDelegate>

@property (nonatomic, strong)SAEInformationTableView* tableView;
@property (nonatomic, strong)EInformationTopBarView* topbarview;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSMutableArray *newsTypeArray;
@property(nonatomic, strong) NSMutableArray* datas;

@end

@implementation SAEInfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加通知
    [self addAllNotification];
    
    // 发送数据
    [self sendRequest];
    
    [self initUI];
    
    [self initData];
    
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
    [self removeAllNotification];
}

-(instancetype)init{
    self = [super init];
    
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

-(void)initUI{
    
    [self.view addSubview:self.tableView];
    //[self.view addSubview:self.topbarview];
}

-(void)initData{
    _categories = _newsTypeArray;
}

- (NSArray *)categories {
    if (!_categories) {
//        _categories = @[@"数学建模", @"奥数竞赛", @"微软竞赛", @"小型比赛", @"BAT", @"搜狐网", @"新浪网", @"网易网", @"校园网", @"国家级"];
        
        _categories = [NSArray array];
        _categories = self.newsTypeArray;
        //NSLog(@"%lu",(unsigned long)self.newsTypeArray.count);
    }
    
    return _categories;
}


- (NSMutableArray*)newsTypeArray{
    if (!_newsTypeArray) {
        _newsTypeArray = [NSMutableArray array];
    }
    return _newsTypeArray;
}

-(SAEInformationTableView*)tableView{
    if (!_tableView) {
        _tableView = [[SAEInformationTableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, (SCREEN_HEIGHT-120)) style:UITableViewStylePlain];
        _tableView.delegate = self;
//        _tableView.dataSource = self;

    }
    
    return _tableView;
}

-(EInformationTopBarView*)topbarview{
    if (!_topbarview) {
        _topbarview = [[EInformationTopBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 42) categoreis:self.categories];
        _topbarview.backgroundColor = [UIColor whiteColor];
        _topbarview.delegate = self;
    }
    
    return _topbarview;
}

/**
 *  发送请求
 *
 *  @return
 */
- (void)sendRequest {
    [SAEInformationTypeRequest requestEInfoType];
}


#pragma mark - 添加通知
- (void) addAllNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataSuccessHandler:) name:NOTI_EINFORMATION_NEWSTYPE object:nil];
}

#pragma mark - 移除通知
-(void) removeAllNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)receiveDataSuccessHandler:(NSNotification *)noti{
    if ([noti.name isEqualToString:NOTI_EINFORMATION_NEWSTYPE]) {
        if ([noti.userInfo[@"status"] intValue] == 1) {
            // 资讯种类加载成功
            NSLog(@"newstype success");
            
            
            [self setNewsTypeData:noti.userInfo[@"data"]];
            
        }
    }
}


/**
 *  资讯种类字典转模型
 *
 *  @return
 */
-(void) setNewsTypeData:(NSArray*)newstypeArray{
    for (int i = 0; i < newstypeArray.count; i++) {
        SAEInformationTypeModel *newstypeModel = [SAEInformationTypeModel newsTypeWithDict:newstypeArray[(NSInteger)i]];
        [self.newsTypeArray addObject:newstypeModel.news_name];
        NSLog(@"%@", newstypeModel.news_name);
    }
    //[self.topbarview setCategories:self.newsTypeArray];
    //[self categories];
   // [self topbarview];
    [self.view addSubview:self.topbarview];

//    [self.topbarview setCategories:newstypeArray];
}


#pragma mark - EInformationTopBarViewDelegate
-(void)btnClickedWithTag:(int)tag{
    NSLog(@"%d",tag);
    if (tag == 1000) {
        NSDictionary* dict1 = @{
                                @"desc":@"第八届全国大学生数学竞赛111",
                                @"mainImgName":@"test.jpg",
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
    }else if(tag == 1003){
        NSDictionary* dict1 = @{
                                @"desc":@"演讲1",
                                @"mainImgName":@"competition2.png",
                                @"number":@"211"
                                };
        
        
        NSDictionary* dict2 = @{
                                @"desc":@"演讲2",
                                @"mainImgName":@"competition1.png",
                                @"number":@"123"
                                };
        
        NSDictionary* dict3 = @{
                                @"desc":@"演讲3",
                                @"mainImgName":@"competition4.png",
                                @"number":@"1120"
                                };
        
        NSDictionary* dict4 = @{
                                @"desc":@"演讲4",
                                @"mainImgName":@"competition3.png",
                                @"number":@"100"
                                };
        
        //
        //
        NSArray* dictArray = @[dict1, dict2, dict3, dict4];
        [self.tableView initData:dictArray];
    }else if (tag == 1004){
        NSDictionary* dict1 = @{
                                @"desc":@"游戏1",
                                @"mainImgName":@"competition2.png",
                                @"number":@"211"
                                };
        
        
        NSDictionary* dict2 = @{
                                @"desc":@"游戏2",
                                @"mainImgName":@"competition1.png",
                                @"number":@"123"
                                };
        
        NSDictionary* dict3 = @{
                                @"desc":@"游戏3",
                                @"mainImgName":@"competition4.png",
                                @"number":@"1120"
                                };
        
        NSDictionary* dict4 = @{
                                @"desc":@"游戏4",
                                @"mainImgName":@"competition3.png",
                                @"number":@"100"
                                };
        
        NSArray* dictArray = @[dict1, dict2, dict3, dict4];
        [self.tableView initData:dictArray];

    }else if(tag == 1005){
        NSDictionary* dict1 = @{
                                @"desc":@"建模1",
                                @"mainImgName":@"competition2.png",
                                @"number":@"211"
                                };
        
        
        NSDictionary* dict2 = @{
                                @"desc":@"建模2",
                                @"mainImgName":@"competition1.png",
                                @"number":@"123"
                                };
        
        NSDictionary* dict3 = @{
                                @"desc":@"建模3",
                                @"mainImgName":@"competition4.png",
                                @"number":@"1120"
                                };
        
        NSDictionary* dict4 = @{
                                @"desc":@"建模4",
                                @"mainImgName":@"competition3.png",
                                @"number":@"100"
                                };
        
        NSArray* dictArray = @[dict1, dict2, dict3, dict4];
        [self.tableView initData:dictArray];
    }
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SAEinfoDetailViewController* detailvc = [[SAEinfoDetailViewController alloc]init];
    detailvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailvc animated:YES];
    
    
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    UILabel* descLabel = [cell.contentView viewWithTag:1000];
}

/**
 *  cell有多高
 *
 *  @param tableView tableView
 *  @param indexPath indexPath
 *
 *  @return cellHeight
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}




@end
