//
//  SAMyDetailQuestionTableViewCell.m
//  Sigma
//
//  Created by Ace Hsieh on 8/5/16.
//  Copyright © 2016 sigma. All rights reserved.
//

#import "SAMyDetailQuestionTableViewCell.h"
#import "SAMyDetailQuestionData.h"

#define PADDING 15
#define MARGIN 30

@interface SAMyDetailQuestionTableViewCell ()

@property(nonatomic, strong)UIImageView* images;
@property(nonatomic, strong)UILabel* text;

@end

@implementation SAMyDetailQuestionTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self initUI];
    }
    
    return self;
}

-(void)initUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UIView* maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 8000)];
    
    [self.contentView addSubview:maskView];
    
    [maskView addSubview:self.text];
    [maskView addSubview:self.images];
    
}

-(UIImageView*)images{
    if (_images == nil) {
        _images = [[UIImageView alloc]init];
    }
    return _images;
}

-(UILabel*)text{
    if (_text == nil) {
        _text = [[UILabel alloc]init];
        [_text setFont:[UIFont systemFontOfSize:16.f]];
        [_text setTextColor:[UIColor colorWithRed:94/255. green:94/255. blue:94/255. alpha:1.0]];
        _text.numberOfLines = 0;
        _text.lineBreakMode = NSLineBreakByTruncatingTail;
        
    }
    return _text;
}

-(CGSize)sizeWithString:(NSString *)string font:(UIFont *)font

{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-40, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}
                                       context:nil];
    
    return rect.size;
}

-(void)showMyDetailQuestionCell{
    self.images.image = [UIImage imageNamed:self.data.imageName];
    self.text.text = self.data.text;
    CGSize size =  [self sizeWithString:self.text.text font:self.text.font];
    self.text.frame = CGRectMake(PADDING, PADDING, size.width, size.height);
    self.images.frame = CGRectMake(PADDING, size.height+PADDING*2, SCREEN_WIDTH-PADDING*2, 150);
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH-PADDING*2, size.height+150+2*PADDING);
}

@end
