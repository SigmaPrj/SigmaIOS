//
//  SACommunityTableHeaderView.m
//  Sigma
//
//  Created by 汤轶侬 on 16/7/20.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SACommunityTableHeaderView.h"
#import "SACommunityUserModel.h"
#import "UIImageView+WebCache.h"
#import "SAUserDataManager.h"

#define COMMUNITY_HEADER_VIEW_AVATAR_SIZE 60
#define COMMUNITY_HEADER_VIEW_PADDING 10
#define COMMUNITY_HEADER_VIEW_BOTTOM 8
#define COMMUNITY_COMPONENT_PADDING 6
#define COMMUNITY_HEADER_VIEW_AVATAR_BOTTOM 18
#define COMMUNITY_HEADER_VIEW_NICKNAME_SIZE 20

@interface SACommunityTableHeaderView()

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UIImageView *approvedImageView;

@end

@implementation SACommunityTableHeaderView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self render];
    }
    return self;
}

- (void) render {
    // 设置其他组件
    [self addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.avatarImageView];
    [self.bgImageView addSubview:self.approvedImageView];
    [self.bgImageView addSubview:self.nickNameLabel];
}

- (void)setUserModel:(SACommunityUserModel *)userModel {
    _userModel = userModel;
    
    [self renderData];
}

// 给组件添加内容和修改frame
- (void)renderData {
    // 设置背景图片
    NSURL *bgImageUrl = [NSURL URLWithString:self.userModel.bgImage];
    [self.bgImageView sd_setImageWithURL:bgImageUrl placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageProgressiveDownload];
    // 背景图被点击,设置图片
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgImageViewClicked:)];
    recognizer.numberOfTapsRequired = 1;
    [self.bgImageView addGestureRecognizer:recognizer];

    // 设置avatarImageView frame
    NSString *avatarPath = self.userModel.image;

    if ([avatarPath isEqualToString:@""]) {
         // 使用本地图片
        NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSDictionary *userDict = [SAUserDataManager readUser];
        NSString *filename = [NSString stringWithFormat:@"%@_avatar", userDict[@"username"]];

        NSString *ImagePath = [[NSString alloc] initWithFormat:@"/%@.png", filename];
        NSString *filePath = [[NSString alloc] initWithFormat:@"%@%@", DocumentsPath, ImagePath];
        NSData *imageDatas = [NSData dataWithContentsOfFile:filePath];
        self.avatarImageView.image = [UIImage imageWithData:imageDatas];
    } else {
        NSURL *avatarImageUrl = [NSURL fileURLWithPath:avatarPath];
        [self.avatarImageView sd_setImageWithURL:avatarImageUrl placeholderImage:[UIImage imageNamed:@"avatar60"] options:SDWebImageRetryFailed | SDWebImageProgressiveDownload];
    }

    // 设置approvedImageView frame
    if (self.userModel.is_approved == 1) {
        CGFloat aImageLeft = MinX(self.avatarImageView)-COMMUNITY_APPROVED_IMAGE_SIZE-COMMUNITY_HEADER_VIEW_PADDING;
        CGFloat aImageTop = self.frame.size.height - COMMUNITY_APPROVED_IMAGE_SIZE - COMMUNITY_HEADER_VIEW_BOTTOM;
        self.approvedImageView.frame = CGRectMake(aImageLeft, aImageTop, COMMUNITY_APPROVED_IMAGE_SIZE, COMMUNITY_APPROVED_IMAGE_SIZE);
    }
    
    // 设置 nickNameLabel frame
    self.nickNameLabel.text = self.userModel.nickname;
    CGRect newNickNameLabelFrame = [self.userModel.nickname boundingRectWithSize:CGSizeMake(200, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:COMMUNITY_HEADER_VIEW_NICKNAME_SIZE]} context:nil];
    if (self.userModel.is_approved == 1) {
        newNickNameLabelFrame.origin.x = MinX(self.approvedImageView) - newNickNameLabelFrame.size.width-COMMUNITY_COMPONENT_PADDING;
        newNickNameLabelFrame.origin.y = self.frame.size.height - COMMUNITY_COMPONENT_PADDING - newNickNameLabelFrame.size.height;
        self.nickNameLabel.frame = newNickNameLabelFrame;
        _nickNameLabel.textColor = COMMUNITY_APPROVED_NAME_COLOR;
    } else {
        newNickNameLabelFrame.origin.x = MinX(self.avatarImageView) - newNickNameLabelFrame.size.width-COMMUNITY_COMPONENT_PADDING;
        newNickNameLabelFrame.origin.y = self.frame.size.height - COMMUNITY_COMPONENT_PADDING - newNickNameLabelFrame.size.height;
        self.nickNameLabel.frame = newNickNameLabelFrame;
        _nickNameLabel.textColor = COMMUNITY_TEXT_COLOR;
    }
}

- (void)bgImageViewClicked:(NSNotification *)notification {
    if ([self.delegate respondsToSelector:@selector(bgImageViewDidClicked:)]) {
        [self.delegate bgImageViewDidClicked:self.bgImageView];
    }
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView  = [[UIImageView alloc] init];
        _bgImageView.frame = self.frame;
        _bgImageView.userInteractionEnabled = YES;
    }
    
    return _bgImageView;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        // 设置frame
        CGFloat aImageLeft = SCREEN_WIDTH-COMMUNITY_HEADER_VIEW_AVATAR_SIZE-COMMUNITY_HEADER_VIEW_PADDING;
        CGFloat aImageTop = self.frame.size.height -COMMUNITY_HEADER_VIEW_AVATAR_SIZE + COMMUNITY_HEADER_VIEW_AVATAR_BOTTOM;
        self.avatarImageView.frame = CGRectMake(aImageLeft, aImageTop, COMMUNITY_HEADER_VIEW_AVATAR_SIZE, COMMUNITY_HEADER_VIEW_AVATAR_SIZE);
        // 设置边框和圆形
        _avatarImageView.layer.borderWidth = 1;
        _avatarImageView.layer.borderColor = COMMUNITY_BORDER_COLOR.CGColor;
        _avatarImageView.layer.cornerRadius = COMMUNITY_HEADER_VIEW_AVATAR_SIZE/2;
        _avatarImageView.layer.masksToBounds = YES;
    }
    
    return _avatarImageView;
}

- (UIImageView *)approvedImageView {
    if (!_approvedImageView) {
        _approvedImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:COMMUNITY_APPROVED_IMAGE]];
        _approvedImageView.frame = CGRectZero;
    }
    
    return _approvedImageView;
}

- (UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nickNameLabel.font = [UIFont boldSystemFontOfSize:COMMUNITY_HEADER_VIEW_NICKNAME_SIZE];
    }
    return _nickNameLabel;
}

@end
