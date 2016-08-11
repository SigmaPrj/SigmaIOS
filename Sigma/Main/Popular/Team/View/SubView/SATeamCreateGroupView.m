//
//  SATeamCreateGroupView.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/11.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SATeamCreateGroupView.h"

#define PADDING_LEFT 15

@interface SATeamCreateGroupView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UITextField *groupNameTextField;
@property (nonatomic, strong) UITextField *groupDescTextField;
@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *sureBtn;

@end

@implementation SATeamCreateGroupView

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

    [self addSubview:self.groupNameTextField];

    UIView *underline1 = [[UIView alloc] initWithFrame:CGRectMake(PADDING_LEFT, (CGFloat)(MaxY(self.groupNameTextField)+2), WIDTH(self.groupNameTextField), 0.5)];
    underline1.backgroundColor = SIGMA_FONT_COLOR;
    [self addSubview:underline1];

    [self addSubview:self.groupDescTextField];

    UIView *underline2 = [[UIView alloc] initWithFrame:CGRectMake(PADDING_LEFT, (CGFloat)(MaxY(self.groupDescTextField)+2), WIDTH(self.groupDescTextField), 0.5)];
    underline2.backgroundColor = SIGMA_FONT_COLOR;
    [self addSubview:underline2];

    [self addSubview:self.usernameTextField];

    UIView *underline3 = [[UIView alloc] initWithFrame:CGRectMake(PADDING_LEFT, (CGFloat)(MaxY(self.usernameTextField)+2), WIDTH(self.usernameTextField), 0.5)];
    underline3.backgroundColor = SIGMA_FONT_COLOR;
    [self addSubview:underline3];

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

- (UITextField *)groupNameTextField {
    if (!_groupNameTextField) {
        _groupNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(PADDING_LEFT, MaxY(self.subTitleLabel)+15, WIDTH(self)-2*PADDING_LEFT, 18)];
        _groupNameTextField.placeholder = @"请输入队伍名称";
        _groupNameTextField.textColor = SIGMA_FONT_COLOR;
        _groupNameTextField.textAlignment = NSTextAlignmentCenter;
        _groupNameTextField.font = [UIFont systemFontOfSize:16];
        _groupNameTextField.borderStyle = UITextBorderStyleNone;
    }
    return _groupNameTextField;
}

- (UITextField *)groupDescTextField {
    if (!_groupDescTextField) {
        _groupDescTextField = [[UITextField alloc] initWithFrame:CGRectMake(PADDING_LEFT, MaxY(self.groupNameTextField)+8, WIDTH(self)-2*PADDING_LEFT, 18)];
        _groupDescTextField.placeholder = @"请输入队伍简介";
        _groupDescTextField.textColor = SIGMA_FONT_COLOR;
        _groupDescTextField.textAlignment = NSTextAlignmentCenter;
        _groupDescTextField.font = [UIFont systemFontOfSize:16];
        _groupDescTextField.borderStyle = UITextBorderStyleNone;
    }
    return _groupDescTextField;
}

- (UITextField *)usernameTextField {
    if (!_usernameTextField) {
        _usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(PADDING_LEFT, MaxY(self.groupDescTextField)+8, WIDTH(self)-2*PADDING_LEFT, 18)];
        _usernameTextField.placeholder = @"请输入队长的用户名";
        _usernameTextField.textColor = SIGMA_FONT_COLOR;
        _usernameTextField.textAlignment = NSTextAlignmentCenter;
        _usernameTextField.font = [UIFont systemFontOfSize:16];
        _usernameTextField.borderStyle = UITextBorderStyleNone;
    }
    return _usernameTextField;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(PADDING_LEFT, MaxY(self.usernameTextField)+15, 100, 30)];
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
        _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH(self)-2*PADDING_LEFT-100, MaxY(self.usernameTextField)+15, 100, 30)];
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
    if ([self.delegate respondsToSelector:@selector(createCustomView:cancelBtnDidClicked:)]) {
        [self.delegate createCustomView:self cancelBtnDidClicked:self.cancelBtn];
    }
}

- (void)sureBtnClicked:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(createCustomView:sureBtnDidClicked:groupName:groupDesc:username:)]) {
        [self.delegate createCustomView:self sureBtnDidClicked:self.sureBtn groupName:self.groupNameTextField.text groupDesc:self.groupDescTextField.text username:self.usernameTextField.text];
    }
}

@end
