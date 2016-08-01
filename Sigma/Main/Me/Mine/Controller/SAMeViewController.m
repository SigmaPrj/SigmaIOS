//
//  SAMeViewController.m
//  Sigmaprj
//
//  Created by Terence on 16/7/13.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAMeViewController.h"

#import "SAMineCell.h"
#import "SAUser.h"
#import "SAMineViewEngine.h"
#import "SAMineTableViewCell.h"
#import "TextEnhance.h"
#import "SAMineSubViewController.h"
#import "SASettingViewController.h"
#import "SAMyQuestionViewController.h"

#define MINE_SETTINGS_ICON @"Mine_Settings_Gray"
#define HEIGHT_BASIC_INFO_OF_HEADER_VIEW 66

#define HEIGHT_TABBAR 49 //self.tabBar.frame.size.height为49
#define HEIGHT_NAVIGATIONBAR 64
#define HEIGHT_TABLE_HEADER_VIEW 110+HEIGHT_BASIC_INFO_OF_HEADER_VIEW
#define MARGIN 15
#define IMAGE_REC_SIZE 65




@interface SAMeViewController ()<UITableViewDataSource, UITableViewDelegate,SAMineTableViewCellDelegate>

@property(nonatomic,strong)UITableView* mineTableView;

@property(nonatomic,strong)UIView* headerView;
@property(nonatomic,strong)UIImageView* headImageViewOfHeaderView;
@property(nonatomic,strong)UILabel* userNameLabelOfHeaderView;
@property(nonatomic,strong)UILabel* vipLevelViewOfHeaderView;


@property(nonatomic,strong)UIView *basicInforOfHeaderView;
@property(nonatomic,strong)UIView *feedsView;
@property(nonatomic,strong)UIView *followView;
@property(nonatomic,strong)UIView *fansView;
@property(nonatomic,strong)UIView *creditsView;

@property(nonatomic,strong)SAUser* user;

@property(nonatomic,strong)NSArray *dataArray1;
@property(nonatomic,strong)NSArray *dataArray2;
@property(nonatomic,strong)NSArray *dataArray3;


@end

@implementation SAMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setRightNavigationItemWithTitle:nil imageName:MINE_SETTINGS_ICON];
    
    self.dataArray1 = [[SAMineViewEngine shareInstance] dataSection1];
    self.dataArray2 = [[SAMineViewEngine shareInstance] dataSection2];
    self.dataArray3 = [[SAMineViewEngine shareInstance] dataSection3];
    
    self.user = [[SAMineViewEngine shareInstance] mineGetUser];
    
    if ([self isExisted:self.dataArray1]&&[self isExisted:self.dataArray2]&&[self isExisted:self.dataArray3]) {
        [self.mineTableView reloadData];
    }
}

-(BOOL)isExisted:(NSArray*)array{
    if (array&&array.count>0) {
        return YES;
    }else{
        return NO;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initUI];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark - Initialize UI
-(void)initUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.mineTableView];
}

-(UITableView*)mineTableView{
    if (!_mineTableView) {
        _mineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-HEIGHT_TABBAR-HEIGHT_NAVIGATIONBAR) style:UITableViewStyleGrouped];
        
        _mineTableView.showsHorizontalScrollIndicator = NO;
        _mineTableView.showsVerticalScrollIndicator = YES;
        
        _mineTableView.dataSource = self;
        _mineTableView.delegate = self;
        
        _mineTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, HEIGHT_TABLE_HEADER_VIEW)];
        [_mineTableView.tableHeaderView addSubview:self.headerView];
    }
    return _mineTableView;
}


-(UIImageView*)headImageViewOfHeaderView{
    if (!_headImageViewOfHeaderView) {
        _headImageViewOfHeaderView = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN*1.5, (HEIGHT_TABLE_HEADER_VIEW-HEIGHT_BASIC_INFO_OF_HEADER_VIEW-IMAGE_REC_SIZE)/2, IMAGE_REC_SIZE, IMAGE_REC_SIZE)];
        _headImageViewOfHeaderView.image = [[UIImage imageNamed:self.user.headImageName] imageWithRenderingMode:UIImageRenderingModeAutomatic];
        
    }
    return _headImageViewOfHeaderView;
}

