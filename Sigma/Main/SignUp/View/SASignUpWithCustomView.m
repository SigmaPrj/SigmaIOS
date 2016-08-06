//
//  SASignUpWithCustomView.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/1.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SASignUpWithCustomView.h"

#define TITLE_LABEL_MARGIN_TOP 25
#define TITLE_LABEL_HEIGHT 30
#define TITLE_LABEL_FONT_SIZE 26
#define TITLE_LABEL_MARGIN_BOTTOM 45
#define TEXT_FIELD_HEIGHT 40

@interface SASignUpWithCustomView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UIView *leftUsernameView;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIView *leftPasswordView;
@property (nonatomic, strong) UITextField *cpasswordTextField;
@property (nonatomic, strong) UIView *leftCPasswordView;
@property (nonatomic, strong) UIButton *registerBtn;

@end

@implementation SASignUpWithCustomView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    [self addSubview:self.titleLabel];
    [self addSubview:self.usernameTextField];
    UIView *underline1 = [[UIView alloc] initWithFrame:CGRectMake(15, MaxY(self.usernameTextField), SCREEN_WIDTH-30, 0.5)];
    underline1.backgroundColor = SIGMA_BG_COLOR;
    [self addSubview:underline1];
    [self addSubview:self.passwordTextField];
    UIView *underline2 = [[UIView alloc] initWithFrame:CGRectMake(15, MaxY(self.passwordTextField), SCREEN_WIDTH-30, 0.5)];
    underline2.backgroundColor = SIGMA_BG_COLOR;
    [self addSubview:underline2];
    [self addSubview:self.cpasswordTextField];
    UIView *underline3 = [[UIView alloc] initWithFrame:CGRectMake(15, MaxY(self.cpasswordTextField), SCREEN_WIDTH-30, 0.5)];
    underline3.backgroundColor = SIGMA_BG_COLOR;
    [self addSubview:underline3];
    [self addSubview:self.registerBtn];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, TITLE_LABEL_MARGIN_TOP, SCREEN_WIDTH, TITLE_LABEL_HEIGHT)];
        _titleLabel.text = @"请输入你的用户名";
        _titleLabel.font = [UIFont systemFontOfSize:TITLE_LABEL_FONT_SIZE];
        _titleLabel.textColor = SIGMA_FONT_COLOR;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIView *)leftUsernameView {
    if (!_leftUsernameView) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"username"]];
        imageView.frame = CGRectMake(15, (TEXT_FIELD_HEIGHT-18)/2, 18, 18);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(imageView), 0, 40, TEXT_FIELD_HEIGHT)];
        label.font = [UIFont systemFontOfSize:18];
        label.text = @"名称";
        label.textAlignment = NSTextAlignmentCenter;
        UIView *rightLine = [[UILabel alloc] initWithFrame:CGRectMake(15+WIDTH(imageView)+WIDTH(label)+3-0.5, (TEXT_FIELD_HEIGHT-20)/2, 0.5, 20)];
        rightLine.backgroundColor = SIGMA_FONT_COLOR;

        _leftUsernameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15+WIDTH(imageView)+WIDTH(label)+13, TEXT_FIELD_HEIGHT)];
        [_leftUsernameView addSubview:imageView];
        [_leftUsernameView addSubview:label];
        [_leftUsernameView addSubview:rightLine];
    }
    return _leftUsernameView;
}

- (UITextField *)usernameTextField {
    if (!_usernameTextField) {
        _usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, MaxY(self.titleLabel)+TITLE_LABEL_MARGIN_BOTTOM, SCREEN_WIDTH, TEXT_FIELD_HEIGHT)];
        _usernameTextField.borderStyle = UITextBorderStyleNone;
        _usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _usernameTextField.leftView = self.leftUsernameView;
        _usernameTextField.leftViewMode = UITextFieldViewModeAlways;
        _usernameTextField.keyboardType = UIKeyboardTypeDefault;
        _usernameTextField.placeholder = @"请输入自定义用户名,非中文";
    }
    return _usernameTextField;
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
        _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, MaxY(self.usernameTextField), SCREEN_WIDTH, TEXT_FIELD_HEIGHT)];
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


- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, MaxY(self.cpasswordTextField)+30, 200, 44)];
        [_registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:SIGMA_FONT_COLOR forState:UIControlStateNormal];
        [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        _registerBtn.layer.borderWidth = 2;
        _registerBtn.layer.borderColor = SIGMA_FONT_COLOR.CGColor;
        _registerBtn.layer.cornerRadius = 22;
        _registerBtn.clipsToBounds = YES;
        [_registerBtn setBackgroundImage:[UIImage imageNamed:@"small_active_bg"] forState:UIControlStateHighlighted];
        [_registerBtn addTarget:self action:@selector(registerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}

-(void)registerBtnClicked:(UIButton *)btn {
    // TODO : 自定义账号注册
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.cpasswordTextField resignFirstResponder];
}

@end
