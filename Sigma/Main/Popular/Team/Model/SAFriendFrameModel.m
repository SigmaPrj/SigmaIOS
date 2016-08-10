//
//  SAFriendFrameModel.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/10.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SAFriendFrameModel.h"
#import "SAFriendModel.h"

#define CELL_HEIGHT 55
#define AVATAR_SIZE 40
#define AVATAR_PADDING_RIGHT 12
#define PADDING_LEFT 10
#define VIP_SIZE 14
#define NICKNAME_FONT_SIZE 16
#define NICKNAME_HEIGHT 18
#define SCHOOL_FONT_SIZE 14
#define SCHOOL_HEIGHT 16
#define ONLINE_FONT_SIZE 12
#define ONLINE_HEIGHT 14

@implementation SAFriendFrameModel

- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)setFriendModel:(SAFriendModel *)friendModel {
    _friendModel = friendModel;

    // 计算 avatarImageViewFrame
    _avatarImageViewFrame = CGRectMake(PADDING_LEFT, (CELL_HEIGHT-AVATAR_SIZE)/2, AVATAR_SIZE, AVATAR_SIZE);

    // 计算 nicknameLabelFrame
    CGSize nicknameMaxSize = CGSizeMake(SCREEN_WIDTH, NICKNAME_HEIGHT);
    CGRect nicknameRect = [friendModel.nickname boundingRectWithSize:nicknameMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
            NSFontAttributeName: [UIFont systemFontOfSize:NICKNAME_FONT_SIZE]
    } context:nil];
    _nicknameLabelFrame = CGRectMake(CGRectGetMaxX(_avatarImageViewFrame)+AVATAR_PADDING_RIGHT, CGRectGetMinY(_avatarImageViewFrame), nicknameRect.size.width, nicknameRect.size.height);

    // 计算 vipImageViewFrame
    if ([self isVip]) {
        CGFloat vipX = CGRectGetMaxX(_nicknameLabelFrame);
        CGFloat vipY = CGRectGetMinY(_nicknameLabelFrame) + (Height(_nicknameLabelFrame) - VIP_SIZE)/2;
        _vipImageViewFrame = CGRectMake(vipX, vipY, VIP_SIZE, VIP_SIZE);
    } else {
        _vipImageViewFrame = CGRectZero;
    }

    // 计算 schoolLabelFrame
    CGFloat schoolX = CGRectGetMinX(_nicknameLabelFrame);
    CGFloat schoolY = CGRectGetMaxY(_nicknameLabelFrame);
    CGSize schoolMaxSize = CGSizeMake(SCREEN_WIDTH, SCHOOL_HEIGHT);
    CGRect schoolRect = [friendModel.school boundingRectWithSize:schoolMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
            NSFontAttributeName: [UIFont italicSystemFontOfSize:SCHOOL_FONT_SIZE]
    } context:nil];
    _schoolLabelFrame = CGRectMake(schoolX, schoolY, schoolRect.size.width, schoolRect.size.height);

    // 计算 onlineLabelFrame
    CGSize onlineMaxSize = CGSizeMake(SCREEN_WIDTH, ONLINE_HEIGHT);
    NSString *str = @" [在线] ";
    CGRect onlineRect = [str boundingRectWithSize:onlineMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
            NSFontAttributeName: [UIFont systemFontOfSize:ONLINE_FONT_SIZE]
    } context:nil];
    CGFloat onlineX = SCREEN_WIDTH-PADDING_LEFT-onlineRect.size.width;
    CGFloat onlineY = CGRectGetMidY(_nicknameLabelFrame) + (nicknameRect.size.height-onlineRect.size.height)/2;
    _onlineLabelFrame = CGRectMake(onlineX, onlineY, onlineRect.size.width, onlineRect.size.height);
}

- (BOOL)isOnline {
    return self.friendModel.online == (NSInteger *) 1;
}

- (BOOL)isVip {
    return self.friendModel.vip == 1;
}

@end
