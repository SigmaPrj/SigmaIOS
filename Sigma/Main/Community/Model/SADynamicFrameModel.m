//
//  SADynamicFrameModel.m
//  Sigma
//
//  Created by 汤轶侬 on 16/7/20.
//  Copyright © 2016年 Terence. All rights reserved.
//
#import "SADynamicFrameModel.h"
#import "SADynamicModel.h"

#define DYNAMIC_CELL_PADDING 10
#define DYNAMIC_AVATAR_SIZE 40
#define DYNAMIC_USERNAME_HEIGHT 20

@implementation SADynamicFrameModel

- (void)setFrameModel:(SADynamicModel *)dynamicModel {

    // 设置头像
    _avatarFrame = CGRectMake(DYNAMIC_CELL_PADDING, DYNAMIC_CELL_PADDING, DYNAMIC_AVATAR_SIZE, DYNAMIC_AVATAR_SIZE);

    // 设置用户名
    NSString *nickname = dynamicModel.nickname;
    CGFloat maxNicknameWidth = SCREEN_WIDTH-DYNAMIC_AVATAR_SIZE-3*DYNAMIC_CELL_PADDING;
    _nicknameFrame = [nickname boundingRectWithSize:CGSizeMake(maxNicknameWidth, DYNAMIC_USERNAME_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:DYNAMIC_USERNAME_FONT_SIZE]} context:nil];
    _nicknameFrame.origin.x = CGRectGetMaxX(_avatarFrame) + DYNAMIC_CELL_PADDING;
    _nicknameFrame.origin.y = CGRectGetMinY(_avatarFrame);

    // 认证图标
//    if
}

- (BOOL)isApproved {
    return _dynamicModel.is_approved != 0;
}

- (BOOL)hasTopic {
    return _dynamicModel.has_topic != 0;
}

@end
