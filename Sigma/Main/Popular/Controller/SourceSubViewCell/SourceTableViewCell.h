//
//  SourceTableViewCell.h
//  Sigma
//
//  Created by 韩佳成 on 16/7/17.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SourceMainPageInfo;


@interface SourceTableViewCell : UITableViewCell

@property(nonatomic,strong)SourceMainPageInfo* sourceMainPageInfo;

//将cell中的数据显示出来
-(void)showSourceCell;

@end
