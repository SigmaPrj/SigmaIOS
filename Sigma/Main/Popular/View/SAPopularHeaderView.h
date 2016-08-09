//
//  SAPopularHeaderView.h
//  Sigma
//
//  Created by Terence on 16/7/14.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SAPopularHeaderViewDelegate <NSObject>

-(void)sourceButtonInHeadViewClicked;

-(void)classButtonClicked;

-(void)popularQuestionBtnClicked;

-(void)teamButtonClicked:(UIButton *)btn;

@end

@interface SAPopularHeaderView : UIView

@property(nonatomic,weak)id<SAPopularHeaderViewDelegate> delegate;

@end
