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
#import "VideoOfCourseController.h"

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

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[CourseEngine shareInstances] removeAllNotification];
    [self removeAllNotification];
}

-(void)initUI{
    self.title = @"课程";
    [self.view addSubview:self.mainPagetableView];
    [self.mainPagetableView.tableHeaderView addSubview:self.headView];
//    //去掉cell之间的分隔线
//    self.mainPagetableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [CourseEngine shareInstances];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:COURSE_MAINPAGE_DATA object:nil];
    
    self.cellDataArray = [[[CourseEngine shareInstances] cellWithData] mutableCopy];
//    if(self.cellDataArray && self.cellDataArray.count>0){
//        [self.mainPagetableView reloadData];
//    }
    
    [self addNofitification];
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
        _mainPagetableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-140*(SCREEN_WIDTH/SCREEN_HEIGHT)) style:UITableViewStylePlain];
        
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

//添加从engine回到主线程更新UI的通知
-(void)addNofitification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(courseReceiveSuccessData:) name:COURSE_MAINPAGE_MAINQUEUE_DATA object:nil];
}

//通知方法的实现
-(void)courseReceiveSuccessData:(NSNotification*)noti{
    if([noti.name isEqualToString:COURSE_MAINPAGE_MAINQUEUE_DATA]){
        self.cellDataArray = [[[CourseEngine shareInstances] cellWithData] mutableCopy];
        if(self.cellDataArray && self.cellDataArray.count>0){
            [self.mainPagetableView reloadData];
        }

    }
}

//移除通知
-(void)removeAllNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
            mainPageCellInfo.descriptionOfCourse = mainPageCellModel.descriptionOfCourse;
            mainPageCellInfo.headImageName = mainPageCellModel.headImageName;
            mainPageCellInfo.nickname = mainPageCellModel.nickname;
            mainPageCellInfo.city = mainPageCellModel.city;
            mainPageCellInfo.courseVideoUrlPath = mainPageCellModel.courseVideoUrlPath;
            
            cell.mainPageCellInfo = mainPageCellInfo;
            [cell showMainPageViewCell];
            self.mainPagetableView.rowHeight = CELL_HEIGHT;
        }
    }
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoOfCourseController* videoOfCourseController = [[VideoOfCourseController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:videoOfCourseController animated:YES];
    
    //获取当前点击的cell
    UITableViewCell *cell = [self.mainPagetableView cellForRowAtIndexPath:indexPath];
    //通过组件的tag，在cell上获取对应的组件
    UILabel* courseNameLabel = [cell.contentView viewWithTag:1000];
    UILabel* courseDescriptionLabel = [cell.contentView viewWithTag:2000];
    UILabel* headImageLabel = [cell.contentView viewWithTag:3000];
    UILabel* authorNameLabel = [cell.contentView viewWithTag:4000];
    UILabel* authorCityLabel = [cell.contentView viewWithTag:5000];
    UILabel* videoInfoLabel = [cell.contentView viewWithTag:6000];
    
    //将数据传到engine层
    [[CourseEngine shareInstances] getDataFromIntroductionView:courseNameLabel.text andDescription:courseDescriptionLabel.text];
    
    [[CourseEngine shareInstances] getDataFromAuthorInfoView:headImageLabel.text andAuthorName:authorNameLabel.text andAuthorCity:authorCityLabel.text];
    
    [[CourseEngine shareInstances] getDataFromVideo:videoInfoLabel.text];
}


@end
