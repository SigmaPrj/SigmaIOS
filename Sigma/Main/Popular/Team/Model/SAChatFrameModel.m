//
//  SAChatFrameModel.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/5.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SAChatFrameModel.h"
#import "SAChatModel.h"
#import "SAUserDataManager.h"
#import "SAMessageModel.h"

#define DATE_LABEL_HEIGHT 20
#define DATE_MARGIN 6
#define DATE_PADDING_TOP 3
#define DATE_PADDING_LEFT 4
#define DATE_FONT_SIZE 12
#define L_AVATAR_PADDING_LEFT 10
#define AVATAR_SIZE 40
#define SMALL_MARGIN 2
#define MESSAGE_FONT_SIZE 15

@implementation SAChatFrameModel

- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)setChatModel:(SAChatModel *)chatModel {
    _chatModel = chatModel;

    // 计算frame
    CGSize dateMaxSize = CGSizeMake(SCREEN_WIDTH, DATE_LABEL_HEIGHT);
    CGRect dateRect = [chatModel.date boundingRectWithSize:dateMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
            NSFontAttributeName: [UIFont systemFontOfSize:DATE_FONT_SIZE]
    } context:nil];
    CGFloat dateX = (SCREEN_WIDTH-dateRect.size.width-2*DATE_PADDING_LEFT)/2;
    CGFloat dateY = DATE_MARGIN;
    _dateLabelFrame = CGRectMake(dateX, dateY, (dateRect.size.width+2*DATE_PADDING_LEFT), DATE_LABEL_HEIGHT);

    // 设置avatar
    NSInteger uid = [SAUserDataManager readUserId];

    CGFloat avatarY = CGRectGetMaxY(_dateLabelFrame)+DATE_MARGIN*2;
    if (chatModel.fromUser == uid) {
        // 左侧显示头像
        _avatarImageViewFrame = CGRectMake(L_AVATAR_PADDING_LEFT, avatarY, AVATAR_SIZE, AVATAR_SIZE);
    } else {
        // 右侧显示用户头像
        _avatarImageViewFrame = CGRectMake(SCREEN_WIDTH-L_AVATAR_PADDING_LEFT-AVATAR_SIZE, avatarY, AVATAR_SIZE, AVATAR_SIZE);
    }

    // 设置消息
    CGSize messageMaxSize = CGSizeMake((SCREEN_WIDTH-2*L_AVATAR_PADDING_LEFT-2*AVATAR_SIZE-2*SMALL_MARGIN) , 0);
    CGRect messageRect = [chatModel.message boundingRectWithSize:messageMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
            NSFontAttributeName: [UIFont systemFontOfSize:MESSAGE_FONT_SIZE]
    } context:nil];

    if (chatModel.fromUser == uid) {

        _messageLabelFrame = CGRectMake(CGRectGetMaxX(_avatarImageViewFrame)+SMALL_MARGIN, CGRectGetMinY(_avatarImageViewFrame), messageRect.size.width, messageRect.size.height);

    } else {

        CGFloat messageX = SCREEN_WIDTH-L_AVATAR_PADDING_LEFT-AVATAR_SIZE-SMALL_MARGIN-messageRect.size.width;
        _messageLabelFrame = CGRectMake(messageX, CGRectGetMinY(_avatarImageViewFrame), messageRect.size.width, messageRect.size.height);

    }

}

- (CGFloat)getTotalHeight {
    CGFloat bottomAvatar = CGRectGetMaxY(self.avatarImageViewFrame)+DATE_MARGIN;
    CGFloat bottomMessage = CGRectGetMaxY(self.messageLabelFrame)+DATE_MARGIN;
    return (bottomAvatar>bottomMessage)?bottomAvatar:bottomMessage;
}

@end
