//
//  SAPublishViewButton.m
//  Sigma
//
//  Created by Terence on 16/7/17.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAPublishViewButton.h"
#import "UIView+SAPublishBtnFrame.h"
@implementation SAPublishViewButton


-(void)awakeFromNib{
    [self setUp];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setUp];
    }
    
    return self;
}

-(void)setUp{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.titleLabel.font = [UIFont systemFontOfSize:14];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.height;
}
@end
