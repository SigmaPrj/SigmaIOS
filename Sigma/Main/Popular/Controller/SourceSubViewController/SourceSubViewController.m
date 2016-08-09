//
//  SourceSubViewController.m
//  Sigma
//
//  Created by 韩佳成 on 16/7/14.
//  Copyright © 2016年 Terence. All rights reserved.
//

/*
 
 headview里面的collectionview  section的个数  需要从后台中进行拉去设置，并且每个item的内容也要从后天去拉去
 
 */





#import "SourceSubViewController.h"
#import "Masonry.h"
#import "SourceHeadView.h"
#import "SourceCommonDefine.h"
#import "SourceTableViewCell.h"
#import "SourceEngineInterface.h"
#import "SourceInfo.h"
#import "CategoryViewController.h"
#import "ContentOfSourceViewController.h"
#import "SourceEngineInterface.h"
#import "SourceMainPageInfo.h"
#import "SearchViewOfCategoryController.h"




@interface SourceSubViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView* tableView;

@property(nonatomic,strong)SourceHeadView* headView;

@property(nonatomic,strong)NSMutableArray* dataArray;

@end

@implementation SourceSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createNavigationRightButton];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[SourceEngineInterface shareInstances] removeAllNotification];
    [self removeAllNotification];
}


-(void)initUI{
    self.title = @"资源";
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = self.headView;
    [SourceEngineInterface shareInstances];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_RESOURCE_MAINPAGE_DATA object:nil];
    self.dataArray = [[[SourceEngineInterface shareInstances] sourcePageWithData] mutableCopy];

    [self addAllNotification];
}

/*
 
 difine the headview of self
 
 */

-(SourceHeadView*)headView{
    if(_headView == nil){
        _headView = [[SourceHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEADVIEW_HEIGHT)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        _headView.layer.borderWidth = 1;
        _headView.layer.borderColor = [COLOR_RGB(204, 204, 204) CGColor];
    }
    return _headView;
}


-(UITableView*)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-160*(SCREEN_WIDTH/SCREEN_HEIGHT)) style: UITableViewStylePlain];
        
        _tableView.backgroundColor = [UIColor clearColor];
        
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        
        //取消分割线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
    }
    return _tableView;
}

//创建右上角分类按钮
-(void)createNavigationRightButton{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"putongjieguo.png" ] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]style:UIBarButtonItemStylePlain target:self action:@selector(rightNavigationBarClicked:)];
}

//实现那 navigation上右边按钮的事件
-(void)rightNavigationBarClicked:(id)sender{
    if(sender && [sender isKindOfClass:[UIBarButtonItem class]]){
         self.hidesBottomBarWhenPushed = YES;
        SearchViewOfCategoryController* searchViewOfCategoryController = [[SearchViewOfCategoryController alloc] init];
        [self.navigationController pushViewController:searchViewOfCategoryController animated:YES];
//        CategoryViewController* categoryViewController = [[CategoryViewController alloc] init];
//        [self.navigationController pushViewController:categoryViewController animated:YES];
    }
}


//添加主线程数据的通知
-(void)addAllNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resourceReceiveSuccessData:) name:NOTI_RESOURCE_MAINPAGE_MAINQUEUE_DATA object:nil];
}

//通知方法实现
-(void)resourceReceiveSuccessData:(NSNotification*)noti{
    if([noti.name isEqualToString:NOTI_RESOURCE_MAINPAGE_MAINQUEUE_DATA]){
        
        self.dataArray = [[[SourceEngineInterface shareInstances] sourcePageWithData] mutableCopy];
        
        if(self.dataArray && self.dataArray.count>0){
            [self.tableView reloadData];
        }
    }
}

//移除通知
-(void)removeAllNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITableViewDataSource

//返回cell的个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellIdentifier = @"mycell";
    SourceTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell){
        cell = [[SourceTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        if((indexPath.row>=0) && (indexPath.row < self.dataArray.count)){
            SourceMainPageInfo* sourceMainPageInfo = (SourceMainPageInfo*)[self.dataArray objectAtIndex:indexPath.row];
            NSLog(@"%@",sourceMainPageInfo.title);
            
            cell.sourceMainPageInfo = sourceMainPageInfo;
            [cell showSourceCell];
            self.tableView.rowHeight = CELL_HEIGHT;
        }

    }
    
    return cell;
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ContentOfSourceViewController* contentViewController = [[ContentOfSourceViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:contentViewController animated:YES];
    //获取当前点击的cell
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    //通过组件的tag，在cell上获取对应的组件
    UILabel* cellNameLabel = [cell.contentView viewWithTag:1000];
    UILabel* cellDescription = [cell.contentView viewWithTag:2000];
    UILabel* supportNumber = [cell.contentView viewWithTag:3000];
    UILabel* downloadNumber = [cell.contentView viewWithTag:4000];
    
    //将数据传到engine层
    [[SourceEngineInterface shareInstances] getDataFromView:cellNameLabel.text andSupportNumber:supportNumber.text andDownloadNumber:downloadNumber.text andDescription:cellDescription.text];
    
}


@end
