//
//  SASignUpSetPasswordView.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/8.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SASignUpSetPasswordView.h"
#import "SAValidator.h"
#import "JCAlertView.h"

#define TITLE_LABEL_MARGIN_TOP 25
#define TITLE_LABEL_HEIGHT 30
#define TITLE_LABEL_FONT_SIZE 26
#define TITLE_LABEL_MARGIN_BOTTOM 45
#define TEXT_FIELD_HEIGHT 40

@interface SASignUpSetPasswordView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIView *leftPasswordView;
@property (nonatomic, strong) UITextField *cpasswordTextField;
@property (nonatomic, strong) UIView *leftCPasswordView;
@property (nonatomic, strong) UIButton *nextStepBtn;

@end

@implementation SASignUpSetPasswordView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.titleLabel];
    [self addSubview:self.passwordTextField];
    UIView *underline2 = [[UIView alloc] initWithFrame:CGRectMake(15, MaxY(self.passwordTextField), SCREEN_WIDTH-30, 0.5)];
    underline2.backgroundColor = SIGMA_BG_COLOR;
    [self addSubview:underline2];
    [self addSubview:self.cpasswordTextField];
    UIView *underline3 = [[UIView alloc] initWithFrame:CGRectMake(15, MaxY(self.cpasswordTextField), SCREEN_WIDTH-30, 0.5)];
    underline3.backgroundColor = SIGMA_BG_COLOR;
    [self addSubview:underline3];
    [self addSubview:self.nextStepBtn];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, TITLE_LABEL_MARGIN_TOP, SCREEN_WIDTH, TITLE_LABEL_HEIGHT)];
        _titleLabel.text = @"请输入登录密码";
        _titleLabel.font = [UIFont systemFontOfSize:TITLE_LABEL_FONT_SIZE];
        _titleLabel.textColor = SIGMA_FONT_COLOR;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIView *)leftPasswordView {
    if (!_leftPasswordView) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
        imageView.frame = CGRectMake(15, (TEXT_FIELD_HEIGHT-18)/2, 18, 18);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(imageView), 0, 40, TEXT_FIELD_HEIGHT)];
        label.font = [UIFont systemFontOfSize:18];
        label.text = @"密码";
        label.textAlignment = NSTextAlignmentCenter;
        UIView *rightLine = [[UILabel alloc] initWithFrame:CGRectMake(15+WIDTH(imageView)+WIDTH(label)+3-0.5, (TEXT_FIELD_HEIGHT-20)/2, 0.5, 20)];
        rightLine.backgroundColor = SIGMA_FONT_COLOR;

        _leftPasswordView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15+WIDTH(imageView)+WIDTH(label)+13, TEXT_FIELD_HEIGHT)];
        [_leftPasswordView addSubview:imageView];
        [_leftPasswordView addSubview:label];
        [_leftPasswordView addSubview:rightLine];
    }
    return _leftPasswordView;
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, MaxY(self.titleLabel)+TITLE_LABEL_MARGIN_BOTTOM, SCREEN_WIDTH, TEXT_FIELD_HEIGHT)];
        _passwordTextField.borderStyle = UITextBorderStyleNone;
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.leftView = self.leftPasswordView;
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        _passwordTextField.keyboardType = UIKeyboardTypeDefault;
        _passwordTextField.placeholder = @"请输入密码";
    }
    return _passwordTextField;
}

- (UIView *)leftCPasswordView {
    if (!_leftCPasswordView) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
        imageView.frame = CGRectMake(15, (TEXT_FIELD_HEIGHT-18)/2, 18, 18);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(imageView), 0, 40, TEXT_FIELD_HEIGHT)];
        label.font = [UIFont systemFontOfSize:18];
        label.text = @"密码";
        label.textAlignment = NSTextAlignmentCenter;
        UIView *rightLine = [[UILabel alloc] initWithFrame:CGRectMake(15+WIDTH(imageView)+WIDTH(label)+3-0.5, (TEXT_FIELD_HEIGHT-20)/2, 0.5, 20)];
        rightLine.backgroundColor = SIGMA_FONT_COLOR;

        _leftCPasswordView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15+WIDTH(imageView)+WIDTH(label)+13, TEXT_FIELD_HEIGHT)];
        [_leftCPasswordView addSubview:imageView];
        [_leftCPasswordView addSubview:label];
        [_leftCPasswordView addSubview:rightLine];
    }
    return _leftCPasswordView;
}

- (UITextField *)cpasswordTextField {
    if (!_cpasswordTextField) {
        _cpasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, MaxY(self.passwordTextField), SCREEN_WIDTH, TEXT_FIELD_HEIGHT)];
        _cpasswordTextField.borderStyle = UITextBorderStyleNone;
        _cpasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _cpasswordTextField.secureTextEntry = YES;
        _cpasswordTextField.leftView = self.leftCPasswordView;
        _cpasswordTextField.leftViewMode = UITextFieldViewModeAlways;
        _cpasswordTextField.keyboardType = UIKeyboardTypeDefault;
        _cpasswordTextField.placeholder = @"请确认密码";
    }
    return _cpasswordTextField;
}

- (UIButton *)nextStepBtn {
    if (!_nextStepBtn) {
        _nextStepBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, MaxY(self.cpasswordTextField)+30, 200, 44)];
        [_nextStepBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextStepBtn setTitleColor:SIGMA_FONT_COLOR forState:UIControlStateNormal];
        [_nextStepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        _nextStepBtn.layer.borderWidth = 2;
        _nextStepBtn.layer.borderColor = SIGMA_FONT_COLOR.CGColor;
        _nextStepBtn.layer.cornerRadius = 22;
        _nextStepBtn.clipsToBounds = YES;
        [_nextStepBtn setBackgroundImage:[UIImage imageNamed:@"small_active_bg"] forState:UIControlStateHighlighted];
        [_nextStepBtn addTarget:self action:@selector(nextStepBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStepBtn;
}

- (void)nextStepBtnClicked:(UIButton *)btn {
    NSString *password = self.passwordTextField.text;
    NSString *cPassword = self.cpasswordTextField.text;

    [self.passwordTextField resignFirstResponder];
    [self.cpasswordTextField resignFirstResponder];

    if ([SAValidator isValidPassword:password] && [SAValidator isValidPassword:cPassword]) {
        if ([password isEqualToString:cPassword]) {
            if ([self.delegate respondsToSelector:@selector(nextStepBtnClicked: password:)]) {
                [self.delegate nextStepBtnClicked:self password:self.passwordTextField.text];
            }
        } else {
            [JCAlertView showOneButtonWithTitle:nil Message:@"密码不一致" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"知道了" Click:^{}];
        }
    } else {
        [JCAlertView showOneButtonWithTitle:nil Message:@"密码不符合规定" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"知道了" Click:^{}];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.passwordTextField resignFirstResponder];
    [self.cpasswordTextField resignFirstResponder];
}

@end
