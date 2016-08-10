//
//  SASignInViewController.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/2.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <JMessage/JMessage.h>
#import "SASignInViewController.h"
#import "SAVerticalButton.h"
#import "UIView+HRExtention.h"
#import "SAValidator.h"
#import "JCAlertView.h"
#import "SASignInRequest.h"
#import "SAUserDataManager.h"
#import "CLProgressHUD.h"
#import "SARootViewController.h"

#define TITLE_LABEL_MARGIN_TOP 25
#define TITLE_LABEL_HEIGHT 30
#define TITLE_LABEL_FONT_SIZE 26
#define TITLE_LABEL_MARGIN_BOTTOM 30
#define TEXT_FIELD_HEIGHT 40
#define BUTTON_WIDTH 36
#define BUTTON_HEIGHT 54
#define BUTTON_PADDING (((SCREEN_WIDTH)-30-3*BUTTON_WIDTH)/4)
#define FOOTER_HEIGHT 80


@interface SASignInViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UIView *leftUsernameView;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIView *leftPasswordView;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) SAVerticalButton *qqBtn;
@property (nonatomic, strong) SAVerticalButton *wechatBtn;
@property (nonatomic, strong) SAVerticalButton *weiboBtn;
@property (nonatomic, strong) UILabel *cpLabel;

@end

@implementation SASignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self addAllNotifications];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self removeAllNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    UIView *outView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    outView.backgroundColor = [UIColor clearColor];
    [outView addSubview:self.titleLabel];
    [outView addSubview:self.usernameTextField];
    UIView *underline1 = [[UIView alloc] initWithFrame:CGRectMake(15, MaxY(self.usernameTextField), SCREEN_WIDTH-30, 0.5)];
    underline1.backgroundColor = SIGMA_BG_COLOR;
    [outView addSubview:underline1];
    [outView addSubview:self.passwordTextField];
    UIView *underline2 = [[UIView alloc] initWithFrame:CGRectMake(15, MaxY(self.passwordTextField), SCREEN_WIDTH-30, 0.5)];
    underline2.backgroundColor = SIGMA_BG_COLOR;
    [outView addSubview:underline2];
    [outView addSubview:self.loginBtn];
    [self.footerView addSubview:self.qqBtn];
    [self.footerView addSubview:self.wechatBtn];
    [self.footerView addSubview:self.weiboBtn];
    [outView addSubview:self.footerView];
    [self.view addSubview:outView];
    [self.view addSubview:self.cpLabel];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, TITLE_LABEL_MARGIN_TOP, SCREEN_WIDTH, TITLE_LABEL_HEIGHT)];
        _titleLabel.text = @"登录";
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
        _usernameTextField.keyboardType = UIKeyboardTypeEmailAddress;
        _usernameTextField.placeholder = @"请输入电话/邮箱/自定义账号";
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
        UIView *rightLine = [[UILabel alloc] initWithFrame:CGRectMake((CGFloat)(15+WIDTH(imageView)+WIDTH(label)+3-0.5), (TEXT_FIELD_HEIGHT-20)/2, 0.5, 20)];
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

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, MaxY(self.passwordTextField)+30, 200, 44)];
        [_loginBtn setTitle:@"立即注册" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:SIGMA_FONT_COLOR forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        _loginBtn.layer.borderWidth = 2;
        _loginBtn.layer.borderColor = SIGMA_FONT_COLOR.CGColor;
        _loginBtn.layer.cornerRadius = 22;
        _loginBtn.clipsToBounds = YES;
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"small_active_bg"] forState:UIControlStateHighlighted];
        [_loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

-(UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-FOOTER_HEIGHT-64-20, SCREEN_WIDTH, FOOTER_HEIGHT)];
        // 添加头部线
        UIView *underline = [[UIView alloc] initWithFrame:CGRectMake(15+BUTTON_PADDING, 8, SCREEN_WIDTH-30-2*BUTTON_PADDING, 1)];
        underline.backgroundColor = SIGMA_FONT_COLOR;
        // 添加字体
        NSString *labelString = @"第三方平台";
        CGRect rect = [labelString boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-rect.size.width)/2, (8-rect.size.height/2), rect.size.width, rect.size.height)];
        label.text = labelString;
        label.font = [UIFont systemFontOfSize:15];
        label.backgroundColor = [UIColor whiteColor];

        [_footerView addSubview:underline];
        [_footerView addSubview:label];
    }
    return _footerView;
}

