//
//  SAFriendCell.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/10.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SAFriendCell.h"
#import "SAFriendFrameModel.h"
#import "UIImageView+WebCache.h"
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
#define NICKNAME_COLOR [UIColor blackColor]
#define NICKNAME_APPROVED_COLOR [UIColor colorWithRed:0.95 green:0.43 blue:0.07 alpha:1.00]
#define NOIMPORTANT_COLOR [UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.00]
#define SCHOOL_COLOR [UIColor colorWithRed:0.99 green:0.58 blue:0.16 alpha:1.00]

@interface SAFriendCell()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nicknameLabel;
@property (nonatomic, strong) UIImageView *vipImageView;
@property (nonatomic, strong) UILabel *schoolLabel;
@property (nonatomic, strong) UILabel *onlineLabel;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *underline;

@end

@implementation SAFriendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, CELL_HEIGHT);
        self.backgroundColor = [UIColor whiteColor];

        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.nicknameLabel];
    [self.contentView addSubview:self.schoolLabel];
    [self.contentView addSubview:self.vipImageView];
    [self.contentView addSubview:self.onlineLabel];
    [self.contentView addSubview:self.maskView];
    [self.contentView addSubview:self.underline];
}

- (void)setFrameModel:(SAFriendFrameModel *)frameModel {
    _frameModel = frameModel;

    [self setupFrame];
    [self setupData];
}

- (void)setupFrame {
    self.avatarImageView.frame = self.frameModel.avatarImageViewFrame;
    self.nicknameLabel.frame = self.frameModel.nicknameLabelFrame;
    self.vipImageView.frame = self.frameModel.vipImageViewFrame;
    self.schoolLabel.frame = self.frameModel.schoolLabelFrame;
    self.onlineLabel.frame = self.frameModel.onlineLabelFrame;
}

- (void)setupData {
    SAFriendModel *friendModel = self.frameModel.friendModel;

    // 头像
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:friendModel.avatar] placeholderImage:[UIImage imageNamed:@"avatar40"]];

    // 昵称
    self.nicknameLabel.text = friendModel.nickname;
    if (self.frameModel.isVip) {
        self.nicknameLabel.textColor = NICKNAME_APPROVED_COLOR;
    } else {
        self.nicknameLabel.textColor = NICKNAME_COLOR;
    }

    // 学校
    self.schoolLabel.text = friendModel.school;

    // 状态
    if (self.frameModel.isOnline) {
        self.onlineLabel.text = @"[在线]";
        self.maskView.hidden = YES;
    } else {
        self.onlineLabel.text = @"[离线]";
        self.maskView.hidden = NO;
    }

}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(PADDING_LEFT, (CELL_HEIGHT-AVATAR_SIZE)/2, AVATAR_SIZE, AVATAR_SIZE)];
        _avatarImageView.layer.cornerRadius = AVATAR_SIZE/2;
        _avatarImageView.layer.backgroundColor = [UIColor grayColor].CGColor;
        _avatarImageView.clipsToBounds = YES;
    }
    return _avatarImageView;
}

- (UIImageView *)vipImageView {
    if (!_vipImageView) {
        _vipImageView = [[UIImageView alloc] init];
        _vipImageView.image = [UIImage imageNamed:@"vip"];
    }
    return _vipImageView;
}

- (UILabel *)nicknameLabel {
    if (!_nicknameLabel) {
        _nicknameLabel = [[UILabel alloc] init];
        _nicknameLabel.font = [UIFont systemFontOfSize:NICKNAME_FONT_SIZE];
        _nicknameLabel.textColor = NICKNAME_COLOR;
    }
    return _nicknameLabel;
}

- (UILabel *)schoolLabel {
    if (!_schoolLabel) {
        _schoolLabel = [[UILabel alloc] init];
        _schoolLabel.font = [UIFont italicSystemFontOfSize:SCHOOL_FONT_SIZE];
        _schoolLabel.textColor = SCHOOL_COLOR;
    }
    return _schoolLabel;
}

- (UILabel *)onlineLabel {
    if (!_onlineLabel) {
        _onlineLabel = [[UILabel alloc] init];
        _onlineLabel.font = [UIFont systemFontOfSize:ONLINE_FONT_SIZE];
        _onlineLabel.textColor = NOIMPORTANT_COLOR;
    }
    return _onlineLabel;
}

- (UIView *)underline {
    if (!_underline) {
        _underline = [[UIView alloc] initWithFrame:CGRectMake(PADDING_LEFT+AVATAR_SIZE+AVATAR_PADDING_RIGHT, 0, (SCREEN_WIDTH-(PADDING_LEFT+AVATAR_SIZE+AVATAR_PADDING_RIGHT)-PADDING_LEFT), 0.5)];
        _underline.backgroundColor = SIGMA_BG_COLOR;
    }
    return _underline;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CELL_HEIGHT)];
        _maskView.backgroundColor = [UIColor whiteColor];
        _maskView.alpha = 0.4;
    }
    return _maskView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
