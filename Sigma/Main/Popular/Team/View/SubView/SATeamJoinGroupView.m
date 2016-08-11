//
//  SATeamJoinGroupView.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/11.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SATeamJoinGroupView.h"

#define PADDING_LEFT 15

@interface SATeamJoinGroupView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *groupTextField;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *sureBtn;

@end

@implementation SATeamJoinGroupView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;

    [self addSubview:self.titleLabel];
    [self addSubview:self.subTitleLabel];

    [self addSubview:self.usernameTextField];

    UIView *underline1 = [[UIView alloc] initWithFrame:CGRectMake(PADDING_LEFT, (CGFloat)(MaxY(self.usernameTextField)+2), WIDTH(self.usernameTextField), 0.5)];
    underline1.backgroundColor = SIGMA_FONT_COLOR;
    [self addSubview:underline1];

    [self addSubview:self.groupTextField];

    UIView *underline2 = [[UIView alloc] initWithFrame:CGRectMake(PADDING_LEFT, (CGFloat)(MaxY(self.groupTextField)+2), WIDTH(self.groupTextField), 0.5)];
    underline2.backgroundColor = SIGMA_FONT_COLOR;
    [self addSubview:underline2];

    [self addSubview:self.cancelBtn];
    [self addSubview:self.sureBtn];

    self.frame = CGRectMake(0, 0, WIDTH(self), MaxY(self.sureBtn)+10);
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.frame.size.width, 20)];
        _titleLabel.text = @"邀请入队";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = SIGMA_FONT_COLOR;
        _titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, MaxY(self.titleLabel)+8, WIDTH(self), 16)];
        _subTitleLabel.text = @"请输入你要添加的好友的用户名";
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel.textColor = SIGMA_FONT_COLOR;
        _subTitleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _subTitleLabel;
}

- (UITextField *)usernameTextField {
    if (!_usernameTextField) {
        _usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(PADDING_LEFT, MaxY(self.subTitleLabel)+15, WIDTH(self)-2*PADDING_LEFT, 18)];
        _usernameTextField.placeholder = @"请输入好友用户名";
        _usernameTextField.textColor = SIGMA_FONT_COLOR;
        _usernameTextField.textAlignment = NSTextAlignmentCenter;
        _usernameTextField.font = [UIFont systemFontOfSize:16];
        _usernameTextField.borderStyle = UITextBorderStyleNone;
    }
    return _usernameTextField;
}

- (UITextField *)groupTextField {
    if (!_groupTextField) {
        _groupTextField = [[UITextField alloc] initWithFrame:CGRectMake(PADDING_LEFT, MaxY(self.usernameTextField)+8, WIDTH(self)-2*PADDING_LEFT, 18)];
        _groupTextField.placeholder = @"请输入队伍id";
        _groupTextField.textColor = SIGMA_FONT_COLOR;
        _groupTextField.textAlignment = NSTextAlignmentCenter;
        _groupTextField.font = [UIFont systemFontOfSize:16];
        _groupTextField.borderStyle = UITextBorderStyleNone;
    }
    return _groupTextField;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(PADDING_LEFT, MaxY(self.groupTextField)+15, 100, 30)];
        _cancelBtn.layer.cornerRadius = 15;
        _cancelBtn.layer.borderColor = SIGMA_FONT_COLOR.CGColor;
        _cancelBtn.layer.borderWidth = 1;
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:SIGMA_FONT_COLOR forState:UIControlStateNormal];

        [_cancelBtn addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH(self)-2*PADDING_LEFT-100, MaxY(self.groupTextField)+15, 100, 30)];
        _sureBtn.layer.cornerRadius = 15;
        _sureBtn.layer.borderColor = SIGMA_FONT_COLOR.CGColor;
        _sureBtn.layer.borderWidth = 1;
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:SIGMA_FONT_COLOR forState:UIControlStateNormal];

        [_sureBtn addTarget:self action:@selector(sureBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (void)cancelBtnClicked:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(joinCustomView:cancelBtnDidClicked:)]) {
        [self.delegate joinCustomView:self cancelBtnDidClicked:self.cancelBtn];
    }
}

- (void)sureBtnClicked:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(joinCustomView:sureBtnDidClicked:group:username:)]) {
        [self.delegate joinCustomView:self sureBtnDidClicked:self.sureBtn group:self.groupTextField.text username:self.usernameTextField.text];
    }
}

@end
