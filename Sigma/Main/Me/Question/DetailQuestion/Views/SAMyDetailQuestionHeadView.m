//
//  SAMyDetailQuestionHeadView.m
//  Sigma
//
//  Created by Ace Hsieh on 8/5/16.
//  Copyright © 2016 sigma. All rights reserved.
//

#import "SAMyDetailQuestionHeadView.h"
#import "UIImageView+WebCache.h"

#import "SAUser.h"
#import "SAMineViewEngine.h"

#define MARGIN 15
#define PADDING 5
#define IMG_SIZE 40

@interface SAMyDetailQuestionHeadView ()

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *nameLabel;
//@property(nonatomic,strong)UILabel *introLabel;
//@property(nonatomic,strong)UILabel *supportLabel;
@property(nonatomic,strong)SAUser* user;


@end

@implementation SAMyDetailQuestionHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.user = [[SAMineViewEngine shareInstance] mineGetUser];

        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.imageView];
    [self addSubview:self.nameLabel];
//    [self addSubview:self.supportLabel];
//    [self addSubview:self.introLabel];
}

-(UIImageView*)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(MARGIN, PADDING, IMG_SIZE, IMG_SIZE)];
        
        NSURL *avatarImageUrl = [NSURL URLWithString:self.user.headImageName];
        [_imageView sd_setImageWithURL:avatarImageUrl placeholderImage:[UIImage imageNamed:@"avatar60"] options:SDWebImageRetryFailed | SDWebImageProgressiveDownload];
        
        _imageView.layer.borderWidth = 1;
        _imageView.layer.borderColor = COMMUNITY_BORDER_COLOR.CGColor;
        _imageView.layer.cornerRadius = IMG_SIZE/2;
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}

-(UILabel*)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView.frame)+PADDING, IMG_SIZE/2-PADDING, 100, 20)];
        _nameLabel.text = self.user.userName;
        [_nameLabel setTextColor:[UIColor colorWithRed:74/255. green:81/255. blue:101/255. alpha:1.0]];
        [_nameLabel setFont:[UIFont systemFontOfSize:14.f]];
    }
    return _nameLabel;
}

//-(UILabel*)introLabel{
//    if (_introLabel == nil) {
//        _introLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView.frame), CGRectGetMaxY(self.nameLabel.frame)+5, 180, 20)];
//        _introLabel.text = @"从互联网行业出来在做旅行的前对冲基金从业者";
//        [_introLabel setTextColor:[UIColor grayColor]];
//        [_introLabel setFont:[UIFont systemFontOfSize:14.f]];
//    }
//    return _introLabel;
//}


//-(UILabel*)supportLabel{
//    if (_supportLabel == nil) {
//        _supportLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50, 15, 40, 20)];
//        _supportLabel.text = @"4753";
//        [_supportLabel setFont:[UIFont systemFontOfSize:14.f]];
//    }
//    return _supportLabel;
//}



@end
