//
//  SACustomTabBar.m
//  Sigma
//
//  Created by Terence on 16/7/13.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SACustomTabBar.h"

@interface SACustomTabBar ()
@property(nonatomic, strong)UIButton *plusBtn;
@end

@implementation SACustomTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


/**
*  plusbtn的延时加载, 中间的加号
*
*  @return plusBtn
*/
-(UIButton*)plusBtn{
    if (!_plusBtn) {
        _plusBtn = [[UIButton alloc] init];
        [_plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_icon_add.png"] forState:UIControlStateNormal];
//        _plusBtn.backgroundColor = [UIColor colorWithRed:1  green:0.510  blue:0 alpha:1];
        _plusBtn.backgroundColor = [UIColor blackColor];
        [_plusBtn addTarget:self action:@selector(plusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _plusBtn;
}



-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = self.bounds.size.width/(self.items.count+1);
    CGFloat btnH = self.bounds.size.height;
    
    int i = 0;
    
    // 布局除了plus以外其他tabbar的位置
    for (UIView* tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i==2) {
                i = 3;
            }
            btnX = i*btnW;
            tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
            i++;
        }
    }
    
    
    
    self.plusBtn.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    self.plusBtn.bounds = CGRectMake(0, 0, 34, 34);
    [self addSubview:self.plusBtn];
    
    NSLog(@"%@",NSStringFromCGPoint(self.center));
    
}



/**
 *  tabbar 中间的 plusbtn的 点击事件
 *
 *  @param sender <#sender description#>
 */
-(void)plusBtnClick:(UIButton *)sender{
    self.clickBlock();
}
@end
