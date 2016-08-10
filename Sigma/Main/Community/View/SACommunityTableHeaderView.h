//
//  SACommunityTableHeaderView.h
//  Sigma
//
//  Created by 汤轶侬 on 16/7/20.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SACommunityUserModel;

@protocol SACommunityTableHeaderViewDelegate<NSObject>

@required
- (void)bgImageViewDidClicked:(UIImageView *)bgImageView;

@end

@interface SACommunityTableHeaderView : UIView

@property (nonatomic, strong) SACommunityUserModel *userModel;

@property (nonatomic, weak) id<SACommunityTableHeaderViewDelegate> delegate;

@end
