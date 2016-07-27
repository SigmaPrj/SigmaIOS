//
//  SAPopularTableView.m
//  Sigma
//
//  Created by Terence on 16/7/14.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAPopularTableView.h"
#import "SAPopularHeaderView.h"
#import "SAPopularCell.h"
#import "SAPopularModel.h"
#import "SAPopularClassCell.h"
#import "SAPopularResourceCell.h"
#import "SAPopularEventCell.h"

#define HEADERVIEW_HEIGHT (280)
@interface SAPopularTableView ()

//@property (nonatomic, strong)

// 数据

@property (nonatomic, strong) SAPopularHeaderView* headerView;


@end

@implementation SAPopularTableView



/**
 *  重写Init方法
 *
 *  @param frame <#frame description#>
 *  @param style <#style description#>
 *
 *  @return <#return value description#>
 */
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        
        self.backgroundColor = COLOR_RGB(245, 245, 245);
        
        self.minimumZoomScale = 1.0;
        self.maximumZoomScale = 1.0;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        // 不要cell间的分割线
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableHeaderView = self.headerView;
        
    }
    
    return self;
}



-(SAPopularHeaderView*)headerView{
    if (!_headerView) {
        _headerView = [[SAPopularHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEADERVIEW_HEIGHT)];        
    }
    
    return _headerView;
}




@end