-(SAVerticalButton *)qqBtn {
    if (!_qqBtn) {
        _qqBtn = [[SAVerticalButton alloc] initWithFrame:CGRectMake(15+BUTTON_PADDING, 20, BUTTON_WIDTH, BUTTON_HEIGHT)];
        [_qqBtn setTitle:@"QQ" forState:UIControlStateNormal];
        [_qqBtn setTitleColor:SIGMA_FONT_COLOR forState:UIControlStateNormal];
        [_qqBtn setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
        _qqBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_qqBtn verticalImageAndTitle:0];
    }
    return _qqBtn;
}

- (SAVerticalButton *)wechatBtn {
    if (!_wechatBtn) {
        _wechatBtn = [[SAVerticalButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-BUTTON_WIDTH)/2, MinY(self.qqBtn), BUTTON_WIDTH, BUTTON_HEIGHT)];
        [_wechatBtn setTitle:@"微信" forState:UIControlStateNormal];
        [_wechatBtn setTitleColor:SIGMA_FONT_COLOR forState:UIControlStateNormal];
        [_wechatBtn setImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
        _wechatBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_wechatBtn verticalImageAndTitle:0];
    }
    return _wechatBtn;
}

- (SAVerticalButton *)weiboBtn {
    if (!_weiboBtn) {
        _weiboBtn = [[SAVerticalButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-15-BUTTON_WIDTH-BUTTON_PADDING), MinY(self.qqBtn), BUTTON_WIDTH, BUTTON_HEIGHT)];
        [_weiboBtn setTitle:@"微博" forState:UIControlStateNormal];
        [_weiboBtn setTitleColor:SIGMA_FONT_COLOR forState:UIControlStateNormal];
        [_weiboBtn setImage:[UIImage imageNamed:@"weibo"] forState:UIControlStateNormal];
        _weiboBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_weiboBtn verticalImageAndTitle:0];
    }
    return _weiboBtn;
}


-(UILabel *)cpLabel {
    if (!_cpLabel) {
        NSString *cpString = @"@SIGMA";
        CGRect rect = [cpString boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil];
        _cpLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-rect.size.width)/2, SCREEN_HEIGHT-20, rect.size.width, rect.size.height)];
        _cpLabel.text = cpString;
        _cpLabel.textColor = SIGMA_BG_COLOR;
        _cpLabel.font = [UIFont systemFontOfSize:14];
    }
    return _cpLabel;
}

-(void)loginBtnClicked:(UIButton *)btn {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;

    // 表达元素不能为空
    if ((username.length == 0) || (password.length == 0)) {
        [JCAlertView showOneButtonWithTitle:@"账号密码不合法" Message:@"账号密码不能为空" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"知道了" Click:^{}];
        return;
    }

    // 验证合法性
    if (![SAValidator isValidUsername:username]) {
        [JCAlertView showOneButtonWithTitle:@"用户名不合法" Message:@"用户名需要是电话,邮箱或者合法格式的账号" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"知道了" Click:^{}];
        return;
    }
    if (![SAValidator isValidPassword:password]) {
        [JCAlertView showOneButtonWithTitle:@"密码不合法" Message:@"密码必须只包含数字,英文和.符号" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"知道了" Click:^{}];
        return;
    }

    // 发送请求
    [SASignInRequest requestSignInWithUsername:username password:password];

    // 显示等待图标
    [CLProgressHUD showInView:self.view delegate:self tag:10 title:@"正在登录..."];
}

