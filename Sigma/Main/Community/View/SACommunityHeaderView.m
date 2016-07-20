//
//  SACommunityHeaderView.m
//  Sigma
//
//  Created by 汤轶侬 on 16/7/15.
//  Copyright (c) 2016 Terence. All rights reserved.
//

#import "SACommunityHeaderView.h"
#import "View+MASAdditions.h"

#define COMMUNITY_HEADER_VIEW_AVATAR_BOTTOM_PADDING 18
#define COMMUNITY_HEADER_VIEW_AVATAR_FONT_SIZE 18
#define COMMUNITY_HEADER_VIEW_NAME_PADDING_RIGHT 8
#define COMMUNITY_HEADER_VIEW_NAME_PADDING_BOTTOM 3
#define COMMUNITY_HEADER_VIEW_AVATAR_SIZE 60

@interface SACommunityHeaderView()

@property (nonatomic, strong) UIImageView *backgroundImage;
@property (nonatomic, strong) UIImageView *avatarImage;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation SACommunityHeaderView

- (instancetype) initWithUsername:(NSString *)user_name
                          bgImage:(NSString *)bgImage
                      avatarImage:(NSString *)avatarImage {
    self = [self init];
    if (self) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = user_name;
        _nameLabel.font = [UIFont systemFontOfSize:COMMUNITY_HEADER_VIEW_AVATAR_FONT_SIZE];

        NSString *bgImagePath = [[NSBundle mainBundle] pathForResource:bgImage ofType:nil];
        _backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:bgImagePath]];

        _avatarImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:avatarImage]];
        _avatarImage.layer.borderWidth = COMMUNITY_BORDER_WIDTH;
        _avatarImage.layer.borderColor = COMMUNITY_BORDER_COLOR.CGColor;
        _avatarImage.layer.cornerRadius = COMMUNITY_HEADER_VIEW_AVATAR_SIZE/2;
        _avatarImage.layer.masksToBounds = YES;

        [self addSubview:_backgroundImage];
        [self addSubview:_nameLabel];
        [self addSubview:_avatarImage];
    }

    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {

    }

    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.backgroundImage mas_remakeConstraints:^(MASConstraintMaker *maker) {
        maker.edges.equalTo(self);
    }];

    [self.avatarImage mas_remakeConstraints:^(MASConstraintMaker *maker) {
        maker.right.equalTo(self.mas_right).with.offset(-COMMUNITY_PADDING);
        maker.bottom.equalTo(self.mas_bottom).with.offset(COMMUNITY_HEADER_VIEW_AVATAR_BOTTOM_PADDING);
        maker.width.height.mas_equalTo(COMMUNITY_HEADER_VIEW_AVATAR_SIZE);
    }];

    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *maker) {
        maker.right.equalTo(self.avatarImage.mas_left).with.offset(COMMUNITY_HEADER_VIEW_NAME_PADDING_RIGHT);
        maker.bottom.equalTo(self.avatarImage.mas_centerY).with.offset(COMMUNITY_HEADER_VIEW_NAME_PADDING_BOTTOM);
    }];

    [super updateConstraints];
}

@end
