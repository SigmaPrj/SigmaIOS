//
//  MainPageTableCell.h
//  Sigma
//
//  Created by 韩佳成 on 16/7/27.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainPageCellInfo;

@interface MainPageTableCell : UITableViewCell

//控件内容类的对象
@property(nonatomic,strong)MainPageCellInfo* mainPageCellInfo;

/*
 
 获得cell中控件的内容
 
 */
-(void)showMainPageViewCell;

@end
