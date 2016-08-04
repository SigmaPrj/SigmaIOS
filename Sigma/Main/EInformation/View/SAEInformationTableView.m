//
//  SAEInformationTableView.m
//  Sigma
//
//  Created by Terence on 16/7/18.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAEInformationTableView.h"
#import "SAEInformationCell.h"
#import "SAEInformationModel.h"
#import "EInformationTopBarView.h"
#import "SAEinfoDetailViewController.h"
#import "SAEInfoDetailModel.h"


@interface SAEInformationTableView () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSMutableArray* datas;

@end

@implementation SAEInformationTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        self.backgroundColor = COLOR_RGB(245, 245, 245);
        
        self.minimumZoomScale = 1.0;
        self.maximumZoomScale = 1.0;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        self.dataSource = self;

        
        // 不要cell间的分割线
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return self;
}

-(NSMutableArray*)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
//        _datas = self.data;
    }
    
    return _datas;
}


/**
 *  初始化数据
 *
 *  @param dictArray <#dictArray description#>
 */
//-(void)initData:(NSArray*)dictArray{
//    
//
//    NSMutableArray* modelArray = [[NSMutableArray alloc]init];
//    
//    for (int i = 0; i < dictArray.count; i++) {
//        SAEInformationModel* saModel = [[SAEInformationModel alloc]initWithDict:dictArray[i]];
//        [modelArray addObject:saModel];
//    }
//    [self.datas removeAllObjects];
//    
//    [self.datas addObjectsFromArray:@[modelArray]];
//    
//
//}

-(void)initData:(NSArray*)dictArray{
    
    
    NSMutableArray* modelArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < dictArray.count; i++) {
        SAEInfoDetailModel * saModel = [[SAEInfoDetailModel alloc]initWithDict:dictArray[(NSInteger)i]];
        [modelArray addObject:saModel];
    }
    [self.datas removeAllObjects];
    
    [self.datas addObjectsFromArray:@[modelArray]];
    
    
}



#pragma mark - 
#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.datas[(NSInteger)section] count];
//    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSInteger section = indexPath.section;
    NSInteger index = indexPath.row;
    
//    SAEInformationModel* cdata = (SAEInformationModel*)[self.datas[(NSUInteger)section] objectAtIndex:(NSUInteger)index];
    
    SAEInfoDetailModel* model = (SAEInfoDetailModel*)[self.datas[(NSUInteger)section] objectAtIndex:(NSUInteger) index];
    
    SAEInformationCell *infocell = [[SAEInformationCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    
//    [infocell setData:cdata];
    
    [infocell setDetailModel:model];
    cell = [infocell initUI];
    
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}




@end
