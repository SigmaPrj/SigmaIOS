//
//  SAPopularHeaderView.m
//  Sigma
//
//  Created by Terence on 16/7/14.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAPopularHeaderView.h"
#import "SAPopularShowView.h"
#import "Masonry.h"
#import "SourceSubViewController.h"

#define SCROLLVIEW_HTIGHT (160)
#define BTNBARTITLE_TOP_OFFSET (10)
#define BTNBARVIEW_HEIGHT (120)
#define QUESTION_BTN_LEFT_OFFSET (15)
#define BTN_WIDTH (50)
#define BTN_HEIGHT (50)
@interface SAPopularHeaderView ()


@property(nonatomic, strong)UIView* btnBarView;
@property(nonatomic, strong)UILabel* btnBarTitle;

// 四个btnview
@property(nonatomic, strong)UIView* questionBtnView;
@property(nonatomic, strong)UIView* classBtnView;
@property(nonatomic, strong)UIView* resourceBtnView;
@property(nonatomic, strong)UIView* eventBtnView;

// scrollView
@property(nonatomic, strong)UIScrollView* scrollView;
@property(nonatomic, strong)SAPopularShowView* showView;


@end


@implementation SAPopularHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    
    return self;
}

/**
 *  初始化UI
 */
-(void)initUI{
    //    [self addSubview:self.scrollView];
    
    [self addSubview:self.btnBarView];
    [self addSubview:self.showView];
    [self.btnBarView addSubview:self.btnBarTitle];
    [self.btnBarView addSubview:self.questionBtnView];
    [self.btnBarView addSubview:self.classBtnView];
    [self.btnBarView addSubview:self.resourceBtnView];
    [self.btnBarView addSubview:self.eventBtnView];
    
}



-(UIView*)btnBarView{
    if (!_btnBarView) {
        _btnBarView = [[UIView alloc] initWithFrame:CGRectMake(0, SCROLLVIEW_HTIGHT, SCREEN_WIDTH, BTNBARVIEW_HEIGHT)];
        
        _btnBarView.backgroundColor = [UIColor whiteColor];
        UIView* topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        topLine.backgroundColor = [UIColor blackColor];
        [_btnBarView addSubview:topLine];
        
        UIView* bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, BTNBARVIEW_HEIGHT, SCREEN_WIDTH, 0.5)];
        bottomLine.backgroundColor = [UIColor blackColor];
        [_btnBarView addSubview:bottomLine];
    }
    
    return _btnBarView;
}

-(UIView*)questionBtnView{
    if (!_questionBtnView) {
        _questionBtnView = [[UIView alloc] initWithFrame:CGRectMake(QUESTION_BTN_LEFT_OFFSET, 35, 60, 80)];
        //        _questionBtnView.backgroundColor = [UIColor yellowColor];
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 50, 20)];
        [label setFont:[UIFont systemFontOfSize:12.f]];
        label.textAlignment = NSTextAlignmentCenter;
        [label setText:@"问答"];
        
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BTN_WIDTH, BTN_WIDTH)];
<<<<<<< HEAD
        [button setImage:[UIImage imageNamed:@"infinityicon.png"] forState:UIControlStateNormal];
        
        //添加点击事件
        [button addTarget:self action:@selector(popularQuestionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//        button.backgroundColor = [UIColor grayColor];
=======
        [button setImage:[UIImage imageNamed:@"btn-question.png"] forState:UIControlStateNormal];
        
        //添加点击事件
        [button addTarget:self action:@selector(popularQuestionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        //        button.backgroundColor = [UIColor grayColor];
>>>>>>> terence
        [_questionBtnView addSubview:label];
        [_questionBtnView addSubview:button];
    }
    
    return _questionBtnView;
}

-(UIView*)classBtnView{
    if (!_classBtnView) {
        _classBtnView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-QUESTION_BTN_LEFT_OFFSET*2-BTN_WIDTH*4)/3+QUESTION_BTN_LEFT_OFFSET+BTN_WIDTH, 35, 60, 80)];
        //        _classBtnView.backgroundColor = [UIColor yellowColor];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 50, 20)];
        [label setFont:[UIFont systemFontOfSize:12.f]];
        label.textAlignment = NSTextAlignmentCenter;
        [label setText:@"课程"];
        
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BTN_WIDTH, BTN_WIDTH)];
        [button setImage:[UIImage imageNamed:@"btn-course.png"] forState:UIControlStateNormal];
        //添加点击事件
        [button addTarget:self action:@selector(classBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        //        button.backgroundColor = [UIColor grayColor];
        [_classBtnView addSubview:label];
        [_classBtnView addSubview:button];
    }
    return _classBtnView;
}

