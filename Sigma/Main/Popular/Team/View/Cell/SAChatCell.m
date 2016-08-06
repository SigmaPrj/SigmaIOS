//
//  SAChatCell.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/5.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SAChatCell.h"
#import "SAChatFrameModel.h"
#import "SAMessageModel.h"
#import "SAChatModel.h"
#import "UIImageView+WebCache.h"
#import "SAUserDataManager.h"

#define DATE_LABEL_HEIGHT 20
#define DATE_MARGIN 6
#define DATE_PADDING_TOP 3
#define DATE_PADDING_LEFT 4
#define DATE_FONT_SIZE 12
#define L_AVATAR_PADDING_LEFT 10
#define AVATAR_SIZE 40
#define SMALL_MARGIN 2
#define MESSAGE_FONT_SIZE 15

@interface SAChatCell()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIButton *messageLabel;

@end

@implementation SAChatCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ChatBackground"]];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.messageLabel];
}

- (void)setFrameModel:(SAChatFrameModel *)frameModel {
    _frameModel = frameModel;
    [self setupFrame];
    [self setupData];
}

- (void)setupFrame {
    self.avatarImageView.frame  = self.frameModel.avatarImageViewFrame;
    self.dateLabel.frame = self.frameModel.dateLabelFrame;
    self.messageLabel.frame = self.frameModel.messageLabelFrame;
}

- (void)setupData {
    SAMessageModel *messageModel = self.frameModel.messageModel;
    SAChatModel *chatModel = self.frameModel.chatModel;

    if (messageModel.user_id != chatModel.fromUser) {
        // 加载左侧用户头像
        [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:messageModel.avatar] placeholderImage:[UIImage imageNamed:@"avatar40"]];
    } else {
        NSString *imageUrl = [SAUserDataManager readUser][@"image"];
        [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"avatar40"]];
    }

    self.dateLabel.text = chatModel.date;

    [self.messageLabel setTitle:chatModel.message forState:UIControlStateNormal];
    [self.messageLabel setTitleColor:SIGMA_FONT_COLOR forState:UIControlStateNormal];

    if (messageModel.user_id != chatModel.fromUser) {
        UIImage *image = [UIImage imageNamed:@"chat_left"];
        [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height-5, image.size.width/2, image.size.height-5, image.size.width/2) resizingMode:UIImageResizingModeTile];
        [self.messageLabel setBackgroundImage:image forState:UIControlStateNormal];
        _messageLabel.contentEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 10);
    } else {
        UIImage *image = [UIImage imageNamed:@"chat_right"];
        [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height/2, image.size.width/2, image.size.height/2, image.size.width/2) resizingMode:UIImageResizingModeTile];
        [self.messageLabel setBackgroundImage:image forState:UIControlStateNormal];

        _messageLabel.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 30);
    }
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.layer.cornerRadius = 3;
        _dateLabel.clipsToBounds = YES;
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.backgroundColor = [UIColor colorWithRed:0.81 green:0.81 blue:0.81 alpha:1.00];
        _dateLabel.textColor = [UIColor whiteColor];
        _dateLabel.font = [UIFont systemFontOfSize:DATE_FONT_SIZE];
    }
    return _dateLabel;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.borderWidth = 0.5;
        _avatarImageView.layer.borderColor = [UIColor colorWithHue:0 saturation:0 brightness:0.65 alpha:0.77].CGColor;
    }
    return _avatarImageView;
}

- (UIButton *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UIButton alloc] init];
    }
    return _messageLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
