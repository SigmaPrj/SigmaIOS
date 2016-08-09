//
//  CategoryViewCell.h
//  Sigma
//
//  Created by 韩佳成 on 16/7/19.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CategoryDataInfo;

@interface CategoryViewCell : UITableViewCell

@property(nonatomic,strong)CategoryDataInfo* categoryInfor;

//将cell中的内容显示出来
-(void)showCategoryCell;

@end
