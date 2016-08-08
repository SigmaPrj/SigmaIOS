//
//  SASignUpWithTelephoneView.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/1.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SASignUpWithTelephoneView.h"
#import "JCAlertView.h"
#import "JSMSSDK.h"
#import "CLProgressHUD.h"

#define TITLE_LABEL_MARGIN_TOP 25
#define TITLE_LABEL_HEIGHT 30
#define TITLE_LABEL_FONT_SIZE 26
#define TITLE_LABEL_MARGIN_BOTTOM 45
#define TEXT_FIELD_HEIGHT 40
#define CODE_TIME 60

@interface SASignUpWithTelephoneView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UIView *leftPhoneView;
@property (nonatomic, strong) UIView *leftCodeView;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) int codeTime;

@end

@implementation SASignUpWithTelephoneView

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
    [self addSubview:self.phoneTextField];
    UIView *underline1 = [[UIView alloc] initWithFrame:CGRectMake(15, MaxY(self.phoneTextField), SCREEN_WIDTH-30, 0.5)];
    underline1.backgroundColor = SIGMA_BG_COLOR;
    [self addSubview:underline1];
    [self addSubview:self.codeTextField];
    UIView *underline2 = [[UIView alloc] initWithFrame:CGRectMake(15, MaxY(self.codeTextField), SCREEN_WIDTH-30, 0.5)];
    underline2.backgroundColor = SIGMA_BG_COLOR;
    [self addSubview:underline2];
    [self addSubview:self.registerBtn];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, TITLE_LABEL_MARGIN_TOP, SCREEN_WIDTH, TITLE_LABEL_HEIGHT)];
        _titleLabel.text = @"请输入你的手机号码";
        _titleLabel.font = [UIFont systemFontOfSize:TITLE_LABEL_FONT_SIZE];
        _titleLabel.textColor = SIGMA_FONT_COLOR;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIView *)leftPhoneView {
    if (!_leftPhoneView) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phone"]];
        imageView.frame = CGRectMake(15, (TEXT_FIELD_HEIGHT-18)/2, 18, 18);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(imageView), 0, 40, TEXT_FIELD_HEIGHT)];
        label.font = [UIFont systemFontOfSize:18];
        label.text = @"手机";
        label.textAlignment = NSTextAlignmentCenter;
        UIView *rightLine = [[UILabel alloc] initWithFrame:CGRectMake(15+WIDTH(imageView)+WIDTH(label)+3-0.5, (TEXT_FIELD_HEIGHT-20)/2, 0.5, 20)];
        rightLine.backgroundColor = SIGMA_FONT_COLOR;

        _leftPhoneView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15+WIDTH(imageView)+WIDTH(label)+13, TEXT_FIELD_HEIGHT)];
        [_leftPhoneView addSubview:imageView];
        [_leftPhoneView addSubview:label];
        [_leftPhoneView addSubview:rightLine];
    }
    return _leftPhoneView;
}

- (UITextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, MaxY(self.titleLabel)+TITLE_LABEL_MARGIN_BOTTOM, SCREEN_WIDTH, TEXT_FIELD_HEIGHT)];
        _phoneTextField.borderStyle = UITextBorderStyleNone;
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTextField.leftView = self.leftPhoneView;
        _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.placeholder = @"请输入手机号码";
    }
    return _phoneTextField;
}

- (UIView *)leftCodeView {
    if (!_leftCodeView) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, 100, TEXT_FIELD_HEIGHT)];
        [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [btn setTitleColor:SIGMA_FONT_COLOR forState:UIControlStateNormal];
        [btn setTitleColor:SIGMA_BG_COLOR forState:UIControlStateSelected];

        [btn addTarget:self action:@selector(codeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

        UIView *rightLine = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH(btn)+15, (TEXT_FIELD_HEIGHT-20)/2, 0.5, 20)];
        rightLine.backgroundColor = SIGMA_FONT_COLOR;
        _leftCodeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(btn)+10+15, TEXT_FIELD_HEIGHT)];
        [_leftCodeView addSubview:btn];
        [_leftCodeView addSubview:rightLine];
    }
    return _leftCodeView;
}

