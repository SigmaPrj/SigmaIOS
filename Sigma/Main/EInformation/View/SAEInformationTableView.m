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
        self.delegate = self;
        
        // 不要cell间的分割线
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
//        [self initData];
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


//-(void)initData{
//    NSDictionary* dict1 = @{
//                            @"desc":@"第八届全国大学生数学竞赛",
//                            @"mainImgName":@"competition1.png",
//                            @"number":@"198"
//                            };
//    
//    
//    NSDictionary* dict2 = @{
//                            @"desc":@"2016携程云海大数据算法竞赛",
//                            @"mainImgName":@"competition2.png",
//                            @"number":@"2000"
//                            };
//    
//    NSDictionary* dict3 = @{
//                            @"desc":@"全国大学生数学建模竞赛",
//                            @"mainImgName":@"competition3.png",
//                            @"number":@"10000"
//                            };
//    
//    NSDictionary* dict4 = @{
//                            @"desc":@"\"华为杯\"东南大学第12届大学生程序设计大赛",
//                            @"mainImgName":@"competition6.png",
//                            @"number":@"100"
//                            };
//    
//    
//    NSDictionary* dict5 = @{
//                            @"desc":@"2016年第12届百度之星编程大赛",
//                            @"mainImgName":@"competition5.png",
//                            @"number":@"2000"
//                            };
//    
//    NSDictionary* dict6 = @{
//                            @"desc":@"2016年第五届软件杯设计大赛选拔赛",
//                            @"mainImgName":@"competition4.png",
//                            @"number":@"2000"
//                            };
//
//    
//    NSArray* dictArray = @[dict1, dict2, dict3, dict4, dict5, dict6];
//    
//    NSMutableArray* modelArray = [[NSMutableArray alloc]init];
//    
//    for (int i = 0; i < dictArray.count; i++) {
//        SAEInformationModel* saModel = [[SAEInformationModel alloc]initWithDict:dictArray[i]];
//        [modelArray addObject:saModel];
//    }
//    
//    [self.datas addObjectsFromArray:@[modelArray]];
//}


-(void)initData:(NSArray*)dictArray{
    
//    NSLog(@"%@",dictArray);
    NSMutableArray* modelArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < dictArray.count; i++) {
        SAEInformationModel* saModel = [[SAEInformationModel alloc]initWithDict:dictArray[i]];
        [modelArray addObject:saModel];
    }
    [self.datas removeAllObjects];
    
    [self.datas addObjectsFromArray:@[modelArray]];
    

}



#pragma mark - 
#pragma mark UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

/**
 *  cell有多高
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
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
    
    SAEInformationModel* cdata = (SAEInformationModel*)[self.datas[(NSUInteger)section] objectAtIndex:(NSUInteger)index];
    
    SAEInformationCell *infocell = [[SAEInformationCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    
    [infocell setData:cdata];
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
