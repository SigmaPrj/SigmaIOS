//
//  SACommentView.h
//  Sigma
//
//  Created by 汤轶侬 on 16/7/27.
//  Copyright (c) 2016 blackcater. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SACommentView;

@protocol SACommentViewDelegate<NSObject>

- (void)addDataSuccess:(SACommentView *)commentView commentsData:(NSMutableArray *)commentsData;

@end

@interface SACommentView : UITableView

@property (nonatomic, weak) id<SACommentViewDelegate> ownDelegate;

- (instancetype)initWithHeaderView:(UIView *)headerView frame:(CGRect)frame;

- (void)setCommentsData:(NSArray *)commentsData;

@end
