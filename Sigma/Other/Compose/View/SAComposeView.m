//
//  SAComposeView.m
//  Sigma
//
//  Created by Terence on 16/7/25.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAComposeView.h"

@interface SAComposeView ()

@property(nonatomic, weak) UILabel *placeHolderLabel;

@end


@implementation SAComposeView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

-(UILabel*)placeHolderLabel{
    if (!_placeHolderLabel) {
        
        UILabel* label = [[UILabel alloc] init];
        
        label.textColor = [UIColor lightGrayColor];
        
        [self addSubview:label];
        
        _placeHolderLabel = label;
        

    }
    
    return _placeHolderLabel;
}

-(void)setFont:(UIFont *)font{
    
    [super setFont:font];
    
    self.placeHolderLabel.font = font;
    [self.placeHolderLabel sizeToFit];
}

-(void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    
    self.placeHolderLabel.text = placeHolder;
    
    // label的尺寸和文字一样    
    [self.placeHolderLabel sizeToFit];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [super layoutSubviews];
    
    //    self.placeholderLabel.y = 8; //设置UILabel 的 y值
    
    CGRect rect =  self.placeHolderLabel.frame;
    rect.origin.y = 8;
    rect.origin.x = 5;
    
    self.placeHolderLabel.frame = rect;

}

-(void)setHidePlaceHolder:(BOOL)hidePlaceHolder{
    _hidePlaceHolder = hidePlaceHolder;
    
    self.placeHolderLabel.hidden = hidePlaceHolder;
}


@end
