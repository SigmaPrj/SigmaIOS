//
//  SACommentFrameModel.m
//  Sigma
//
//  Created by 汤轶侬 on 16/7/27.
//  Copyright (c) 2016 blackcater. All rights reserved.
//

#import "SACommentFrameModel.h"
#import "SACommentModel.h"

#define COMMENT_CELL_SMALL_PADDING 8
#define COMMENT_CELL_COMMENT_PADDING_LEFT ((COMMENT_CELL_AVATAR_SIZE*2)/3)

@implementation SACommentFrameModel

- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)setCommentModel:(SACommentModel *)commentModel {
    _commentModel = commentModel;

    /**
     * 计算所有组件的frame
     */

    // 用户头像位置
    _avatarFrame = CGRectMake(COMMENT_CELL_PADDING, COMMENT_CELL_PADDING, COMMENT_CELL_AVATAR_SIZE, COMMENT_CELL_AVATAR_SIZE);

    // 设置日期
    CGFloat dateMaxWidth = SCREEN_WIDTH;
    CGSize dateSize = CGSizeMake(dateMaxWidth, COMMENT_CELL_AVATAR_SIZE);
    _dateFrame = [commentModel.publish_date boundingRectWithSize:dateSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:COMMENT_DATE_FONT_SIZE]} context:nil];
    CGFloat dateX = (SCREEN_WIDTH-COMMENT_CELL_PADDING-Width(_dateFrame));
    CGFloat dateY = (CGRectGetMidY(_avatarFrame) - Height(_dateFrame)/2);
    _dateFrame.origin.x = dateX;
    _dateFrame.origin.y = dateY;

    // 设置用户名位置
    CGFloat nicknameMaxWidth = (SCREEN_WIDTH-COMMENT_CELL_PADDING-CGRectGetMaxX(_avatarFrame)-COMMENT_CELL_SMALL_PADDING-Width(_dateFrame));
    CGSize nicknameSize = CGSizeMake(nicknameMaxWidth, COMMENT_CELL_AVATAR_SIZE);
    _nicknameFrame = [commentModel.nickname boundingRectWithSize:nicknameSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:COMMENT_NICKNAME_FONT_SIZE]} context:nil];
    CGFloat nicknameX = CGRectGetMaxX(_avatarFrame)+COMMENT_CELL_SMALL_PADDING;
    CGFloat nicknameY = CGRectGetMinY(_avatarFrame);
    _nicknameFrame.origin.x = nicknameX;
    _nicknameFrame.origin.y = nicknameY;

    // 设置认证图标位置
    if (self.isApproved) {
        CGFloat approvedX = CGRectGetMaxX(_nicknameFrame);
        CGFloat approvedY = (CGRectGetMidY(_nicknameFrame) - COMMUNITY_APPROVED_IMAGE_SIZE/2);
        _approvedFrame = CGRectMake(approvedX, approvedY, COMMUNITY_APPROVED_IMAGE_SIZE, COMMUNITY_APPROVED_IMAGE_SIZE);
    } else {
        _approvedFrame = CGRectZero;
    }

    // 设置学校文本位置
    CGSize schoolMaxSize = CGSizeMake(nicknameMaxWidth, COMMENT_CELL_AVATAR_SIZE);
    _schoolFrame = [commentModel.school boundingRectWithSize:schoolMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont italicSystemFontOfSize:COMMENT_SCHOOL_FONT_SIZE]} context:nil];
    CGFloat schoolX = CGRectGetMinX(_nicknameFrame);
    CGFloat schoolY = CGRectGetMaxY(_nicknameFrame);
    _schoolFrame.origin.x = schoolX;
    _schoolFrame.origin.y = schoolY;

    // 设置评论位置
    NSString *comments;
    if (self.hasReplay) {
        comments = [NSString stringWithFormat:@"@%@: %@", commentModel.replayNickname, commentModel.comment];
    } else {
        comments = commentModel.comment;
    }


    // 设置点赞文字位置
    NSString *praiseLabel = [NSString stringWithFormat:@"%d", commentModel.praise];
    CGSize praiseLabelMaxSize = CGSizeMake(SCREEN_WIDTH, 0);
    _praiseLabelFrame = [praiseLabel boundingRectWithSize:praiseLabelMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:COMMENT_COMMENT_FONT_SIZE]} context:nil];
    CGFloat praiseLabelX = SCREEN_WIDTH-COMMENT_CELL_PADDING-Width(_praiseLabelFrame);
    _praiseLabelFrame.origin.x = praiseLabelX;

    // 设置评论
    CGFloat commentMaxWidth = (SCREEN_WIDTH-2*COMMENT_CELL_PADDING-COMMENT_CELL_COMMENT_PADDING_LEFT-Width(_praiseLabelFrame)-COMMENT_COMMENT_PRAISE_SIZE);
    CGSize commentMaxSize = CGSizeMake(commentMaxWidth, 0);
    _commentFrame = [comments boundingRectWithSize:commentMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:COMMENT_COMMENT_FONT_SIZE]} context:nil];
    CGFloat commentX = (COMMENT_CELL_PADDING+COMMENT_CELL_COMMENT_PADDING_LEFT);
    CGFloat commentY = (CGRectGetMaxY(_avatarFrame)+COMMENT_CELL_SMALL_PADDING);
    _commentFrame.origin.x = commentX;
    _commentFrame.origin.y = commentY;

    // 设置点赞按钮位置
    CGFloat praiseBtnX = (CGRectGetMinX(_praiseLabelFrame) - COMMENT_COMMENT_PRAISE_SIZE);
    CGFloat praiseBtnY = (CGRectGetMaxY(_commentFrame) - COMMENT_COMMENT_PRAISE_SIZE);
    _praiseBtnFrame = CGRectMake( praiseBtnX, praiseBtnY, COMMENT_COMMENT_PRAISE_SIZE, COMMENT_COMMENT_PRAISE_SIZE);

    CGFloat praiseLabelY = (CGRectGetMidY(_praiseBtnFrame) - (Height(_praiseLabelFrame)/2));
    _praiseLabelFrame.origin.y = praiseLabelY;

    // 下划线
    _underlineFrame = CGRectMake(COMMENT_CELL_PADDING, (CGFloat) (CGRectGetMaxY(_commentFrame)+COMMENT_CELL_SMALL_PADDING-0.5), (SCREEN_WIDTH-2*COMMENT_CELL_PADDING), 0.5);
}

/*!
 * 计算评论应该具有的高度
 *
 * @return
 */
- (CGFloat)getTotalHeight {
    return (CGRectGetMaxY(_commentFrame)+COMMENT_CELL_SMALL_PADDING);
}

/*!
 *
 * @return
 */
- (BOOL)isApproved {
    return (self.commentModel.is_approved == 1);
}

/*!
 *
 * @return
 */
- (BOOL)hasReplay {
    return (self.commentModel.hasReplay == 1);
}

@end