-(UILabel*)vipLevelViewOfHeaderView{
    if (!_vipLevelViewOfHeaderView) {
        _vipLevelViewOfHeaderView = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headImageViewOfHeaderView.frame)+MARGIN, CGRectGetMaxY(self.userNameLabelOfHeaderView.frame)+MARGIN/3, 0, 20)];
        _vipLevelViewOfHeaderView.layer.borderColor=[UIColor whiteColor].CGColor;
        _vipLevelViewOfHeaderView.layer.borderWidth=0.5;
        _vipLevelViewOfHeaderView.layer.cornerRadius=3.f;
        NSString *str=[NSString stringWithFormat:@" VIP %d  ",self.user.level];
        _vipLevelViewOfHeaderView.text=str;
        _vipLevelViewOfHeaderView.textColor=[UIColor whiteColor];
        _vipLevelViewOfHeaderView.font=[UIFont systemFontOfSize:10.f];
        _vipLevelViewOfHeaderView.textAlignment=NSTextAlignmentCenter;
        
        [TextEnhance resizeUILabelWidth:_vipLevelViewOfHeaderView];
    }
    
    
    return _vipLevelViewOfHeaderView;
}

-(UILabel*)userNameLabelOfHeaderView{
    if (!_userNameLabelOfHeaderView) {
        _userNameLabelOfHeaderView = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headImageViewOfHeaderView.frame)+MARGIN, CGRectGetMinY(self.headImageViewOfHeaderView.frame)+MARGIN, 0, 30)];
        
        [_userNameLabelOfHeaderView setFont:[UIFont boldSystemFontOfSize:16.f]];
        _userNameLabelOfHeaderView.textColor = [UIColor whiteColor];
        _userNameLabelOfHeaderView.text = self.user.userName;
        
        [TextEnhance resizeUILabelWidth:_userNameLabelOfHeaderView];
        
    }
    return _userNameLabelOfHeaderView;
}

-(UIView*)headerView{
    if (!_headerView) {
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_TABLE_HEADER_VIEW)];
        UIView* topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_TABLE_HEADER_VIEW-HEIGHT_BASIC_INFO_OF_HEADER_VIEW)];
        topView.backgroundColor = [UIColor colorWithRed:0.859 green:0.259 blue:0.251 alpha:1.000];
        
        [topView addSubview:self.headImageViewOfHeaderView];
        [topView addSubview:self.vipLevelViewOfHeaderView];
        [topView addSubview:self.userNameLabelOfHeaderView];
        
        UIImageView* headRightBtn = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30, 64, 10, 16)];
        headRightBtn.image = [[UIImage imageNamed:@"icon_cell_rightArrow"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
        
        UITapGestureRecognizer* headRightBtnGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headRightBtnClicked:)];
        [headRightBtn addGestureRecognizer:headRightBtnGesture];
        headRightBtn.userInteractionEnabled = YES;
        
        [topView addSubview:headRightBtn];
        
        [_headerView addSubview:topView];
        [_headerView addSubview:self.basicInforOfHeaderView];
    }
    return _headerView;
}

-(UIView*)basicInforOfHeaderView{
    if (_basicInforOfHeaderView==nil) {
        
        _basicInforOfHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame)-HEIGHT_BASIC_INFO_OF_HEADER_VIEW, SCREEN_WIDTH, HEIGHT_BASIC_INFO_OF_HEADER_VIEW)];
        _basicInforOfHeaderView.backgroundColor=[UIColor whiteColor];
        
        [_basicInforOfHeaderView addSubview:self.feedsView];
        [_basicInforOfHeaderView addSubview:self.followView];
        [_basicInforOfHeaderView addSubview:self.fansView];
        [_basicInforOfHeaderView addSubview:self.creditsView];
        
    }
    return _basicInforOfHeaderView;
}

