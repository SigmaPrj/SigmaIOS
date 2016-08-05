//
//  SAMyDetailQuestionViewController.m
//  Sigma
//
//  Created by Ace Hsieh on 8/5/16.
//  Copyright © 2016 sigma. All rights reserved.
//

#import "SAMyDetailQuestionViewController.h"
#import "SAMyDetailQuestionHeadView.h"
#import "SAMyDetailQuestionData.h"
#import "SAMyDetailQuestionTableViewCell.h"
#import "SAMyDetailQuestionEngine.h"


@interface SAMyDetailQuestionViewController ()<SAMyDetailQuestionTableViewCellDelegate,UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong)SAMyDetailQuestionHeadView *headView;
@property(nonatomic,strong)UITableView *tv;
@property(nonatomic,strong)NSArray* dataArray;

@end

@implementation SAMyDetailQuestionViewController

- (void)viewDidLoad {
    [self initUI];
    [super viewDidLoad];
    [self setLeftNavigationItemWithTitle:nil imageName:@"back.png"];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed = NO;
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.tv];
    
    self.dataArray = [[[SAMyDetailQuestionEngine shareInstance] homeDetailPageWithData] mutableCopy];
    
    if (self.dataArray && self.dataArray.count>0) {
        [self.tv reloadData];
    }
    
    UIImageView *grayLogoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sigma"]];
    grayLogoImageView.frame = CGRectMake((self.view.frame.size.width - 65) / 2.0, 20, 65, 65);
    [self.view insertSubview:grayLogoImageView atIndex:0];
    
}

/**
 *  初始化tableView的header的View
 *
 *  @return ;
 */
-(SAMyDetailQuestionHeadView*)headView{
    if (_headView == nil) {
        _headView = [[SAMyDetailQuestionHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    }
    return _headView;
}

-(UITableView*)tv{
    if(_tv == nil){
        _tv = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tv.backgroundColor = [UIColor colorWithRed:235/255. green:235/255. blue:241/255. alpha:1.0];
        _tv.delegate = self;
        _tv.dataSource = self;
        _tv.bounces=YES;
        _tv.showsVerticalScrollIndicator = NO;
        _tv.separatorStyle=UITableViewCellSeparatorStyleSingleLine;//分割线
        
        _tv.tableHeaderView = self.headView;
        
        [_tv setSeparatorColor:[UIColor whiteColor]];
        
    }
    
    return _tv;
}

#pragma mark - TableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:_tv cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row==[self.dataArray count]-1) {
        return cell.frame.size.height+100;

    }
    
    return cell.frame.size.height;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIndentifier = @"homeDetailCell";
    
    SAMyDetailQuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell == nil) {
        cell = [[SAMyDetailQuestionTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIndentifier];
    }
    
    if ((indexPath.row >=0) && (indexPath.row < self.dataArray.count)) {
        
        SAMyDetailQuestionData* cellSection = (SAMyDetailQuestionData*)[self.dataArray objectAtIndex:indexPath.row];
        
        SAMyDetailQuestionData* data = [[SAMyDetailQuestionData alloc] init];
        data.text = cellSection.text ;
        data.imageName = cellSection.imageName;
        
        cell.data = data;
        [cell showMyDetailQuestionCell];
    }
    
    return cell;
}


@end
