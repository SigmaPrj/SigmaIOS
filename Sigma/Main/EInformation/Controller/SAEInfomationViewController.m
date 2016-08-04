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
#import "SAEInfoNewsRequest.h"
#import "JCAlertView.h"
#import "SVProgressHUD.h"

#define COMMUNITY_BOTTOM 64

@interface SAEInfomationViewController () <EInformationTopBarViewDelegate, UITableViewDelegate>

@property (nonatomic, strong)SAEInformationTableView* tableView;
@property (nonatomic, strong)EInformationTopBarView* topbarview;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSMutableArray *newsTypeArray;
@property(nonatomic, strong) NSMutableArray* datas;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, assign) BOOL firstRequest;

@end

@implementation SAEInfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [SAEInfoNewsRequest requestEInfoNews:1];
    
    [self initUI];
    
    [self initData];
    
    self.firstRequest = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // 添加通知
    [self addAllNotification];
    
    [self sendRequest];
    // 开始显示加载动画
//        [self startLoading];
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
    [self.view addSubview:self.maskView];
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
    
    
    
//    [SAEInfoNewsRequest requestEInfoNews:2];
//
//    [SAEInfoNewsRequest requestEInfoNews:3];
//
//    [SAEInfoNewsRequest requestEInfoNews:4];
//
//    [SAEInfoNewsRequest requestEInfoNews:5];

    
    
}

#pragma mark - 添加notinewstype通知
-(void) addNewsTypeNoti{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataSuccessHandler:) name:NOTI_EINFORMATION_NEWSTYPE object:nil];
}

#pragma mark - 添加通知
- (void) addAllNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataSuccessHandler:) name:NOTI_EINFORMATION_NEWSTYPE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataSuccessHandler:) name:NOTI_EINFORMATION_NEWSDETAIL object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataErrorHandler:) name:REQUEST_DATA_ERROR object:nil];
}

#pragma mark - 移除通知
-(void) removeAllNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)receiveDataSuccessHandler:(NSNotification *)noti{
    if ([noti.name isEqualToString:NOTI_EINFORMATION_NEWSTYPE]) {
        if ([noti.userInfo[@"status"] intValue] == 1) {
            // 资讯种类加载成功
            [self setNewsTypeData:noti.userInfo[@"data"]];
            
        }
    }
    if ([noti.name isEqualToString:NOTI_EINFORMATION_NEWSDETAIL]) {
        if ([noti.userInfo[@"status"] intValue] == 1) {
            
            NSLog(@"详情加载成功");
            [self.tableView initData:noti.userInfo[@"data"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
//                self.firstRequest = NO;
                [self deleteMaskView];
            });
            
        }
    }
}

- (void) receiveDataErrorHandler:notification {
    [self alert:@"数据加载失败" message:@"网络好像出现了问题，请检查网络后再试！~"];
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
    }
 
    [self.view addSubview:self.topbarview];

}


#pragma mark - EInformationTopBarViewDelegate
-(void)btnClickedWithTag:(int)tag{
    NSLog(@"%d",tag);
    if (tag == 1000) {
        [SAEInfoNewsRequest requestEInfoNews:(tag - 999)];
        [self startLoading];
        
    }else if (tag == 1001) {
        [SAEInfoNewsRequest requestEInfoNews:(tag - 999)];
        [self startLoading];
        
    }else if (tag == 1002){
        
        [SAEInfoNewsRequest requestEInfoNews:(tag - 999)];
        [self startLoading];
       
    }else if(tag == 1003){
        [SAEInfoNewsRequest requestEInfoNews:(tag - 999)];
        [self startLoading];
        
    }else if (tag == 1004){
        [SAEInfoNewsRequest requestEInfoNews:(tag - 999)];
        [self startLoading];
       
    }else if(tag == 1005){
        
        [SAEInfoNewsRequest requestEInfoNews:(tag - 999)];
        [self startLoading];
        
    }else if(tag == 1006){
        
        [SAEInfoNewsRequest requestEInfoNews:(tag - 999)];
        [self startLoading];
        
    }else if(tag == 1007){
        
        [SAEInfoNewsRequest requestEInfoNews:(tag - 999)];
        [self startLoading];
        
    }else if(tag == 1008){
        
        [SAEInfoNewsRequest requestEInfoNews:(tag - 999)];
        [self startLoading];
        
    }else if(tag == 1009){
        
        [SAEInfoNewsRequest requestEInfoNews:(tag - 999)];
        [self startLoading];
        
    }
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SAEinfoDetailViewController* detailvc = [[SAEinfoDetailViewController alloc]init];
    detailvc.currectIndex = (int)indexPath.row;
    NSLog(@"%lu", indexPath.row);
    
    detailvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailvc animated:YES];
    
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    UILabel* descLabel = [cell.contentView viewWithTag:2000];
    
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

- (void)alert:(NSString *)title message:(NSString *)msg {
    __weak typeof(self) weakSelf = self;
    [JCAlertView showTwoButtonsWithTitle:title Message:msg ButtonType:JCAlertViewButtonTypeCancel ButtonTitle:@"算了" Click:^{
        [weakSelf deleteMaskView];
    } ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"重试" Click:^{
        [weakSelf sendRequest];
    }];
}

- (void)deleteMaskView {
    [self endLoading];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.3 animations:^{
        weakSelf.maskView.alpha = 0;
    } completion:^(BOOL finished) {
        // 删除视图
        [weakSelf.maskView removeFromSuperview];
    }];
}

- (void)startLoading {
    [SVProgressHUD show];
}

- (void)endLoading {
    [SVProgressHUD dismiss];
}


- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT-COMMUNITY_BOTTOM))];
        _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    }
    return _maskView;
}

@end