-(UIView*)feedsView{
    if (_feedsView==nil) {
        
        _feedsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/4, HEIGHT_BASIC_INFO_OF_HEADER_VIEW)];
        
        UILabel* feedsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, MARGIN, SCREEN_WIDTH/4, 20)];
        feedsLabel.text = @"动态";
        feedsLabel.textAlignment=NSTextAlignmentCenter;
        feedsLabel.font=[UIFont systemFontOfSize:15.f];
        
        UILabel* numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, MARGIN+20, SCREEN_WIDTH/4, 20)];
        numLabel.text = [NSString stringWithFormat:@"%d",self.user.feeds];
        numLabel.textAlignment=NSTextAlignmentCenter;
        numLabel.font=[UIFont systemFontOfSize:15.f];
        
        UIView* seperateLineView=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4-0.5, 12, 0.5, HEIGHT_BASIC_INFO_OF_HEADER_VIEW-16)];
        seperateLineView.backgroundColor=[UIColor lightGrayColor];
        
        [_feedsView addSubview:feedsLabel];
        [_feedsView addSubview:numLabel];
        [_feedsView addSubview:seperateLineView];
        
        UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(feedsViewClicked:)];
        [_feedsView addGestureRecognizer:gesture];
        _feedsView.userInteractionEnabled = YES;
    }
    return _feedsView;
}


-(UIView*)followView{
    if (!_followView) {
        _followView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4, 0, SCREEN_WIDTH/4, HEIGHT_BASIC_INFO_OF_HEADER_VIEW)];
        
        UILabel* followLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, MARGIN, SCREEN_WIDTH/4, 20)];
        followLabel.text = @"关注";
        followLabel.textAlignment=NSTextAlignmentCenter;
        followLabel.font=[UIFont systemFontOfSize:15.f];
        
        UILabel* numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, MARGIN+20, SCREEN_WIDTH/4, 20)];
        numLabel.text = [NSString stringWithFormat:@"%d",self.user.numberOfFollowers];
        numLabel.textAlignment=NSTextAlignmentCenter;
        numLabel.font=[UIFont systemFontOfSize:15.f];
        
        UIView* seperateLineView=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4-0.5, 12, 0.5, HEIGHT_BASIC_INFO_OF_HEADER_VIEW-16)];
        seperateLineView.backgroundColor=[UIColor lightGrayColor];
        
        [_followView addSubview:followLabel];
        [_followView addSubview:numLabel];
        [_followView addSubview:seperateLineView];
        
        UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(followViewClicked:)];
        [_followView addGestureRecognizer:gesture];
        _followView.userInteractionEnabled = YES;
        
    }
    return _followView;
}

-(UIView*)fansView{
    if (!_fansView) {
        _fansView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/4, HEIGHT_BASIC_INFO_OF_HEADER_VIEW)];
        
        UILabel* followLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, MARGIN, SCREEN_WIDTH/4, 20)];
        followLabel.text = @"粉丝";
        followLabel.textAlignment=NSTextAlignmentCenter;
        followLabel.font=[UIFont systemFontOfSize:15.f];
        
        UILabel* numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, MARGIN+20, SCREEN_WIDTH/4, 20)];
        numLabel.text = [NSString stringWithFormat:@"%d",self.user.numberOfFans];
        numLabel.textAlignment=NSTextAlignmentCenter;
        numLabel.font=[UIFont systemFontOfSize:15.f];
        
        UIView* seperateLineView=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4-0.5, 12, 0.5, HEIGHT_BASIC_INFO_OF_HEADER_VIEW-16)];
        seperateLineView.backgroundColor=[UIColor lightGrayColor];
        
        [_fansView addSubview:followLabel];
        [_fansView addSubview:numLabel];
        [_fansView addSubview:seperateLineView];
        
        UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fansViewClicked:)];
        [_fansView addGestureRecognizer:gesture];
        _fansView.userInteractionEnabled = YES;
        
    }
    return _fansView;
}

-(UIView*)creditsView{
    if (!_creditsView) {
        _creditsView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*3/4, 0, SCREEN_WIDTH/4, HEIGHT_BASIC_INFO_OF_HEADER_VIEW)];
        
        UILabel* creditsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, MARGIN, SCREEN_WIDTH/4, 20)];
        creditsLabel.text = @"积分";
        creditsLabel.textAlignment=NSTextAlignmentCenter;
        creditsLabel.font=[UIFont systemFontOfSize:15.f];
        
        UILabel* numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, MARGIN+20, SCREEN_WIDTH/4, 20)];
        numLabel.text = [NSString stringWithFormat:@"%d",self.user.credits];
        numLabel.textAlignment=NSTextAlignmentCenter;
        numLabel.font=[UIFont systemFontOfSize:15.f];
        
        [_creditsView addSubview:creditsLabel];
        [_creditsView addSubview:numLabel];
        
        UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(creditsViewClicked:)];
        [_creditsView addGestureRecognizer:gesture];
        _creditsView.userInteractionEnabled = YES;
        
    }
    return _creditsView;
}



