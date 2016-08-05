//
//  SAMessageCell.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/5.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SAMessageCell.h"
#import "SAMessageFrameModel.h"
#import "UIImageView+WebCache.h"
#import "SAMessageModel.h"

#define CELL_HEIGHT 75-0.5
#define BUTTON_SIZE 74
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
#define NICKNAME_COLOR [UIColor blackColor]
#define NICKNAME_APPROVED_COLOR [UIColor colorWithRed:0.95 green:0.43 blue:0.07 alpha:1.00]
#define SCHOOL_COLOR [UIColor colorWithRed:0.99 green:0.58 blue:0.16 alpha:1.00]

@interface SAMessageCell() <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *delBtn;
@property (nonatomic, strong) UIButton *topBtn;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nicknameLabel;
@property (nonatomic, strong) UIImageView *approvedImageView;
@property (nonatomic, strong) UILabel *schoolLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIView *underline;

@end

@implementation SAMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.coverView addSubview:self.avatarImageView];
    [self.coverView addSubview:self.nicknameLabel];
    [self.coverView addSubview:self.approvedImageView];
    [self.coverView addSubview:self.schoolLabel];
    [self.coverView addSubview:self.dateLabel];
    [self.coverView addSubview:self.messageLabel];
    [self.scrollView addSubview:self.coverView];
    [self.contentView addSubview:self.delBtn];
    [self.contentView addSubview:self.topBtn];
    [self.contentView addSubview:self.scrollView];
    [self.contentView addSubview:self.underline];
}

- (void)setupFrame {
    _avatarImageView.frame = self.frameModel.avatarImageViewFrame;
    _nicknameLabel.frame = self.frameModel.nicknameLabelFrame;
    _dateLabel.frame = self.frameModel.dateLabelFrame;
    _schoolLabel.frame = self.frameModel.schoolLabelFrame;
    _approvedImageView.frame = self.frameModel.approvedImageViewFrame;
    _messageLabel.frame = self.frameModel.messageLabelFrame;
}

- (void)setupData {
    SAMessageModel *messageModel = self.frameModel.messageModel;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:messageModel.avatar] placeholderImage:[UIImage imageNamed:@"avatar60"]];

    self.nicknameLabel.text = messageModel.nickname;

    if (self.frameModel.isApproved) {
        self.nicknameLabel.textColor = NICKNAME_APPROVED_COLOR;
    } else {
        self.nicknameLabel.textColor = NICKNAME_COLOR;
    }

    self.dateLabel.text = messageModel.date;

    self.schoolLabel.text = messageModel.school;

    self.messageLabel.text = messageModel.message;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.frame = CGRectMake(AVATAR_PADDING_LEFT, AVATAR_PADDING_TOP, AVATAR_SIZE, AVATAR_SIZE);
        _avatarImageView.layer.cornerRadius = AVATAR_SIZE/2;
        _avatarImageView.clipsToBounds = YES;
    }
    return _avatarImageView;
}

- (UILabel *)nicknameLabel {
    if (!_nicknameLabel) {
        _nicknameLabel = [[UILabel alloc] init];
        _nicknameLabel.textColor = SIGMA_FONT_COLOR;
        _nicknameLabel.font = [UIFont systemFontOfSize:NICKNAME_FONT_SIZE];
    }
    return _nicknameLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = SIGMA_BG_COLOR;
        _dateLabel.font = [UIFont systemFontOfSize:MESSAGE_FONT_SIZE];
    }
    return _dateLabel;
}

- (UILabel *)schoolLabel {
    if (!_schoolLabel) {
        _schoolLabel = [[UILabel alloc] init];
        _schoolLabel.textColor = SCHOOL_COLOR;
        _schoolLabel.font = [UIFont italicSystemFontOfSize:SCHOOL_FONT_SIZE];
    }
    return _schoolLabel;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.textColor = SIGMA_BG_COLOR;
        _messageLabel.font = [UIFont systemFontOfSize:MESSAGE_FONT_SIZE];
    }
    return _messageLabel;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (CGFloat)(CELL_HEIGHT-0.5))];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH+2*BUTTON_SIZE, 0);
        _scrollView.contentOffset = CGPointMake(0, 0);
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (CGFloat)(CELL_HEIGHT-0.5))];
        _coverView.backgroundColor = [UIColor whiteColor];
    }
    return _coverView;
}

- (UIButton *)delBtn {
    if (!_delBtn) {
        _delBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-BUTTON_SIZE, 0, BUTTON_SIZE, BUTTON_SIZE)];
        _delBtn.backgroundColor = [UIColor colorWithRed:0.99 green:0.24 blue:0.22 alpha:1.00];
        [_delBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_delBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _delBtn;
}

- (UIButton *)topBtn {
    if (!_topBtn) {
        _topBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-2*BUTTON_SIZE, 0, BUTTON_SIZE, BUTTON_SIZE)];
        _topBtn.backgroundColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.80 alpha:1.00];
        [_topBtn setTitle:@"置顶" forState:UIControlStateNormal];
        [_topBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _topBtn;
}

- (UIView *)underline {
    if (!_underline) {
        CGFloat underlineX = AVATAR_PADDING_LEFT+AVATAR_SIZE+AVATAR_PADDING_RIGHT;
        _underline = [[UIView alloc] initWithFrame:CGRectMake(underlineX, (CGFloat)(CELL_HEIGHT-0.5), SCREEN_WIDTH-underlineX, 0.5)];
        _underline.backgroundColor = SIGMA_BG_COLOR;
    }
    return _underline;
}

- (void)setFrameModel:(SAMessageFrameModel *)frameModel {
    _frameModel = frameModel;
    [self setupFrame];
    [self setupData];
}

#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // TODO : 代理事件
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
