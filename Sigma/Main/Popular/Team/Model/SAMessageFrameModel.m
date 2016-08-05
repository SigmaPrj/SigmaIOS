//
//  SAMessageFrameModel.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/5.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SAMessageFrameModel.h"
#import "SAMessageModel.h"

#define CELL_HEIGHT 75-0.5
#define AVATAR_PADDING_LEFT 15
#define AVATAR_SIZE 60
#define AVATAR_PADDING_TOP ((CELL_HEIGHT-AVATAR_SIZE)/2)
#define AVATAR_PADDING_BOTTOM AVATAR_PADDING_TOP
#define AVATAR_PADDING_RIGHT 10
#define NICKNAME_HEIGHT 20
#define NICKNAME_FONT_SIZE 18
#define MESSAGE_HEIGHT 16
#define MESSAGE_FONT_SIZE 14
#define SCHOOL_HEIGHT 14
#define SCHOOL_FONT_SIZE 12
#define VIP_SIZE 14

@implementation SAMessageFrameModel

- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)setMessageModel:(SAMessageModel *)messageModel {
    _messageModel = messageModel;
    // 计算avatar
    _avatarImageViewFrame = CGRectMake(AVATAR_PADDING_LEFT, AVATAR_PADDING_TOP, AVATAR_SIZE, AVATAR_SIZE);

    // 计算nickname
    CGSize nicknameMaxSize = CGSizeMake(SCREEN_WIDTH-CGRectGetMaxX(_avatarImageViewFrame)-AVATAR_PADDING_LEFT-AVATAR_PADDING_RIGHT, NICKNAME_HEIGHT);
    CGRect nicknameRect = [messageModel.nickname boundingRectWithSize:nicknameMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:NICKNAME_FONT_SIZE]} context:nil];
    CGFloat nicknameX = CGRectGetMaxX(_avatarImageViewFrame)+AVATAR_PADDING_RIGHT;
    CGFloat nicknameY = CGRectGetMinY(_avatarImageViewFrame)+5;
    _nicknameLabelFrame = CGRectMake(nicknameX, nicknameY, nicknameRect.size.width, nicknameRect.size.height);

    // 计算approvedImage
    if (messageModel.isApproved) {
        CGFloat approvedX = CGRectGetMaxX(_nicknameLabelFrame);
        CGFloat approvedY = CGRectGetMinY(_nicknameLabelFrame)+(Height(_nicknameLabelFrame)-VIP_SIZE)/2;
        _approvedImageViewFrame = CGRectMake(approvedX, approvedY, VIP_SIZE, VIP_SIZE);
    } else {
        _approvedImageViewFrame = CGRectZero;
    }

    // 计算dateize
    CGSize dateMaxSize = CGSizeMake(SCREEN_WIDTH, MESSAGE_HEIGHT);
    CGRect dateRect = [messageModel.date boundingRectWithSize:dateMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
            NSFontAttributeName: [UIFont systemFontOfSize:MESSAGE_FONT_SIZE]
    } context:nil];
    CGFloat dateX = SCREEN_WIDTH-dateRect.size.width-AVATAR_PADDING_LEFT;
    CGFloat dateY = CGRectGetMinY(_nicknameLabelFrame)+(Height(_nicknameLabelFrame)-MESSAGE_HEIGHT)/2;
    _dateLabelFrame = CGRectMake(dateX, dateY, dateRect.size.width, dateRect.size.height);

    // 计算school
    CGSize schoolMaxSize = CGSizeMake(nicknameMaxSize.width, SCHOOL_HEIGHT);
    CGRect schoolRect = [messageModel.school boundingRectWithSize:schoolMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
            NSFontAttributeName: [UIFont italicSystemFontOfSize:SCHOOL_FONT_SIZE]
    } context:nil];
    CGFloat schoolX = CGRectGetMinX(_nicknameLabelFrame);
    CGFloat schoolY = CGRectGetMaxY(_nicknameLabelFrame)+2;
    _schoolLabelFrame = CGRectMake(schoolX, schoolY, schoolRect.size.width, schoolRect.size.height);

    // 计算message
    CGSize messageMaxSize = CGSizeMake(SCREEN_WIDTH-CGRectGetMaxY(_avatarImageViewFrame)-AVATAR_PADDING_RIGHT-AVATAR_PADDING_LEFT, MESSAGE_HEIGHT);
    CGRect messageRect = [messageModel.message boundingRectWithSize:messageMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
            NSFontAttributeName: [UIFont systemFontOfSize:MESSAGE_FONT_SIZE]
    } context:nil];
    CGFloat messageX = CGRectGetMinX(_nicknameLabelFrame);
    CGFloat messageY = CGRectGetMaxY(_schoolLabelFrame)+4;
    _messageLabelFrame = CGRectMake(messageX, messageY, messageRect.size.width, messageRect.size.height);

    _isApproved = messageModel.isApproved;
}

@end
