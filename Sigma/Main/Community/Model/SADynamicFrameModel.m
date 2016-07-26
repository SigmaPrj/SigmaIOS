//
//  SADynamicFrameModel.m
//  Sigma
//
//  Created by 汤轶侬 on 16/7/20.
//  Copyright © 2016年 Terence. All rights reserved.
//
#import "SADynamicFrameModel.h"
#import "SADynamicModel.h"

#define DYNAMIC_SMALL_PADDING 2
#define DYNAMIC_APPROVED_SIZE 14
#define DYNAMIC_BUTTON_SIZE 24
#define DYNAMIC_SCHOOL_HEIGHT 18
#define DYNAMIC_USERNAME_HEIGHT 20
#define DYNAMIC_IMAGES_PADDING 8

@implementation SADynamicFrameModel

- (void)setDynamicModel:(SADynamicModel *)dynamicModel {

    _dynamicModel = dynamicModel;

    // 设置头像
    _avatarFrame = CGRectMake(DYNAMIC_CELL_PADDING, DYNAMIC_CELL_PADDING, DYNAMIC_AVATAR_SIZE, DYNAMIC_AVATAR_SIZE);

    // 设置用户名
    NSString *nickname = dynamicModel.nickname;
    CGFloat maxNicknameWidth = SCREEN_WIDTH-DYNAMIC_AVATAR_SIZE-3*DYNAMIC_CELL_PADDING;
    _nicknameFrame = [nickname boundingRectWithSize:CGSizeMake(maxNicknameWidth, DYNAMIC_USERNAME_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:DYNAMIC_USERNAME_FONT_SIZE]} context:nil];
    _nicknameFrame.origin.x = CGRectGetMaxX(_avatarFrame) + DYNAMIC_CELL_PADDING;
    _nicknameFrame.origin.y = CGRectGetMinY(_avatarFrame);

    _isApproved = (dynamicModel.is_approved == 1);
    // 认证图标
    if (_isApproved) {
        CGFloat approvedX = CGRectGetMaxX(_nicknameFrame) + DYNAMIC_SMALL_PADDING;
        CGFloat approvedY = CGRectGetMidY(_nicknameFrame) - DYNAMIC_APPROVED_SIZE/2;
        _approvedFrame = CGRectMake(approvedX, approvedY, DYNAMIC_APPROVED_SIZE, DYNAMIC_APPROVED_SIZE);
    } else {
        _approvedFrame = CGRectZero;
    }

    // 学校
    NSString *school = dynamicModel.school;
    CGFloat maxSchoolWidth = maxNicknameWidth;
    _schoolFrame = [school boundingRectWithSize:CGSizeMake(maxSchoolWidth, DYNAMIC_SCHOOL_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont italicSystemFontOfSize:DYNAMIC_SCHOOL_FONT_SIZE]} context:nil];
    CGFloat schoolX = CGRectGetMinX(_nicknameFrame);
    CGFloat schoolY = CGRectGetMaxY(_nicknameFrame) + DYNAMIC_SMALL_PADDING;
    _schoolFrame.origin.x = schoolX;
    _schoolFrame.origin.y = schoolY;

    // 日期
    NSString *date = dynamicModel.publish_date;
    CGFloat maxDateWidth = 200;
    _dateFrame = [date boundingRectWithSize:CGSizeMake(maxDateWidth, DYNAMIC_SCHOOL_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:DYNAMIC_SCHOOL_FONT_SIZE]} context:nil];
    CGFloat dateX = SCREEN_WIDTH-2*DYNAMIC_CELL_PADDING-_dateFrame.size.width;
    CGFloat dateY = CGRectGetMidY(_avatarFrame)-_dateFrame.size.height/2;
    _dateFrame.origin.x = dateX;
    _dateFrame.origin.y = dateY;

    // 显示内容
    NSString *content = dynamicModel.content;
    CGFloat maxContentWidth = maxNicknameWidth;
    _contentFrame = [content boundingRectWithSize:CGSizeMake(maxContentWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:DYNAMIC_CONTENT_FONT_SIZE]} context:nil];
    CGFloat contentX = CGRectGetMinX(_avatarFrame);
    CGFloat contentY = CGRectGetMaxY(_schoolFrame) + 2*DYNAMIC_SMALL_PADDING;
    _contentFrame.origin.x = contentX;
    _contentFrame.origin.y = contentY;

    // 设置图片
    NSUInteger num = 0;
    if ((NSNull *)dynamicModel.images != [NSNull null]) {
        num = dynamicModel.images.count;
        CGFloat itemW = (SCREEN_WIDTH-2*DYNAMIC_CELL_PADDING-2*DYNAMIC_IMAGES_PADDING)/3;
        CGFloat itemH = itemW;
        __weak typeof(self) weakSelf = self;
        [dynamicModel.images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            int column = (int) idx % 3;
            int row = (int)idx / 3;
            CGFloat itemX = CGRectGetMinX(weakSelf.contentFrame) + itemW * column + DYNAMIC_IMAGES_PADDING * column;
            CGFloat itemY = CGRectGetMaxY(weakSelf.contentFrame) + DYNAMIC_CELL_PADDING + itemH * row + DYNAMIC_IMAGES_PADDING * row;
            [weakSelf.imagesFrame addObject:[NSValue valueWithCGRect:CGRectMake(itemX, itemY, itemW, itemH)]];
        }];
    } else {
        dynamicModel.images = [NSArray array];
    }

    // 分享 button
    CGFloat lookBtnX = CGRectGetMinX(_contentFrame);
    CGFloat lookBtnY;
    if (num == 0) {
        lookBtnY = CGRectGetMaxY(_contentFrame) + DYNAMIC_IMAGES_PADDING;
    } else {
        CGRect lastImageFrame = [[self.imagesFrame lastObject] CGRectValue];
        lookBtnY = CGRectGetMaxY(lastImageFrame) + DYNAMIC_IMAGES_PADDING;
    }
    _lookBtnFrame = CGRectMake(lookBtnX, lookBtnY, DYNAMIC_BUTTON_SIZE, DYNAMIC_BUTTON_SIZE);

    // 赞 button
    CGFloat praiseBtnX = CGRectGetMaxX(_lookBtnFrame) + 2*DYNAMIC_IMAGES_PADDING;
    CGFloat praiseBtnY = lookBtnY;
    _praiseBtnFrame = CGRectMake(praiseBtnX, praiseBtnY, DYNAMIC_BUTTON_SIZE, DYNAMIC_BUTTON_SIZE);

    // 评论 button
    CGFloat commentBtnX = SCREEN_WIDTH-DYNAMIC_CELL_PADDING-DYNAMIC_BUTTON_SIZE;
    CGFloat commentBtnY = lookBtnY;
    _commentBtnFrame = CGRectMake(commentBtnX, commentBtnY, DYNAMIC_BUTTON_SIZE, DYNAMIC_BUTTON_SIZE);
}

- (NSMutableArray *)imagesFrame {
    if (!_imagesFrame) {
        _imagesFrame = [NSMutableArray array];
    }
    return _imagesFrame;
}

- (BOOL)isApproved {
    return _dynamicModel.is_approved != 0;
}

- (BOOL)hasTopic {
    return _dynamicModel.has_topic != 0;
}

/*!
 * 获取整个视图的高度
 * @return
 */
- (CGFloat) getTotalHeight {
    return (CGRectGetMaxY(_commentBtnFrame)+2*DYNAMIC_IMAGES_PADDING);
}

@end
