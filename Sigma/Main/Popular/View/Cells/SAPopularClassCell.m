//
//  SAPolularClassCell.m
//  Sigma
//
//  Created by Terence on 16/7/15.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAPopularClassCell.h"
#import "SAPopularModel.h"
#import "TextEnhance.h"
#import "SAPopularClassModel.h"
#import "UIImageView+WebCache.h"


#define AVATAIMG_WIDTH 30
#define AVATAIMG_HEIGHT 30

@interface SAPopularClassCell ()

@property(nonatomic, strong) UIImageView* avataImage;
@property(nonatomic, strong) UIView* categoryView;
@property(nonatomic, strong) UIImageView* cellBackgroundImg;
@property(nonatomic, strong) UIImageView* quesVoiceImg;
@property(nonatomic, strong) UILabel* nickNameLabel;
@property(nonatomic, strong) UILabel* titleLabel;
@property(nonatomic, strong) UILabel* descLabel;
@property(nonatomic, strong) UILabel* numberLabel;

// SAPopularModel假数据将被替换
@property(nonatomic, strong) SAPopularModel* data;

@property(nonatomic, strong) SAPopularClassModel* classdata;

@end

@implementation SAPopularClassCell

/**
 *  重写InitWithStyle
 *
 *  @param style           <#style description#>
 *  @param reuseIdentifier <#reuseIdentifier description#>
 *
 *  @return <#return value description#>
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

//-(void)setData:(SAPopularModel *)data{
//    _data = data;
//}


-(void)setClassData:(SAPopularClassModel*)classdata{
    _classdata = classdata;
}

-(instancetype)initUI{
    [self addSubview:self.cellBackgroundImg];
//    [self addSubview:self.categoryView];
    [self.cellBackgroundImg addSubview:self.avataImage];
    [self.cellBackgroundImg addSubview:self.nickNameLabel];
    [self.cellBackgroundImg addSubview:self.titleLabel];
    [self.cellBackgroundImg addSubview:self.descLabel];
    [self.cellBackgroundImg addSubview:self.numberLabel];
    //    [self.cellBackgroundImg addSubview:self.quesVoiceImg];
    return self;
}


/**
 *  more按钮的点击事件
 *
 *  @param sender <#sender description#>
 */
-(void)moreBtnClicked:(id)sender{
    if (sender && [sender isKindOfClass:[UIButton class]]) {
        NSLog(@"more clicked");
    }
}

/**
 *  cell的背景图
 *
 *  @return <#return value description#>
 */
-(UIImageView*)cellBackgroundImg{
    if (!_cellBackgroundImg) {

//        _cellBackgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 250)];
//        _cellBackgroundImg.image = [UIImage imageNamed:self.data.cellBackgroundImgName];
        
//        _cellBackgroundImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:self.data.cellBackgroundImgName]];
        
        
        
        NSURL* url = [[NSURL alloc] initWithString:self.classdata.bg_image];
        
        _cellBackgroundImg = [[UIImageView alloc]initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:url]]];
        
        _cellBackgroundImg.frame = CGRectMake(15, 0, SCREEN_WIDTH-30, _cellBackgroundImg.image.size.height/2);
        
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-30, _cellBackgroundImg.image.size.height/2)];
        view.backgroundColor = COLOR_RGBA(0, 0, 0, 0.4);
        [_cellBackgroundImg addSubview:view];

        
    }
    
    return _cellBackgroundImg;
}

/**
 *  个人头像图片
 *
 *  @return <#return value description#>
 */
-(UIImageView*)avataImage{
    if (!_avataImage) {
        _avataImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, AVATAIMG_WIDTH, AVATAIMG_HEIGHT)];
        
//        [_avataImage setImage:[UIImage imageNamed:self.data.AvataImgName]];
        
        NSURL* url = [[NSURL alloc] initWithString:self.classdata.avata];
        [_avataImage sd_setImageWithURL:url];
        
        // img显示为圆形
        _avataImage.layer.cornerRadius = _avataImage.frame.size.width/2;
        _avataImage.layer.masksToBounds=YES;
    }
    return _avataImage;
}


/**
 *  昵称label
 *
 *  @return <#return value description#>
 */
-(UILabel*)nickNameLabel{
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, 250, 30)];
        _nickNameLabel.textColor = [UIColor whiteColor];
        [_nickNameLabel setFont:[UIFont systemFontOfSize:12.f]];
//        [_nickNameLabel setText:self.data.nickName];
        [_nickNameLabel setText:self.classdata.nickname];
        
    }
    return _nickNameLabel;
}


/**
 *  标题label
 *
 *  @return <#return value description#>
 */
-(UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, self.cellBackgroundImg.frame.size.width, 30)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        [_titleLabel setText:self.data.title];
        [_titleLabel setText:self.classdata.title];
    }
    
    return _titleLabel;
}

/**
 *  描述label
 *
 *  @return <#return value description#>
 */
- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.cellBackgroundImg.frame.size.width-275)/2, (CGFloat)((200-40)/2)+45, 275, 40)];
//        _descLabel.text = self.data.desc;
        
        _descLabel.text = self.classdata.desc;
        _descLabel.textColor = [UIColor whiteColor];
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.numberOfLines = 2;
        _descLabel.font = [UIFont systemFontOfSize:13];
    }
    
    return _descLabel;
}

/**
 *  图标
 *
 *  @return <#return value description#>
 */
-(UIImageView*)quesVoiceImg{
    if (!_quesVoiceImg) {
        _quesVoiceImg = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 100, 200, 30)];
        [_quesVoiceImg setImage:[UIImage imageNamed:@"voice.png"]];
    }
    
    return _quesVoiceImg;
}

/**
 *  数字label，显示多少人学习
 *
 *  @return
 */
-(UILabel*)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 15, 80, 30)];
        //        _joinLabel.text = [NSString stringWithFormat:@"%d人参与讨论", self.data.comments];
//        _numberLabel.text = [NSString stringWithFormat:@"%d人学习",self.data.number];
        
        _numberLabel.text = [NSString stringWithFormat:@"%d人学习",self.classdata.learn];
        _numberLabel.textColor = [UIColor whiteColor];
        [_numberLabel setFont:[UIFont systemFontOfSize:12.f]];
        
        [TextEnhance resizeUILabelWidth:_numberLabel];
        CGRect rect = _numberLabel.frame;
        //        rect.origin.x = (SCREEN_WIDTH-_numberLabel.frame.size.width)/2;
        rect.origin.x = SCREEN_WIDTH-_numberLabel.frame.size.width-60;
        _numberLabel.frame = rect;
    }
    
    return _numberLabel;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
