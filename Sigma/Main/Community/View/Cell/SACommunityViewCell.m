//
//  SACommunityViewCell.m
//  Sigma
//
//  Created by 汤轶侬 on 16/7/15.
//  Copyright (c) 2016 Terence. All rights reserved.
//

#import "SACommunityViewCell.h"
#import "SACommunityModel.h"
#import "View+MASAdditions.h"

#define COMMUNITY_CELL_AVATAR_SIZE 40
#define COMMUNITY_LEVEL_IMAGE_SIZE 16
#define COMMUNITY_CELL_USER_FONT_SIZE 18
#define COMMUNITY_CELL_MESSAGE_FONT_SIZE 16
#define COMMUNITY_CELL_LEVEL_FONT_SIZE 12
#define COMMUNITY_CELL_FONT_COLOR COLOR_RGB(51, 51, 51)
#define COMMUNITY_CELL_LEVEL_COLOR COLOR_RGB(245, 245, 51)
#define COMMUNITY_CELL_UNDERLINE_COLOR COLOR_RGB(204, 204, 204)
#define COMMUNITY_CELL_USER_LEVEL @"community_level.png"
#define COMMUNITY_CELL_SHARE_IMG @"community_share.png"
#define COMMUNITY_CELL_PRAISE_IMG @"community_praise.png"
#define COMMUNITY_CELL_COMMENT_IMG @"community_comment.png"
#define COMMUNITY_NUM_LINES 4

#define COMMUNITY_CELL_PADDING_TOP 20
#define COMMUNITY_CELL_PADDING_BOTTOM 8
#define COMMUNITY_CELL_HEADER_PADDING 8
#define COMMUNITY_CELL_LABEL_PADDING_LEFT 8
#define COMMUNITY_CELL_IMAGES_PADDING 8
#define COMMUNITY_CELL_MESSAGE_BOTTOM 16
#define COMMUNITY_CELL_IMAGE_HEIGHT 108

@interface SACommunityViewCell()

@property (nonatomic, strong) SACommunityModel *communityModel;
// 动态内容数据
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *levelImageView;
@property (nonatomic, strong) UILabel *levelLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) NSArray<UIImageView *> *images;
@property (nonatomic, strong) UIButton *shareBtn; // 分享按钮
@property (nonatomic, strong) UIButton *praiseBtn; // 点赞按钮
@property (nonatomic, strong) UIButton *commentBtn; // 评论按钮
@property (nonatomic, strong) UIView *underline;

@end

@implementation SACommunityViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

- (void)render {
    [self addSubview:self.avatarImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.levelImageView];
    [self addSubview:self.levelLabel];
    [self addSubview:self.messageLabel];
    for (int i = 0; i < self.images.count; ++i) {
        [self addSubview:self.images[(NSUInteger) i]];
    }
    [self addSubview:self.underline];

    // 添加约束条件
    [self updateConstraints];
}

- (void)updateConstraints {

    [self.avatarImageView mas_remakeConstraints:^(MASConstraintMaker *maker) {
        maker.left.equalTo(self.mas_left).with.offset(COMMUNITY_PADDING);
        maker.top.equalTo(self.mas_top).with.offset(COMMUNITY_CELL_PADDING_TOP);
        maker.width.height.mas_equalTo(COMMUNITY_CELL_AVATAR_SIZE);
    }];

    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *maker) {
        maker.left.equalTo(self.avatarImageView.mas_right).with.offset(COMMUNITY_CELL_LABEL_PADDING_LEFT);
        maker.centerY.equalTo(self.avatarImageView.mas_centerY);
    }];

    [self.levelImageView mas_remakeConstraints:^(MASConstraintMaker *maker) {
        maker.left.equalTo(self.nameLabel.mas_right).with.offset(COMMUNITY_CELL_LABEL_PADDING_LEFT);
        maker.bottom.equalTo(self.nameLabel.mas_bottom);
        maker.width.height.mas_equalTo(COMMUNITY_LEVEL_IMAGE_SIZE);
    }];

    [self.levelLabel mas_remakeConstraints:^(MASConstraintMaker *maker) {
        maker.left.equalTo(self.levelImageView.mas_right);
        maker.bottom.equalTo(self.levelImageView.mas_bottom);
    }];

    [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *maker) {
        maker.left.equalTo(self.avatarImageView.mas_left);
        maker.top.equalTo(self.avatarImageView.mas_bottom).with.offset(COMMUNITY_CELL_PADDING_BOTTOM);
        maker.right.lessThanOrEqualTo(self.mas_right).with.offset(-COMMUNITY_PADDING);
    }];

    // 核心代码, 排列 图片
    for (int i = 0; i < self.images.count; ++i) {
        UIImageView *imageView = self.images[(NSUInteger) i];
        [imageView mas_remakeConstraints:^(MASConstraintMaker *maker) {
            maker.height.mas_equalTo(COMMUNITY_CELL_IMAGE_HEIGHT);
            maker.width.equalTo(self.mas_width).with.multipliedBy(1/3);
            maker.size.with.sizeOffset(CGSizeMake(COMMUNITY_CELL_IMAGES_PADDING, 0));
        }];
        // TODO : cell中图片布局
    }

    [super updateConstraints];
}

