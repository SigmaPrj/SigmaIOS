//
//  SASignUpWithEmailView.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/1.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SASignUpWithEmailView.h"

#define TITLE_LABEL_MARGIN_TOP 25
#define TITLE_LABEL_HEIGHT 30
#define TITLE_LABEL_FONT_SIZE 26
#define TITLE_LABEL_MARGIN_BOTTOM 45
#define TEXT_FIELD_HEIGHT 40

@interface SASignUpWithEmailView() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *emailTextField;
@property (nonatomic, strong) UIView *leftEmailView;
@property (nonatomic, strong) UIView *rightEmailView;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIView *leftPasswordView;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isShowTableView;
@property (nonatomic, strong) NSMutableArray *emailsArray;

@end

@implementation SASignUpWithEmailView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

-(void) setupUI {
    [self addSubview:self.titleLabel];
    [self addSubview:self.emailTextField];
    UIView *underline1 = [[UIView alloc] initWithFrame:CGRectMake(15, MaxY(self.emailTextField), SCREEN_WIDTH-30, 0.5)];
    underline1.backgroundColor = SIGMA_BG_COLOR;
    [self addSubview:underline1];
    [self addSubview:self.passwordTextField];
    UIView *underline2 = [[UIView alloc] initWithFrame:CGRectMake(15, MaxY(self.passwordTextField), SCREEN_WIDTH-30, 0.5)];
    underline2.backgroundColor = SIGMA_BG_COLOR;
    [self addSubview:underline2];
    [self addSubview:self.registerBtn];

    [self addSubview:self.tableView];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, TITLE_LABEL_MARGIN_TOP, SCREEN_WIDTH, TITLE_LABEL_HEIGHT)];
        _titleLabel.text = @"请输入你的邮箱";
        _titleLabel.font = [UIFont systemFontOfSize:TITLE_LABEL_FONT_SIZE];
        _titleLabel.textColor = SIGMA_FONT_COLOR;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIView *)leftEmailView {
    if (!_leftEmailView) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"email"]];
        imageView.frame = CGRectMake(15, (TEXT_FIELD_HEIGHT-18)/2, 18, 18);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(imageView), 0, 40, TEXT_FIELD_HEIGHT)];
        label.font = [UIFont systemFontOfSize:18];
        label.text = @"邮箱";
        label.textAlignment = NSTextAlignmentCenter;
        UIView *rightLine = [[UILabel alloc] initWithFrame:CGRectMake(15+WIDTH(imageView)+WIDTH(label)+3-0.5, (TEXT_FIELD_HEIGHT-20)/2, 0.5, 20)];
        rightLine.backgroundColor = SIGMA_FONT_COLOR;

        _leftEmailView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15+WIDTH(imageView)+WIDTH(label)+13, TEXT_FIELD_HEIGHT)];
        [_leftEmailView addSubview:imageView];
        [_leftEmailView addSubview:label];
        [_leftEmailView addSubview:rightLine];
    }
    return _leftEmailView;
}

- (UIView *)rightEmailView {
    if (!_rightEmailView) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 140, TEXT_FIELD_HEIGHT)];
        NSAttributedString *attributedString = [self getAttributedEmailString:@"@ qq.com"];
        [btn setAttributedTitle:attributedString forState:UIControlStateNormal];
        CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(200, TEXT_FIELD_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];

        btn.frame = CGRectMake(0, (TEXT_FIELD_HEIGHT-rect.size.height)/2, rect.size.width, rect.size.height);

        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(emailBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _rightEmailView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(btn)+15, TEXT_FIELD_HEIGHT)];
        [_rightEmailView addSubview:btn];
    }
    return _rightEmailView;
}

- (UITextField *)emailTextField {
    if (!_emailTextField) {
        _emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, MaxY(self.titleLabel)+TITLE_LABEL_MARGIN_BOTTOM, SCREEN_WIDTH, TEXT_FIELD_HEIGHT)];
        _emailTextField.borderStyle = UITextBorderStyleNone;
        _emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _emailTextField.leftView = self.leftEmailView;
        _emailTextField.rightView = self.rightEmailView;
        _emailTextField.leftViewMode = UITextFieldViewModeAlways;
        _emailTextField.rightViewMode = UITextFieldViewModeAlways;
        _emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
        _emailTextField.placeholder = @"请输入邮箱账号";
    }
    return _emailTextField;
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
        _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, MaxY(self.emailTextField), SCREEN_WIDTH, TEXT_FIELD_HEIGHT)];
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

- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, MaxY(self.passwordTextField)+30, 200, 44)];
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

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-140-15, MinY(self.passwordTextField), 140, 200) style:UITableViewStylePlain];
        _tableView.layer.masksToBounds = YES;
        _tableView.layer.borderWidth = 1;
        _tableView.layer.borderColor = SIGMA_FONT_COLOR.CGColor;
        _tableView.hidden = YES;

        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.bounces = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)registerBtnClicked:(UIButton *)btn {
    // TODO : 邮箱注册
}

- (void)emailBtnClicked:(UIButton *)btn {
    if (!self.isShowTableView) {
        self.tableView.hidden = NO;
        self.isShowTableView = YES;
    } else {
        self.tableView.hidden = YES;
        self.isShowTableView = NO;
    }
}

- (NSAttributedString *)getAttributedEmailString:(NSString *)string {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString addAttribute:NSForegroundColorAttributeName value:SIGMA_BG_COLOR range:NSMakeRange(0, 1)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont italicSystemFontOfSize: 22] range:NSMakeRange(0, 1)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(1, string.length-1)];
    return [attributedString copy];
}

-(NSMutableArray *)emailsArray {
    if (!_emailsArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"email.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        _emailsArray = [array mutableCopy];
    }
    return _emailsArray;
}

-(void)cellClicked:(UITapGestureRecognizer *)recognizer {
    UITableViewCell *cell = (UITableViewCell *)recognizer.view;
    NSString *emailString = cell.textLabel.text;
    // 关闭tableView
    self.tableView.hidden = YES;
    self.isShowTableView = NO;
    // 修改原button内容
    UIButton *btn = self.rightEmailView.subviews[0];
    NSAttributedString *attributedString = [self getAttributedEmailString:emailString];
    [btn setAttributedTitle:attributedString forState:UIControlStateNormal];

    CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(200, TEXT_FIELD_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];

    btn.frame = CGRectMake(0, (TEXT_FIELD_HEIGHT-rect.size.height)/2, rect.size.width, rect.size.height);
    self.rightEmailView.frame = CGRectMake(0, 0, WIDTH(btn)+15, TEXT_FIELD_HEIGHT);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.emailsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"EmailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = self.emailsArray[(NSUInteger)indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    cell.tag = indexPath.row;

    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClicked:)];
    gestureRecognizer.numberOfTapsRequired = 1;

    [cell addGestureRecognizer:gestureRecognizer];

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


#pragma mark -
#pragma mark UITableViewDelegate

@end
