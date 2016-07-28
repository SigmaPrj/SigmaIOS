//
//  SADynamicTableViewCell.m
//  Sigma
//
//  Created by 汤轶侬 on 16/7/26.
//  Copyright (c) 2016 Terence. All rights reserved.
//

#import "SADynamicTableViewCell.h"
#import "SADynamicFrameModel.h"
#import "SADynamicModel.h"
#import "UIImageView+WebCache.h"

#define DYNAMIC_AVATAR_BORDER_WIDTH 1
#define DYNAMIC_AVATAR_BORDER_COLOR [UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.00]
#define DYNAMIC_NICKNAME_COLOR [UIColor blackColor]
#define DYNAMIC_NICKNAME_APPROVED_COLOR [UIColor colorWithRed:0.95 green:0.43 blue:0.07 alpha:1.00]
#define DYNAMIC_NOIMPORTANT_COLOR [UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.00]
#define DYNAMIC_SCHOOL_COLOR [UIColor colorWithRed:0.99 green:0.58 blue:0.16 alpha:1.00]
#define DYNAMIC_TOPIC_COLOR [UIColor colorWithRed:0.29 green:0.51 blue:0.69 alpha:1.00]
#define DYNAMIC_CONTENT_COLOR [UIColor colorWithRed:0.11 green:0.11 blue:0.11 alpha:1.00]
#define DYNAMIC_UNDERLINE_COLOR [UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1.00]

@interface SADynamicTableViewCell()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nicknameLabel;
@property (nonatomic, strong) UIImageView *approvedImageView;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *schoolLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) NSMutableArray<UIImageView *> *imagesViewArray;
@property (nonatomic, strong) UIButton *lookBtn;
@property (nonatomic, strong) UIButton *praiseBtn;
@property (nonatomic, strong) UIButton *commentBtn;
@property (nonatomic, strong) UIView *underline;

@end
@implementation SADynamicTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
        // 没有选中样式
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

/*!
 * 初始化界面
 */
- (void)initUI {
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.nicknameLabel];
    [self.contentView addSubview:self.approvedImageView];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.schoolLabel];
    [self.contentView addSubview:self.contentLabel];
    for (int i = 0; i < 6; ++i) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = DYNAMIC_NOIMPORTANT_COLOR;
        imageView.hidden = YES;
        [self.contentView addSubview:imageView];
        [self.imagesViewArray addObject:imageView];
    }
    [self.contentView addSubview:self.lookBtn];
    [self.contentView addSubview:self.praiseBtn];
    [self.contentView addSubview:self.commentBtn];
    [self.contentView addSubview:self.underline];
}

- (void)setFrameModel:(SADynamicFrameModel *)frameModel {
    _frameModel = frameModel;
    [self setupFrame];
    [self setupData];
}

/*!
 * 为所有组件赋frame
 */
- (void)setupFrame {
    // 用户图片
    self.avatarImageView.frame = self.frameModel.avatarFrame;

    // 用户名称
    self.nicknameLabel.frame = self.frameModel.nicknameFrame;

    // 认证图片
    self.approvedImageView.frame = self.frameModel.approvedFrame;

    // 发布日期
    self.dateLabel.frame = self.frameModel.dateFrame;

    // 学校
    self.schoolLabel.frame = self.frameModel.schoolFrame;

    // 发布内容
    self.contentLabel.frame = self.frameModel.contentFrame;

    // 附带图片
    for (int i = 0; i < 6; ++i) {
        UIImageView *imageView = (UIImageView *) self.imagesViewArray[(NSUInteger)i];
        if (i >= self.frameModel.dynamicModel.images.count) {
            imageView.frame = CGRectZero;
        } else {
            imageView.hidden = NO;
            imageView.frame = [self.frameModel.imagesFrame[(NSUInteger)i] CGRectValue];
        }
    }

    // 分享btn
    self.lookBtn.frame = self.frameModel.lookBtnFrame;

    // 赞btn
    self.praiseBtn.frame = self.frameModel.praiseBtnFrame;

    // 评论btn
    self.commentBtn.frame = self.frameModel.commentBtnFrame;

    // 下划线
    self.underline.frame = CGRectMake(DYNAMIC_CELL_PADDING, (CGFloat) ([self.frameModel getTotalHeight] - 0.5), SCREEN_WIDTH-2*DYNAMIC_CELL_PADDING, 0.5);
}

/*!
 * 为所有组件赋数据
 */
