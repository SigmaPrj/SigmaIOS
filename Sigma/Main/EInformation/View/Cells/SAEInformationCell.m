//
//  SAEInformationCell.m
//  Sigma
//
//  Created by Terence on 16/7/18.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAEInformationCell.h"
#import "SAEInformationModel.h"
#import "TextEnhance.h"
#import "SAEInfoDetailModel.h"
#import "UIImageView+WebCache.h"

@interface SAEInformationCell ()

@property(nonatomic, strong)UIImageView* mainImgView;
@property(nonatomic, strong)UILabel* descLabel;
@property(nonatomic, strong)UILabel* numberLabel;
@property(nonatomic, strong)SAEInformationModel* data;
@property(nonatomic, strong)UIView* lineView;


@property(nonatomic, strong)SAEInfoDetailModel* detailModel;

@end

@implementation SAEInformationCell

/**
 *  重写initWithStyle
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
//        self.backgroundColor = [UIColor redColor];
    }
    
    return self;
}

/**
 *  设置数据
 *
 *  @param data 
 */
-(void)setData:(SAEInformationModel *)data{
    _data = data;
}

-(void)setDetailModel:(SAEInfoDetailModel *)data{
    _detailModel = data;
}

/**
 *  初始化UI
 *
 *  @return <#return value description#>
 */
-(instancetype)initUI{
    [self addSubview:self.mainImgView];
    [self addSubview:self.lineView];
    [self addSubview:self.descLabel];
    [self addSubview:self.numberLabel];
    return self;
}

/**
 *  图片懒加载
 *
 *  @return <#return value description#>
 */
-(UIImageView*)mainImgView{
    if (!_mainImgView) {
        _mainImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 90, 90)];
        
        NSURL *url = [[NSURL alloc] initWithString:self.detailModel.news_img];
        [_mainImgView sd_setImageWithURL:url];
        
        // 动态加载图片
//        [_mainImgView setImage:[UIImage imageNamed:self.data.mainImgName]];
        
//        [_mainImgView setImage:[UIImage imageNamed:@"competition1.png"]];
        _mainImgView.backgroundColor = [UIColor lightGrayColor];
        
    }
    return _mainImgView;
}

/**
 *  竞赛名懒加载
 *
 *  @return <#return value description#>
 */
-(UILabel*)descLabel{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.mainImgView.frame.size.width+35, 15, 240, 60)];
        [_descLabel setFont:[UIFont systemFontOfSize:14.f]];
//        _descLabel.text = @"第八届全国大学生数学竞赛";
        
//        _descLabel.text = self.data.desc;
        _descLabel.text = self.detailModel.news_title;
        
        _descLabel.textAlignment = NSTextAlignmentLeft;
        //自动折行设置
        _descLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        _descLabel.lineBreakMode = NSLineBreakByClipping;
//        _descLabel.lineBreakMode = UILineBreakModeWordWrap;
        _descLabel.tag = 2000;
        
        _descLabel.numberOfLines = 0;
        
    }
    
    return _descLabel;
}



-(UILabel*)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-20-100, 88, 100, 20)];
//        _numberLabel.backgroundColor = [UIColor redColor];
        
//        _numberLabel.text = [NSString stringWithFormat:@"%d浏览",self.data.number];
        _numberLabel.text = [NSString stringWithFormat:@"%d浏览",self.detailModel.news_look_number];
        
//        _numberLabel.text = [NSString stringWithFormat:@"%d浏览",10];
        _numberLabel.textColor = [UIColor colorWithRed:0.572  green:0.573  blue:0.572 alpha:1];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        [_numberLabel setFont:[UIFont systemFontOfSize:12.f]];
        [TextEnhance resizeUILabelWidth:_numberLabel];
        CGRect rect = _numberLabel.frame;
        rect.origin.x = SCREEN_WIDTH-_numberLabel.frame.size.width-40;
        _numberLabel.frame = rect;
        
    }
    
    return _numberLabel;
}


/**
 *  分隔线懒加载
 *
 *  @return <#return value description#>
 */
-(UIView*)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, 0.5)];
        _lineView.backgroundColor = [UIColor colorWithRed:0.572  green:0.573  blue:0.572 alpha:0.8];
    }
    
    return _lineView;
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