#pragma mark -
#pragma mark 请求处理
- (void)authSuccess:(NSNotification *)notification {
    if (notification.userInfo) {
        NSInteger code = [notification.userInfo[@"code"] intValue];
        switch (code) {
            case 200:
            {
                [SAUserDataManager deleteUserData];
                NSMutableDictionary *userDict = [notification.userInfo[@"data"] mutableCopy];

                NSMutableDictionary *newUserDict = [NSMutableDictionary dictionary];
                [userDict[@"user"] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    if ((NSNull *)obj == [NSNull null]) {
                        if ([key isEqualToString:@"user_type"]) {
                            newUserDict[key] = @(0);
                        } else if ([key isEqualToString:@"last_login_city"]) {
                            newUserDict[key] = @(0);
                        } else {
                            newUserDict[key] = @"";
                        }
                    } else {
                        newUserDict[key] = obj;
                    }
                }];

                NSMutableDictionary *saveUserDict = [NSMutableDictionary dictionary];
                saveUserDict[@"token"] = userDict[@"token"];
                saveUserDict[@"time"] = userDict[@"time"];
                saveUserDict[@"user"] = newUserDict;

                [SAUserDataManager saveUserData:saveUserDict];


                // TODO : 请求注册用户信息到 极光服务器
                [JMSGUser loginWithUsername:newUserDict[@"username"] password:newUserDict[@"password"] completionHandler:^(id resultObject, NSError *error) {
                    NSLog(@"resultObj : %@", resultObject);
                    NSLog(@"error : %ld ; %@", (long)error.code, error.description);
                }];


                // 关闭弹出层
                [CLProgressHUD dismissHUDByTag:10 delegate:self inView:self.view];
                [CLProgressHUD showSuccessInView:self.view delegate:self title:@"登录成功" duration:.5];

                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    // 切换主界面
                    SARootViewController *rootViewController = [[SARootViewController alloc] init];
                    [UIApplication sharedApplication].keyWindow.rootViewController = rootViewController;
                });
            }
                break;
            case 1:
            case 2:
            {
                [CLProgressHUD dismissHUDByTag:10 delegate:self inView:self.view];
                [CLProgressHUD showErrorInView:self.view delegate:self title:@"用户名不存在或密码错误" duration:1];
            }
                break;
            case 3:
            default:
            {
                [CLProgressHUD dismissHUDByTag:10 delegate:self inView:self.view];
                [CLProgressHUD showErrorInView:self.view delegate:self title:@"稍后再试" duration:1];
            }
                break;
        }
    } else {
        [CLProgressHUD dismissHUDByTag:10 delegate:self inView:self.view];
        [CLProgressHUD showErrorInView:self.view delegate:self title:@"登录失败" duration:1];
    }
}

- (void)authError:(NSNotification *)notification {
    [CLProgressHUD dismissHUDByTag:10 delegate:self inView:self.view];
    [CLProgressHUD showErrorInView:self.view delegate:self title:@"登录失败" duration:1];
}

#pragma mark -
#pragma mark 事件监听
- (void)addAllNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authSuccess:) name:NOTI_SIGNIN_AUTH object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authError:) name:NOTI_SIGNIN_AUTH_ERRPR object:nil];
}

-(void)removeAllNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark 键盘监听
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    CGRect beginRect = [dict[@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue];
    CGRect endRect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    double offsetY = beginRect.origin.y - endRect.origin.y;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:[dict[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue] animations:^{
        if (offsetY > 0) {
            // 从下往上
            weakSelf.footerView.y = (CGFloat)(endRect.origin.y-64-FOOTER_HEIGHT);
        } else {
            weakSelf.footerView.y = (CGFloat)(endRect.origin.y-20-64-FOOTER_HEIGHT);
        }
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

@end