//实现课程按钮的点击事件
-(void)classBtnClicked:(id)sender{
    if(sender && [sender isKindOfClass:[UIButton class]]){
        if(self.delegate && [self.delegate respondsToSelector:@selector(classButtonClicked)]){
            [self.delegate classButtonClicked];
        }
    }
}

-(void)popularQuestionBtnClicked:(id)sender{
    if(sender && [sender isKindOfClass:[UIButton class]]){
        if(self.delegate && [self.delegate respondsToSelector:@selector(popularQuestionBtnClicked)]){
            [self.delegate popularQuestionBtnClicked];
        }
    }
}

-(UIView*)resourceBtnView{
    if (!_resourceBtnView) {
        _resourceBtnView = [[UIView alloc] initWithFrame:CGRectMake(2*(SCREEN_WIDTH-QUESTION_BTN_LEFT_OFFSET*2-BTN_WIDTH*4)/3+QUESTION_BTN_LEFT_OFFSET+2*BTN_WIDTH, 35, 60, 80)];
        //        _resourceBtnView.backgroundColor = [UIColor yellowColor];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 50, 20)];
        [label setFont:[UIFont systemFontOfSize:12.f]];
        label.textAlignment = NSTextAlignmentCenter;
        [label setText:@"资源"];
        
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BTN_WIDTH, BTN_WIDTH)];
        [button setImage:[UIImage imageNamed:@"btn-resource.png"] forState:UIControlStateNormal];
        //        button.backgroundColor = [UIColor grayColor];
        
        [button addTarget:self action:@selector(sourceButtonInHeadViewClicked:) forControlEvents:UIControlEventTouchUpInside ];
        
        [_resourceBtnView addSubview:label];
        [_resourceBtnView addSubview:button];
    }
    return _resourceBtnView;
}

-(void)sourceButtonInHeadViewClicked:(id)sender{
    if(sender && [sender isKindOfClass:[UIButton class]]){
        if(self.delegate && [self.delegate respondsToSelector:@selector(sourceButtonInHeadViewClicked)]){
            [self.delegate sourceButtonInHeadViewClicked];
        }
    }
}

-(UIView*)eventBtnView{
    if (!_eventBtnView) {
        _eventBtnView = [[UIView alloc] initWithFrame:CGRectMake(3*(SCREEN_WIDTH-QUESTION_BTN_LEFT_OFFSET*2-BTN_WIDTH*4)/3+QUESTION_BTN_LEFT_OFFSET+3*BTN_WIDTH, 35, 60, 80)];
        //        _eventBtnView.backgroundColor = [UIColor yellowColor];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 50, 20)];
        [label setFont:[UIFont systemFontOfSize:12.f]];
        label.textAlignment = NSTextAlignmentCenter;
        [label setText:@"队伍"];
        
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BTN_WIDTH, BTN_WIDTH)];
        [button setImage:[UIImage imageNamed:@"btn-team.png"] forState:UIControlStateNormal];
        //        button.backgroundColor = [UIColor grayColor];
        [_eventBtnView addSubview:label];
        [_eventBtnView addSubview:button];
    }
    return _eventBtnView;
}



-(UILabel*)btnBarTitle{
    if (!_btnBarTitle) {
        _btnBarTitle = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, BTNBARTITLE_TOP_OFFSET, 100,20)];
        [_btnBarTitle setText:@"精选"];
        _btnBarTitle.textAlignment = NSTextAlignmentCenter;
        [_btnBarTitle setFont:[UIFont systemFontOfSize:15.f]];
    }
    
    return _btnBarTitle;
}

-(SAPopularShowView*)showView{
    if (!_showView) {
        _showView = [[SAPopularShowView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCROLLVIEW_HTIGHT) num:5 filename:@"popular" width:300 height:8];
    }
    return _showView;
}

@end
