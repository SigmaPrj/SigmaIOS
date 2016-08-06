//
//  SACommentCell.m
//  Sigma
//
//  Created by 汤轶侬 on 16/7/28.
//  Copyright (c) 2016 blackcater. All rights reserved.
//

#import "SACommentCell.h"
#import "SACommentFrameModel.h"
#import "UIImageView+WebCache.h"
#import "SACommentModel.h"

#define COMMENT_AVATAR_BORDER_WIDTH 0.5
#define COMMENT_AVATAR_BORDER_COLOR [UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.00]
#define COMMENT_NICKNAME_COLOR [UIColor blackColor]
#define COMMENT_NICKNAME_APPROVED_COLOR [UIColor colorWithRed:0.95 green:0.43 blue:0.07 alpha:1.00]
#define COMMENT_NOIMPORTANT_COLOR [UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.00]
#define COMMENT_SCHOOL_COLOR [UIColor colorWithRed:0.99 green:0.58 blue:0.16 alpha:1.00]
#define COMMENT_COMMENT_COLOR [UIColor colorWithRed:0.11 green:0.11 blue:0.11 alpha:1.00]
#define COMMENT_UNDERLINE_COLOR [UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1.00]
#define COMMENT_REPLAY_NICKANME_COLOR [UIColor colorWithRed:0.30 green:0.50 blue:0.69 alpha:1.00]

@interface SACommentCell()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nicknameLabel;
@property (nonatomic, strong) UIImageView *approvedImageView;
@property (nonatomic, strong) UILabel *schoolLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UIButton *praiseBtn;
@property (nonatomic, strong) UILabel *praiseLabel;
@property (nonatomic, strong) UIView *underline;

@end
@implementation SACommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

/*!
 * 初始化cell组件
 */
- (void)initUI {
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.nicknameLabel];
    [self.contentView addSubview:self.approvedImageView];
    [self.contentView addSubview:self.schoolLabel];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.commentLabel];
    [self.contentView addSubview:self.praiseBtn];
    [self.contentView addSubview:self.praiseLabel];
    [self.contentView addSubview:self.underline];
}

/*!
 * 添加所有cell frame值
 */
- (void)initFrame {
    // 头像
    self.avatarImageView.frame = self.frameModel.avatarFrame;

    // nickname
    self.nicknameLabel.frame = self.frameModel.nicknameFrame;

    // vip
    self.approvedImageView.frame = self.frameModel.approvedFrame;

    // school
    self.schoolLabel.frame = self.frameModel.schoolFrame;

    // date
    self.dateLabel.frame = self.frameModel.dateFrame;

    // comment
    self.commentLabel.frame = self.frameModel.commentFrame;

    // btn
    self.praiseBtn.frame = self.frameModel.praiseBtnFrame;

    // praise label
    self.praiseLabel.frame = self.frameModel.praiseLabelFrame;

    // underline
    self.underline.frame = self.frameModel.underlineFrame;
}

/*!
 * 设置cell所有组件的 数据值
 */
- (void)initData {
    SACommentModel *commentModel = self.frameModel.commentModel;
    // avatar
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:commentModel.avatar] placeholderImage:[UIImage imageNamed:@"avatar30"] options:SDWebImageRetryFailed | SDWebImageProgressiveDownload];

    // nickname
    self.nicknameLabel.text = commentModel.nickname;
    if (self.frameModel.isApproved) {
        self.nicknameLabel.textColor = COMMENT_NICKNAME_APPROVED_COLOR;
    } else {
        self.nicknameLabel.textColor = COMMENT_NICKNAME_COLOR;
    }

    // school
    self.schoolLabel.text = commentModel.school;

    // date
    self.dateLabel.text = commentModel.publish_date;

    // TODO : FIXED ME
    // comment
    if (self.frameModel.hasReplay) {
        NSString *comments = [NSString stringWithFormat:@"@%@: %@", commentModel.replayNickname, commentModel.comment];
        NSMutableAttributedString *commentsString = [[NSMutableAttributedString alloc] initWithString:comments];
        NSUInteger replayOffset = (commentModel.replayNickname.length+2);
        [commentsString addAttribute:NSForegroundColorAttributeName value:COMMENT_REPLAY_NICKANME_COLOR range:NSMakeRange(0, replayOffset)];
        self.commentLabel.attributedText = commentsString;
    } else {
        self.commentLabel.text = commentModel.comment;
        self.commentLabel.textColor = COMMENT_COMMENT_COLOR;
    }

    // praise label
    self.praiseLabel.text = [NSString stringWithFormat:@"%d", commentModel.praise];
}

- (void)setFrameModel:(SACommentFrameModel *)frameModel {
    _frameModel = frameModel;

    [self initFrame];
    [self initData];
}


/**
 * 惰性加载
 */
- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.borderWidth = COMMENT_AVATAR_BORDER_WIDTH;
        _avatarImageView.layer.borderColor = COMMENT_AVATAR_BORDER_COLOR.CGColor;
        _avatarImageView.layer.cornerRadius = COMMENT_CELL_AVATAR_SIZE/2;
        _avatarImageView.layer.masksToBounds = YES;
    }
    return _avatarImageView;
}

- (UILabel *)nicknameLabel {
    if (!_nicknameLabel) {
        _nicknameLabel = [[UILabel alloc] init];
        _nicknameLabel.textColor = COMMENT_NICKNAME_COLOR;
        _nicknameLabel.font = [UIFont systemFontOfSize:COMMENT_NICKNAME_FONT_SIZE];
    }
    return _nicknameLabel;
}

- (UIImageView *)approvedImageView {
    if (!_approvedImageView) {
        _approvedImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vip"]];
        _approvedImageView.frame = CGRectZero;
    }
    return _approvedImageView;
}

- (UILabel *)schoolLabel {
    if (!_schoolLabel) {
        _schoolLabel = [[UILabel alloc] init];
        _schoolLabel.textColor = COMMENT_SCHOOL_COLOR;
        _schoolLabel.font = [UIFont italicSystemFontOfSize:COMMENT_SCHOOL_FONT_SIZE];
    }
    return _schoolLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = COMMENT_NOIMPORTANT_COLOR;
        _dateLabel.font = [UIFont systemFontOfSize:COMMENT_DATE_FONT_SIZE];
    }
    return _dateLabel;
}

- (UILabel *)commentLabel {
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = [UIFont systemFontOfSize:COMMENT_COMMENT_FONT_SIZE];
        _commentLabel.numberOfLines = 0;
    }
    return _commentLabel;
}

- (UIButton *)praiseBtn {
    if (!_praiseBtn) {
        _praiseBtn = [[UIButton alloc] init];
        [_praiseBtn setBackgroundImage:[UIImage imageNamed:@"common_praise_light_normal"] forState:UIControlStateNormal];
        [_praiseBtn setBackgroundImage:[UIImage imageNamed:@"common_praise_light_selected"] forState:UIControlStateHighlighted];
        // TODO : 处理点赞点击事件
    }
    return _praiseBtn;
}

- (UILabel *)praiseLabel {
    if (!_praiseLabel) {
        _praiseLabel = [[UILabel alloc] init];
        _praiseLabel.textColor = COMMENT_COMMENT_COLOR;
        _praiseLabel.font = [UIFont systemFontOfSize:COMMENT_COMMENT_FONT_SIZE];
    }
    return _praiseLabel;
}

- (UIView *)underline {
    if (!_underline) {
        _underline = [[UIView alloc] init];
        _underline.backgroundColor = COMMENT_UNDERLINE_COLOR;
    }
    return _underline;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
