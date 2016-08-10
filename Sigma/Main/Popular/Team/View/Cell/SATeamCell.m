//
//  SATeamCell.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/11.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SATeamCell.h"
#import "SATeamFrameModel.h"
#import "UIImageView+WebCache.h"
#import "SATeamModel.h"

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

@interface SATeamCell()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *teamNameLabelView;
@property (nonatomic, strong) UILabel *teamDescLabelView;
@property (nonatomic, strong) UIView *underline;

@end

@implementation SATeamCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.teamNameLabelView];
    [self.contentView addSubview:self.teamDescLabelView];
    [self.contentView addSubview:self.underline];
}

- (void)setFrameModel:(SATeamFrameModel *)frameModel {
    _frameModel = frameModel;

    [self setupFrame];
    [self setupData];
}

- (void)setupFrame {
    self.avatarImageView.frame = self.frameModel.avatarImageViewFrame;
    self.teamNameLabelView.frame = self.frameModel.nicknameLabelFrame;
    self.teamDescLabelView.frame = self.frameModel.descLabelFrame;
}

- (void)setupData {
    SATeamModel *teamModel = self.frameModel.teamModel;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:teamModel.avatar] placeholderImage:[UIImage imageNamed:@"avatar40"]];

    self.teamNameLabelView.text =  teamModel.teamName;

    self.teamDescLabelView.text = teamModel.teamDesc;
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

- (UILabel *)teamNameLabelView {
    if (!_teamNameLabelView) {
        _teamNameLabelView = [[UILabel alloc] init];
        _teamNameLabelView.font = [UIFont systemFontOfSize:NICKNAME_FONT_SIZE];
        _teamNameLabelView.textColor = NICKNAME_COLOR;
    }
    return _teamNameLabelView;
}

- (UILabel *)teamDescLabelView {
    if (!_teamDescLabelView) {
        _teamDescLabelView = [[UILabel alloc] init];
        _teamDescLabelView.font = [UIFont italicSystemFontOfSize:SCHOOL_FONT_SIZE];
        _teamDescLabelView.textColor = SCHOOL_COLOR;
    }
    return _teamDescLabelView;
}

- (UIView *)underline {
    if (!_underline) {
        _underline = [[UIView alloc] initWithFrame:CGRectMake(PADDING_LEFT+AVATAR_SIZE+AVATAR_PADDING_RIGHT, (CGFloat)(CELL_HEIGHT-0.5), (SCREEN_WIDTH-(PADDING_LEFT+AVATAR_SIZE+AVATAR_PADDING_RIGHT)-PADDING_LEFT), 0.5)];
        _underline.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.00];
    }
    return _underline;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