#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            return [self.dataArray1 count];
        }
            break;
        case 1:
        {
            return [self.dataArray2 count];
        }
            break;
        case 2:
        {
            return [self.dataArray3 count];
        }
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellIndentifier = @"minecell";
    
    SAMineTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (!cell) {
        cell = [[SAMineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        
        cell.delegate = self;
    }
    
    if(indexPath.section == 0){
        SAMineCell* cellSection = (SAMineCell*)[self.dataArray1 objectAtIndex:indexPath.row];
        SAMineCell* data = [[SAMineCell alloc] init];
        
        data.title = cellSection.title;
        data.additionInfo = cellSection.additionInfo;
        
        cell.data = data;
        
        [cell showMineCell];
    }else if (indexPath.section == 1){
        SAMineCell* cellSection = (SAMineCell*)[self.dataArray2 objectAtIndex:indexPath.row];
        SAMineCell* data = [[SAMineCell alloc] init];
        
        data.title = cellSection.title;
        data.additionInfo = cellSection.additionInfo;
        
        cell.data = data;
        
        [cell showMineCell];
    }else if (indexPath.section == 2){
        SAMineCell* cellSection = (SAMineCell*)[self.dataArray3 objectAtIndex:indexPath.row];
        SAMineCell* data = [[SAMineCell alloc] init];
        
        data.title = cellSection.title;
        data.additionInfo = cellSection.additionInfo;
        
        cell.data = data;
        
        [cell showMineCell];
    }
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

#pragma mark- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
            {
                SAMineSubViewController *vc=[[SAMineSubViewController alloc]init];
                vc.titleLabel=@"我的赛事";
                [vc setHidesBottomBarWhenPushed:YES];
                
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                SAMineSubViewController *vc=[[SAMineSubViewController alloc]init];
                vc.titleLabel=@"我的课程";
                [vc setHidesBottomBarWhenPushed:YES];
                
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                SAMyQuestionViewController *vc=[[SAMyQuestionViewController alloc]init];
                [vc setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:
            {
                SAMineSubViewController *vc=[[SAMineSubViewController alloc]init];
                vc.titleLabel=@"我的消息";
                [vc setHidesBottomBarWhenPushed:YES];
                
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }else if (indexPath.section==1){
        switch (indexPath.row) {
            case 0:
            {
                
            }
                break;
            case 1:
            {
                
            }
                break;
            default:
                break;
        }
        
    }else if (indexPath.section==2){
        switch (indexPath.row) {
            case 0:
            {
                
                SASettingViewController *vc=[[SASettingViewController alloc]init];
                
                [vc setHidesBottomBarWhenPushed:YES];
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
            default:
                break;
        }
        
    }
    
    
    
    
}

/**
 *  section中header的高度
 *
 *  @param tableView
 *  @param section   <#section description#>
 *
 *  @return <#return value description#>
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 16;
    }
    return 8;
}

/**
 *  section中footer的高度
 *
 *  @param tableView <#tableView description#>
 *  @param section   <#section description#>
 *
 *  @return <#return value description#>
 */
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==2) {
        return 16;
    }
    return 8;
}

/**
 *  cell中每行的高度
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

#pragma mark - Click/Tap Event

-(void)feedsViewClicked:(id)sender{
    if (sender && [sender isKindOfClass:[UITapGestureRecognizer class]]) {
        NSLog(@"feedsViewClicked");
    }
}

-(void)followViewClicked:(id)sender{
    if (sender && [sender isKindOfClass:[UITapGestureRecognizer class]]) {
        NSLog(@"followViewClicked");
    }
}

-(void)fansViewClicked:(id)sender{
    if (sender && [sender isKindOfClass:[UITapGestureRecognizer class]]) {
        NSLog(@"fansViewClicked");
    }
}

-(void)creditsViewClicked:(id)sender{
    if (sender && [sender isKindOfClass:[UITapGestureRecognizer class]]) {
        NSLog(@"creditsViewClicked");
    }
}

-(void)headRightBtnClicked:(id)sender{
    if (sender && [sender isKindOfClass:[UITapGestureRecognizer class]]) {
        NSLog(@"headRightBtnClicked");
    }
}

-(void)rightItemTapped{
    SASettingViewController *vc=[[SASettingViewController alloc]init];
    
    [vc setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
