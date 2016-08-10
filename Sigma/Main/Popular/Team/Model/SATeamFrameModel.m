//
//  SATeamFrameModel.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/11.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SATeamFrameModel.h"
#import "SATeamModel.h"

#define CELL_HEIGHT 55
#define AVATAR_SIZE 40
#define AVATAR_PADDING_RIGHT 12
#define PADDING_LEFT 10
#define NICKNAME_FONT_SIZE 16
#define NICKNAME_HEIGHT 18
#define SCHOOL_FONT_SIZE 14
#define SCHOOL_HEIGHT 16
#define ONLINE_FONT_SIZE 12
#define ONLINE_HEIGHT 14

@implementation SATeamFrameModel

- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)setTeamModel:(SATeamModel *)teamModel {
    _teamModel = teamModel;

    [self setupFrame];
}

- (void)setupFrame {

    SATeamModel *teamModel = self.teamModel;

    // 计算 avatarImageViewFrame
    _avatarImageViewFrame = CGRectMake(PADDING_LEFT, (CELL_HEIGHT-AVATAR_SIZE)/2, AVATAR_SIZE, AVATAR_SIZE);

    // 计算 nicknameLabelFrame
    CGSize nicknameMaxSize = CGSizeMake(SCREEN_WIDTH, NICKNAME_HEIGHT);
    CGRect nicknameRect = [teamModel.teamName boundingRectWithSize:nicknameMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
            NSFontAttributeName: [UIFont systemFontOfSize:NICKNAME_FONT_SIZE]
    } context:nil];
    _nicknameLabelFrame = CGRectMake(CGRectGetMaxX(_avatarImageViewFrame)+AVATAR_PADDING_RIGHT, CGRectGetMinY(_avatarImageViewFrame), nicknameRect.size.width, nicknameRect.size.height);

    // 计算 schoolLabelFrame
    CGFloat descX = CGRectGetMinX(_nicknameLabelFrame);
    CGFloat descY = CGRectGetMaxY(_nicknameLabelFrame);
    CGSize descMaxSize = CGSizeMake(SCREEN_WIDTH, SCHOOL_HEIGHT);
    CGRect descRect = [teamModel.teamDesc boundingRectWithSize:descMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
            NSFontAttributeName: [UIFont italicSystemFontOfSize:SCHOOL_FONT_SIZE]
    } context:nil];
    _descLabelFrame = CGRectMake(descX, descY, descRect.size.width, descRect.size.height);
}

@end
