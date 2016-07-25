//
//  SASettingViewController.m
//  Sigma
//
//  Created by Ace Hsieh on 7/25/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import "SASettingViewController.h"
#import "SASettingViewEngine.h"
#import "SASettingTableViewCell.h"
#import "SASettingCell.h"

#import "SASettingAboutViewController.h"

#define MINE_SETTINGS_ICON @"Mine_Settings_Gray"
#define HEIGHT_BASIC_INFO_OF_HEADER_VIEW 66

#define HEIGHT_TABBAR 49 //self.tabBar.frame.size.height为49
#define HEIGHT_NAVIGATIONBAR 44
#define HEIGHT_TABLE_HEADER_VIEW 110+HEIGHT_BASIC_INFO_OF_HEADER_VIEW
#define MARGIN 15
#define IMAGE_REC_SIZE 65

@interface SASettingViewController ()<UITableViewDataSource, UITableViewDelegate,SASettingTableViewCellDelegate>

@property(nonatomic,strong)UITableView* settingTableView;

@property(nonatomic,strong)NSArray *dataArray1;
@property(nonatomic,strong)NSArray *dataArray2;
@property(nonatomic,strong)NSArray *dataArray3;

@property(nonatomic,strong)UIView *footerView;
@property(nonatomic,strong)UIButton *exitButton;

@end

@implementation SASettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataArray1 = [[SASettingViewEngine shareInstance] dataSection1];
    self.dataArray2 = [[SASettingViewEngine shareInstance] dataSection2];
    self.dataArray3 = [[SASettingViewEngine shareInstance] dataSection3];
    
    if ([self isExisted:self.dataArray1]&&[self isExisted:self.dataArray2]&&[self isExisted:self.dataArray3]) {
        [self.settingTableView reloadData];
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

    self.view.backgroundColor=[UIColor colorWithWhite:0.969 alpha:1.000];

    [self initUI];
    self.title=@"设置";
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark - Initialize UI
-(void)initUI{
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.view addSubview:self.settingTableView];
}

-(UITableView*)settingTableView{
    if (!_settingTableView) {
        _settingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-HEIGHT_NAVIGATIONBAR) style:UITableViewStyleGrouped];
        
        _settingTableView.showsHorizontalScrollIndicator = NO;
        _settingTableView.showsVerticalScrollIndicator = YES;
        
        _settingTableView.dataSource = self;
        _settingTableView.delegate = self;
        
        
        _settingTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_NAVIGATIONBAR)];
        [_settingTableView.tableFooterView addSubview:self.footerView];
        
    }
    return _settingTableView;
}

-(UIView*)footerView{
    if (!_footerView) {
        
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_NAVIGATIONBAR)];
//        _footerView.backgroundColor=[UIColor redColor];
        
        [_footerView addSubview:self.exitButton];
    }
    return _footerView;
}

- (UIButton*)exitButton{
    if (!_exitButton) {
        
        _exitButton = [[UIButton alloc] initWithFrame:CGRectMake(MARGIN,0, SCREEN_WIDTH-MARGIN*2, HEIGHT_NAVIGATIONBAR)];
        _exitButton.backgroundColor=[UIColor colorWithRed:1.000 green:0.400 blue:0.400 alpha:1.000];
        
        _exitButton.layer.borderColor = [UIColor colorWithRed:1.000 green:0.400 blue:0.400 alpha:1.000].CGColor;
        _exitButton.layer.borderWidth = 2;
        _exitButton.layer.cornerRadius = 20;

        [_exitButton setTitle:@"退出" forState:UIControlStateNormal];
        [_exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_exitButton addTarget:self action:@selector(exitBtnClickHandler:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _exitButton;
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
    static NSString* cellIndentifier = @"mycell";
    
    SASettingTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (!cell) {
        cell = [[SASettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        
        cell.delegate = self;
    }
    
    if(indexPath.section == 0){
        SASettingCell* cellSection = (SASettingCell*)[self.dataArray1 objectAtIndex:indexPath.row];
        SASettingCell* data = [[SASettingCell alloc] init];
        
        data.title = cellSection.title;
        data.additionInfo = cellSection.additionInfo;
        
        cell.data = data;
        
        [cell showMineCell];
    }else if (indexPath.section == 1){
        SASettingCell* cellSection = (SASettingCell*)[self.dataArray2 objectAtIndex:indexPath.row];
        SASettingCell* data = [[SASettingCell alloc] init];
        
        data.title = cellSection.title;
        data.additionInfo = cellSection.additionInfo;
        
        cell.data = data;
        
        [cell showMineCell];
    }else if (indexPath.section == 2){
        SASettingCell* cellSection = (SASettingCell*)[self.dataArray3 objectAtIndex:indexPath.row];
        SASettingCell* data = [[SASettingCell alloc] init];
        
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
                
                
                
            }
                break;
            case 1:
            {
                
            }
                break;
            case 2:
            {
                SASettingAboutViewController *vc=[[SASettingAboutViewController alloc]init];
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

- (void)exitBtnClickHandler:(id)sender {
    if (sender && [sender isKindOfClass:[UIButton class]]) {
        
        
    }
}

@end

