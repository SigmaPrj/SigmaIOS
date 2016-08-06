//
//  SALoadingTableView.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/3.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAHeaderLoadingView;
@class SAFooterLoadingView;

@protocol SALoadingTableViewDelegate <NSObject>

@optional
- (void)endHeaderLoadingAnimation:(SAHeaderLoadingView *)loadingView;
- (void)endFooterLoadingAnimation:(SAFooterLoadingView *)footerLoadingView;

@end

@interface SALoadingTableView : UITableView

@property (nonatomic, assign) BOOL useHeaderLoading;
@property (nonatomic, assign) BOOL useFooterLoading;

@property (nonatomic, weak) id<SALoadingTableViewDelegate> loadingDelegate;


@end