- (UITextField *)codeTextField {
    if (!_codeTextField) {
        _codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, MaxY(self.phoneTextField), SCREEN_WIDTH, TEXT_FIELD_HEIGHT)];
        _codeTextField.borderStyle = UITextBorderStyleNone;
        _codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _codeTextField.leftView = self.leftCodeView;
        _codeTextField.leftViewMode = UITextFieldViewModeAlways;
        _codeTextField.keyboardType = UIKeyboardTypePhonePad;
        _codeTextField.placeholder = @"请输入短信验证码";
    }
    return _codeTextField;
}

- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, MaxY(self.codeTextField)+30, 200, 44)];
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

- (void)registerBtnClicked:(UIButton *)btn {
    // 手机注册
    if (self.codeTime == 0) {
        [JCAlertView showOneButtonWithTitle:@"注册提示" Message:@"你还没有请求验证码,或验证码已经过期" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"知道了" Click:^{
        }];
    } else {
        __weak typeof(self) weakSelf = self;
        [JSMSSDK commitWithPhoneNumber:weakSelf.phoneTextField.text verificationCode:weakSelf.codeTextField.text completionHandler:^(id resultObject, NSError *error) {
            if (!error) {
                if ([weakSelf.delegate respondsToSelector:@selector(phoneRegisterBtnClicked: phone:)]) {
                    [weakSelf.delegate phoneRegisterBtnClicked:weakSelf phone:weakSelf.phoneTextField.text];
                }
                NSLog(@"请求注册!");
            } else {
                [JCAlertView showOneButtonWithTitle:@"注册提示" Message:@"短信验证码不正确" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"知道了" Click:^{}];
            }
        }];
    }
//    if ([self.delegate respondsToSelector:@selector(phoneRegisterBtnClicked: phone:)]) {
//        [self.delegate phoneRegisterBtnClicked:self phone:self.phoneTextField.text];
//    }
}

- (void)codeBtnClicked:(UIButton *)btn {
    __weak typeof(self) weakSelf = self;
    if ([self isValidatePhoneNum:self.phoneTextField.text]) {
        if (self.codeTime == 0) {
            [JCAlertView showTwoButtonsWithTitle:@"请求验证码" Message:@"可能会产生0.1元的费用" ButtonType:JCAlertViewButtonTypeCancel ButtonTitle:@"取消" Click:^{} ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"发送" Click:^{
                if (!btn.selected) {
                    // 发送验证码
                    [JSMSSDK getVerificationCodeWithPhoneNumber:weakSelf.phoneTextField.text andTemplateID:@"1" completionHandler:^(id resultObject, NSError *error) {
                        if (!error) {
                            [JCAlertView showOneButtonWithTitle:@"注册提示" Message:@"验证码已发送!" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"知道了" Click:^{}];
                            UIButton *codeBtn = weakSelf.leftCodeView.subviews[0];
                            [codeBtn setSelected: YES];
                            [codeBtn setTitle:[NSString stringWithFormat:@"有效(%ds)", CODE_TIME] forState:UIControlStateSelected];
                            weakSelf.codeTime = 60;
                            [weakSelf startTimer];
                        } else {
                            [JCAlertView showOneButtonWithTitle:@"注册提示" Message:@"请稍后再试!" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"知道了" Click:^{}];
                            NSLog(@"上传手机号失败 error %ld",(long)error.code);
                        }
                    }];
                }
            }];
        } else {
            [JCAlertView showOneButtonWithTitle:@"注册提示" Message:@"验证码已经发送, 请稍后再试!" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"知道了" Click:^{}];
        }
    } else {
        [JCAlertView showOneButtonWithTitle:@"注册提示" Message:@"手机号码不符合规定!" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"知道了" Click:^{}];
    }
}

- (BOOL)isValidatePhoneNum:(NSString *)num {
    NSString * MOBILE = @"\\d{11}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];

    return [regextestmobile evaluateWithObject:num];
}

#pragma mark -
#pragma mark Timer
- (void) startTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(codeTimeChanged) userInfo:nil repeats:YES];
    NSRunLoop *mainRunLoop = [NSRunLoop mainRunLoop];
    [mainRunLoop addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    [_timer invalidate];
}

- (void)codeTimeChanged {
    UIButton *codeBtn = self.leftCodeView.subviews[0];
    if (self.codeTime == 0) {
        [codeBtn setSelected:NO];
        [self stopTimer];
    } else {
        self.codeTime--;
        [codeBtn setTitle:[NSString stringWithFormat:@"有效(%ds)", self.codeTime] forState:UIControlStateSelected];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.phoneTextField resignFirstResponder];
    [self.codeTextField resignFirstResponder];
}

@end
