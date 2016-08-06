//
//  SATeamChatBar.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/5.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SATeamChatBar.h"

#define CHAT_BAR_HEIGHT 50
#define BUTTON_SIZE 34
#define TEXTFIELD_HEIGHT 38

@interface SATeamChatBar()

@property (nonatomic, strong) UIButton * leftBtn;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *expressBtn;
@property (nonatomic, strong) UIButton *moreBtn;

@end

@implementation SATeamChatBar

- (void)reset {
    [self.textField resignFirstResponder];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
        [self setupUI];

        [self addAllNotifications];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.leftBtn];
    [self addSubview:self.textField];
    [self addSubview:self.expressBtn];
    [self addSubview:self.moreBtn];
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(4, (CHAT_BAR_HEIGHT-BUTTON_SIZE)/2, BUTTON_SIZE, BUTTON_SIZE)];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"chat_voice"] forState:UIControlStateNormal];
    }
    return _leftBtn;
}

- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-BUTTON_SIZE-4, (CHAT_BAR_HEIGHT-BUTTON_SIZE)/2, BUTTON_SIZE, BUTTON_SIZE)];
        [_moreBtn setBackgroundImage:[UIImage imageNamed:@"chat_more"] forState:UIControlStateNormal];
    }
    return _moreBtn;
}

- (UIButton *)expressBtn {
    if (!_expressBtn) {
        _expressBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-2*BUTTON_SIZE-12, (CHAT_BAR_HEIGHT-BUTTON_SIZE)/2, BUTTON_SIZE, BUTTON_SIZE)];
        [_expressBtn setBackgroundImage:[UIImage imageNamed:@"chat_express"] forState:UIControlStateNormal];
    }
    return _expressBtn;
}

- (UITextField *)textField {
    if (!_textField) {
        CGFloat tfWidth = MinX(self.expressBtn)-8-(MaxY(self.leftBtn)+8);
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(MaxY(self.leftBtn)+8, (CHAT_BAR_HEIGHT-TEXTFIELD_HEIGHT)/2, tfWidth, TEXTFIELD_HEIGHT)];
        _textField.backgroundColor = [UIColor whiteColor];
//        _textField.borderStyle = UITextBorderStyleNone;
        _textField.layer.borderColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.91 alpha:1.00].CGColor;
        _textField.layer.borderWidth = 1;
        _textField.layer.cornerRadius = 4;
    }
    return _textField;
}

- (void)dealloc {
    [self removeAllNotifications];
}

#pragma mark -
#pragma mark notifications
- (void)addAllNotifications {

}

- (void)removeAllNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