- (void)setupData {
    // 设置用户头像
    SADynamicModel *dynamicModel = self.frameModel.dynamicModel;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:dynamicModel.avatar] placeholderImage:[UIImage imageNamed:@"avatar40"] options:SDWebImageRetryFailed | SDWebImageProgressiveDownload];

    // 设置用户名称
    self.nicknameLabel.text = dynamicModel.nickname;

    // 用户被认证, 修改用户的昵称颜色
    if (self.frameModel.isApproved) {
        self.nicknameLabel.textColor = DYNAMIC_NICKNAME_APPROVED_COLOR;
    }

    // 设置日期
    self.dateLabel.text = dynamicModel.publish_date;

    // 设置学校
    self.schoolLabel.text = dynamicModel.school;

    // 设置评论和话题
    if (self.frameModel.hasTopic) {
        // 有评论
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"#%@#%@", dynamicModel.topic, dynamicModel.content]];
        NSUInteger topicLen = dynamicModel.topic.length+2;
        [attributedString addAttribute:NSForegroundColorAttributeName value:DYNAMIC_TOPIC_COLOR range:NSMakeRange(0, topicLen)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:DYNAMIC_CONTENT_COLOR range:NSMakeRange((topicLen+1), (attributedString.length-topicLen-1))];

        self.contentLabel.text = [attributedString string];
    } else {
        // 没评
        self.contentLabel.text = dynamicModel.content;
    }

    // 加载图片
    for (int i = 0; i < dynamicModel.images.count; ++i) {
        UIImageView *imageView = self.imagesViewArray[(NSUInteger)i];

        [imageView sd_setImageWithURL:dynamicModel.images[(NSUInteger)i] placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageProgressiveDownload];
    }
}

/*!
 * 设置头像
 * @return
 */
- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.cornerRadius = DYNAMIC_AVATAR_SIZE/2;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.borderWidth = DYNAMIC_AVATAR_BORDER_WIDTH;
        _avatarImageView.layer.borderColor = DYNAMIC_AVATAR_BORDER_COLOR.CGColor;
    }
    return _avatarImageView;
}

- (UILabel *)nicknameLabel {
    if (!_nicknameLabel) {
        _nicknameLabel = [[UILabel alloc] init];
        _nicknameLabel.font = [UIFont systemFontOfSize:DYNAMIC_USERNAME_FONT_SIZE];
        _nicknameLabel.textColor = DYNAMIC_NICKNAME_COLOR;
    }
    return _nicknameLabel;
}

- (UIImageView *)approvedImageView {
    if (!_approvedImageView) {
        _approvedImageView = [[UIImageView alloc] init];
        _approvedImageView.image = [UIImage imageNamed:@"vip"];
    }
    return _approvedImageView;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = [UIFont systemFontOfSize:DYNAMIC_SCHOOL_FONT_SIZE];
        _dateLabel.textColor = DYNAMIC_NOIMPORTANT_COLOR;
    }
    return _dateLabel;
}

- (UILabel *)schoolLabel {
    if (!_schoolLabel) {
        _schoolLabel = [[UILabel alloc] init];
        _schoolLabel.font = [UIFont italicSystemFontOfSize:DYNAMIC_SCHOOL_FONT_SIZE];
        _schoolLabel.textColor = DYNAMIC_SCHOOL_COLOR;
    }
    return _schoolLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:DYNAMIC_CONTENT_FONT_SIZE];
    }
    return _contentLabel;
}

/*!
 * 用于存放图片数组
 * @return
 */
- (NSMutableArray *)imagesViewArray {
    if (!_imagesViewArray) {
        _imagesViewArray = [NSMutableArray array];
    }
    return _imagesViewArray;
}

#pragma mark -
#pragma mark button 组
- (UIButton *)lookBtn {
    if (!_lookBtn) {
        _lookBtn = [self createButtonWithImage:@"share" activeImage:@"share-active"];
    }
    return _lookBtn;
}

- (UIButton *)praiseBtn {
    if (!_praiseBtn) {
        _praiseBtn = [self createButtonWithImage:@"love" activeImage:@"love-active"];
    }
    return _praiseBtn;
}

- (UIButton *)commentBtn {
    if (!_commentBtn) {
        _commentBtn = [self createButtonWithImage:@"comment" activeImage:@"comment-active"];
    }
    return _commentBtn;
}

- (UIView *)underline {
    if (!_underline) {
        _underline = [[UIView alloc] init];
        _underline.backgroundColor = DYNAMIC_UNDERLINE_COLOR;
    }
    return _underline;
}

- (UIButton *)createButtonWithImage:(NSString *)image activeImage:(NSString *)activeImage {
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:activeImage] forState:UIControlStateHighlighted];
    return btn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
