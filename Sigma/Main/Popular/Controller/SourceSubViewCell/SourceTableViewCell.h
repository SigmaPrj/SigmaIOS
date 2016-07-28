//
//  SourceTableViewCell.h
//  Sigma
//
//  Created by 韩佳成 on 16/7/17.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SourceInfo;


@interface SourceTableViewCell : UITableViewCell

@property(nonatomic,strong)SourceInfo* dataInfo;

//将cell中的数据显示出来
-(void)showSourceCell;

@end
