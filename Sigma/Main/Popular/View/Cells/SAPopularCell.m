//
//  SAPopularCell.m
//  Sigma
//
//  Created by Terence on 16/7/15.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAPopularCell.h"
#import "SAPopularModel.h"
#import "TextEnhance.h"
#import "SAPopularQuestionModel.h"
#import "UIImageView+WebCache.h"

#define AVATAIMG_WIDTH 30
#define AVATAIMG_HEIGHT 30
@interface SAPopularCell ()

@property(nonatomic, strong) UIImageView* avataImage;
@property(nonatomic, strong) UIView* categoryView;
@property(nonatomic, strong) UIImageView* cellBackgroundImg;
@property(nonatomic, strong) UIButton* quesVoiceBtn;
@property(nonatomic, strong) UILabel* nickNameLabel;
@property(nonatomic, strong) UILabel* titleLabel;
@property(nonatomic, strong) UILabel* descLabel;
@property(nonatomic, strong) UILabel* numberLabel;

// SAPopularModel是模拟的 model，之后会用后台的数据替换
//@property(nonatomic, strong) SAPopularModel* data;

// SAPopularQuestionModel 从后台获取数据生成的model
@property(nonatomic, strong) SAPopularQuestionModel *quesdata;


@end

@implementation SAPopularCell



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

-(void)setQuesData:(SAPopularQuestionModel *)quesdata{
    _quesdata = quesdata;
}

-(instancetype)initUI{
    [self.contentView addSubview:self.cellBackgroundImg];
//    [self addSubview:self.categoryView];
    [self.cellBackgroundImg addSubview:self.avataImage];
    [self.cellBackgroundImg addSubview:self.nickNameLabel];
    [self.cellBackgroundImg addSubview:self.titleLabel];
    [self.cellBackgroundImg addSubview:self.descLabel];
    [self.cellBackgroundImg addSubview:self.numberLabel];
    [self.cellBackgroundImg addSubview:self.quesVoiceBtn];
    return self;
}


/**
 *  more按钮的点击事件，需要抛出代理给controller完成界面跳转功能
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
        
//        +(UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
//        {
//            CIContext *context = [CIContext contextWithOptions:nil];
//            CIImage *inputImage= [CIImage imageWithCGImage:image.CGImage];
//            //设置filter
//            CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
//            [filter setValue:inputImage forKey:kCIInputImageKey]; [filter setValue:@(blur) forKey: @"inputRadius"];
//            //模糊图片
//            CIImage *result=[filter valueForKey:kCIOutputImageKey];
//            CGImageRef outImage=[context createCGImage:result fromRect:[result extent]];
//            UIImage *blurImage=[UIImage imageWithCGImage:outImage];
//            CGImageRelease(outImage); 
//            return blurImage;
//        }
        
        
 
        
    
        _cellBackgroundImg.contentMode = UIViewContentModeScaleAspectFit;
        int quesbgnum = [self getRandomNumber:1 to:9];
        NSString* imagename = [NSString stringWithFormat:@"ques%d",quesbgnum];
        
        
        UIImage* bgimg = [UIImage imageNamed:imagename];
        // 初始化image
//        _cellBackgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imagename]];
        
        _cellBackgroundImg = [[UIImageView alloc] init];
        [_cellBackgroundImg setImage:bgimg];
        _cellBackgroundImg.frame = CGRectMake(15, 0, SCREEN_WIDTH-30, _cellBackgroundImg.image.size.height/2);
        
        
//        毛玻璃效果
//
//        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
//        effectView.frame = CGRectMake(0, 0, SCREEN_WIDTH-30, _cellBackgroundImg.image.size.height/2);
//        [_cellBackgroundImg addSubview:effectView];
        
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
        NSURL *url = [[NSURL alloc] initWithString:self.quesdata.avata];
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
 *  @return
 */
-(UILabel*)nickNameLabel{
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, 250, 30)];
        _nickNameLabel.textColor = [UIColor whiteColor];
        [_nickNameLabel setFont:[UIFont systemFontOfSize:12.f]];
//        [_nickNameLabel setText:self.data.nickName];
        [_nickNameLabel setText:self.quesdata.nickname];
        
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
        [_titleLabel setText:self.quesdata.topic];
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
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.cellBackgroundImg.frame.size.width-275)/2, (CGFloat)((180-40)/2)+45, 275, 40)];
//        NSLog(@"%f", self.data.cellHeight);
//        _descLabel.text = self.data.desc;
        _descLabel.text = self.quesdata.title;
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
-(UIButton*)quesVoiceBtn{
    if (!_quesVoiceBtn) {
        _quesVoiceBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.cellBackgroundImg.frame.size.width-50)/2, self.descLabel.frame.origin.y-40, 50, 50)];
        [_quesVoiceBtn setImage:[UIImage imageNamed:@"btn-voice4.png"] forState:UIControlStateNormal];
    }
    
    return _quesVoiceBtn;
}

/**
 *  数字label，显示多少人听过
 *
 *  @return
 */
-(UILabel*)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 15, 80, 30)];
//        _numberLabel.text = [NSString stringWithFormat:@"%d人听过",self.data.number];
        _numberLabel.text = [NSString stringWithFormat:@"%d人听过",self.quesdata.look];
        _numberLabel.textColor = [UIColor whiteColor];
        [_numberLabel setFont:[UIFont systemFontOfSize:12.f]];
        
        [TextEnhance resizeUILabelWidth:_numberLabel];
        CGRect rect = _numberLabel.frame;
        rect.origin.x = SCREEN_WIDTH-_numberLabel.frame.size.width-60;
        _numberLabel.frame = rect;
    }
    
    return _numberLabel;
}


/**
 *  产生随机数选取背景图
 *
 *  @param selected <#selected description#>
 *  @param animated <#animated description#>
 */
-(int)getRandomNumber:(int)from to:(int)to

{
    
    return (int)(from + (arc4random() % (to - from + 1)));
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


/**
 *  模糊背景
 */


@end
