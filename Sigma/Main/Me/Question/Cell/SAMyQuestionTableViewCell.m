//
//  SAQuestionTableViewCell.m
//  Sigma
//
//  Created by Ace Hsieh on 7/27/16.
//  Copyright © 2016 blackcater. All rights reserved.
//

#import "SAMyQuestionTableViewCell.h"

#import "SAMyQuestionCell.h"

#define MARGIN 15
#define PADDING 5
#define IMG_SIZE 40

@interface SAMyQuestionTableViewCell ()

@property(nonatomic, strong)UIImageView* headImgView;
@property(nonatomic, strong)UILabel* titleLabel;
@property(nonatomic, strong)UILabel* detailLabel;
@property(nonatomic, strong)UILabel* popularityLabel;

@end

@implementation SAMyQuestionTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initUI];
    }
    
    return self;
}


-(void)initUI{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UIView* maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-MARGIN*2, 130)];
    self.layer.cornerRadius = 6.f;
    self.layer.masksToBounds = YES;
    [self.contentView addSubview:maskView];
    
    [maskView addSubview:self.headImgView];
    [maskView addSubview:self.titleLabel];
    [maskView addSubview:self.detailLabel];
    [maskView addSubview:self.popularityLabel];
}

-(UIImageView*)headImgView{
    
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame)+PADDING, IMG_SIZE, IMG_SIZE)];
        _headImgView.layer.cornerRadius = 10.f;
        _headImgView.layer.masksToBounds = YES;
        
    }
    return _headImgView;
}

-(UILabel*)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(PADDING*2, PADDING*2, SCREEN_WIDTH-PADDING*2, 16)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        
        [_titleLabel setTextColor:[UIColor colorWithRed:74/255. green:81/255. blue:101/255. alpha:1.0]];
        
        
        [_titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14.f]];
    }
    return _titleLabel;
}

-(UILabel*)popularityLabel{
    
    if (!_popularityLabel) {
        _popularityLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.headImgView.frame)+PADDING/2, CGRectGetMaxY(self.headImgView.frame)+PADDING/2, IMG_SIZE-PADDING, MARGIN)];
        _popularityLabel.backgroundColor = [UIColor colorWithRed:55/255. green:144/255. blue:248/255. alpha:1.0];
        [_popularityLabel setTextColor:[UIColor whiteColor]];
        [_popularityLabel setFont:[UIFont systemFontOfSize:11.f]];
        
        _popularityLabel.layer.cornerRadius = 5.f;
        _popularityLabel.layer.masksToBounds = YES;
        
        _popularityLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _popularityLabel;
}

-(UILabel*)detailLabel{
    
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(PADDING+CGRectGetMaxX(self.headImgView.frame), CGRectGetMaxY(self.titleLabel.frame), SCREEN_WIDTH-CGRectGetMaxY(self.headImgView.frame)-MARGIN, 100)];
        _detailLabel.backgroundColor = [UIColor clearColor];
        [_detailLabel setTextColor:[UIColor grayColor]];
        
        [_detailLabel setFont:[UIFont systemFontOfSize:14.f]];
        _detailLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _detailLabel.numberOfLines = 0;
        
    }
    return _detailLabel;
}


-(void)showMyQuestionCell{
    self.headImgView.image = [UIImage imageNamed:self.data.headImgName];
    self.titleLabel.text=self.data.title;
    self.detailLabel.text=self.data.detail;
    self.popularityLabel.text=self.data.popularity;
}

@end