- (void)renderWithData: (NSDictionary *)dict {
    _communityModel = [SACommunityModel communityWithDict:dict];

    [self render];
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.communityModel.user_avatar]];
        _avatarImageView.layer.borderWidth = COMMUNITY_BORDER_WIDTH;
        _avatarImageView.layer.borderColor = COMMUNITY_BORDER_COLOR;
        _avatarImageView.layer.cornerRadius = COMMUNITY_CELL_AVATAR_SIZE/2;
    }
    return _avatarImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = self.communityModel.user_name;
        _nameLabel.font = [UIFont systemFontOfSize:COMMUNITY_CELL_USER_FONT_SIZE];
        [_nameLabel setTextColor:COMMUNITY_CELL_FONT_COLOR];
    }

    return _nameLabel;
}

- (UIImageView *)levelImageView {
    if (!_levelImageView) {
        _levelImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:COMMUNITY_CELL_USER_LEVEL]];
    }

    return _levelImageView;
}

- (UILabel *)levelLabel {
    if (!_levelLabel) {
        _levelLabel = [[UILabel alloc] init];
        _levelLabel.font = [UIFont italicSystemFontOfSize:COMMUNITY_CELL_LEVEL_FONT_SIZE];
        _levelLabel.text = [NSString stringWithFormat:@"%d", self.communityModel.level];
        [_levelLabel setTextColor:COMMUNITY_CELL_LEVEL_COLOR];
    }

    return _levelLabel;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel.numberOfLines = COMMUNITY_NUM_LINES;
        _messageLabel.lineBreakMode = NSLineBreakByTruncatingTail | NSLineBreakByWordWrapping;
        _messageLabel.text = self.communityModel.message;
        _messageLabel.font = [UIFont systemFontOfSize:COMMUNITY_CELL_MESSAGE_FONT_SIZE];
        [_messageLabel setTextColor:COMMUNITY_CELL_FONT_COLOR];
    }

    return _messageLabel;
}

- (NSArray *)images {
    if (!_images) {
        NSMutableArray *mutableArray = [NSMutableArray array];
        for (int i = 0; i < self.communityModel.images.count; ++i) {
            NSString *imagePath = [[NSBundle mainBundle] pathForResource:self.communityModel.images[(NSUInteger) i] ofType:nil];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:imagePath]];
            [mutableArray addObject:imageView];
        }
        _images = [mutableArray copy];
    }

    return _images;
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [[UIButton alloc] init];
        [_shareBtn setBackgroundImage:[UIImage imageNamed:COMMUNITY_CELL_SHARE_IMG] forState:UIControlStateNormal];
    }

    return _shareBtn;
}

- (UIButton *)praiseBtn {
    if (!_praiseBtn) {
        _praiseBtn = [[UIButton alloc] init];
        [_praiseBtn setBackgroundImage:[UIImage imageNamed:COMMUNITY_CELL_PRAISE_IMG] forState:UIControlStateNormal];
    }

    return _praiseBtn;
}

- (UIButton *)commentBtn {
    if (!_commentBtn) {
        _commentBtn = [[UIButton alloc] init];
        [_commentBtn setBackgroundImage:[UIImage imageNamed:COMMUNITY_CELL_COMMENT_IMG] forState:UIControlStateNormal];
    }

    return _commentBtn;
}

- (UIView *)underline {
    if (!_underline) {
        _underline = [[UIView alloc] init];
        [_underline setBackgroundColor: COMMUNITY_CELL_UNDERLINE_COLOR];
    }
    return _underline;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
