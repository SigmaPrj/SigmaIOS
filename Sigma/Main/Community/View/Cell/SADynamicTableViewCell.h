//
//  SADynamicTableViewCell.h
//  Sigma
//
//  Created by 汤轶侬 on 16/7/26.
//  Copyright (c) 2016 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SADynamicFrameModel;
@class SADynamicModel;
@class SADynamicTableViewCell;

@protocol SADynamicTableViewCellDelegate<NSObject>

@required
- (void)commentBtnDidClicked:(SADynamicTableViewCell *)tableViewCell;

@end

@interface SADynamicTableViewCell : UITableViewCell

@property (nonatomic, strong) SADynamicFrameModel *frameModel;
@property (nonatomic, weak) id<SADynamicTableViewCellDelegate> delegate;

@property (nonatomic, strong) NSMutableArray<UIImageView *> *imagesViewArray;

@end
