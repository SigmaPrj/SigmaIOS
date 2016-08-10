//
//  SAFriendHeaderView.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/11.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAFriendHeaderView;
@class SAGroupModel;

@protocol SAFriendHeaderViewDelegate<NSObject>

- (void)friendHeaderView:(SAFriendHeaderView *)friendHeaderView didClickButton:(UIButton *)button;

@end

@interface SAFriendHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) SAGroupModel *groupModel;
@property (nonatomic, weak) id<SAFriendHeaderViewDelegate> delegate;

// headerView 不能对自己内部的子控件进行直接操作， 而是要交给使用者(代理)
@property (nonatomic, assign) BOOL rotageImageView;

@end
