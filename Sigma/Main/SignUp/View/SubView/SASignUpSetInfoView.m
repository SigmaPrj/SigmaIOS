//
//  SASignUpSetInfoView.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/8.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SASignUpSetInfoView.h"
#import "SACitySearchTableView.h"
#import "SASchoolSearchTableView.h"
#import "JCAlertView.h"

#define TITLE_LABEL_MARGIN_TOP 25
#define TITLE_LABEL_HEIGHT 30
#define TITLE_LABEL_FONT_SIZE 26
#define TITLE_LABEL_MARGIN_BOTTOM 45
#define TEXT_FIELD_HEIGHT 40
#define AVATAR_SIZE 80

@interface SASignUpSetInfoView() <SACitySearchTableViewDelegate, SASchoolSearchTableViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UITextField *nicknameTextField;
@property (nonatomic, strong) UITextField *cityTextField;
@property (nonatomic, strong) UIView *leftCityView;
@property (nonatomic, strong) UIView *rightCityView;
@property (nonatomic, strong) UITextField *schoolTextField;
@property (nonatomic, strong) UIView *leftSchoolView;
@property (nonatomic, strong) UIView *rightSchoolView;
@property (nonatomic, strong) UIButton *finishedBtn;

@property (nonatomic, assign) int city_code;
@property (nonatomic, assign) int school_code;

@end

@implementation SASignUpSetInfoView

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
    // 头像
    [self addSubview:self.avatarImageView];
    // 昵称
    [self addSubview:self.nicknameTextField];
    UIView *underline = [[UIView alloc] initWithFrame:CGRectMake(MinX(self.nicknameTextField), MaxY(self.nicknameTextField), WIDTH(self.nicknameTextField), 0.5)];
    underline.backgroundColor = SIGMA_BG_COLOR;
    [self addSubview:underline];
    // 城市
    [self addSubview:self.cityTextField];
    UIView *underline1 = [[UIView alloc] initWithFrame:CGRectMake(15, MaxY(self.cityTextField), SCREEN_WIDTH-30, 0.5)];
    underline1.backgroundColor = SIGMA_BG_COLOR;
    [self addSubview:underline1];
    // 学校
    [self addSubview:self.schoolTextField];
    UIView *underline2 = [[UIView alloc] initWithFrame:CGRectMake(15, MaxY(self.schoolTextField), SCREEN_WIDTH-30, 0.5)];
    underline2.backgroundColor = SIGMA_BG_COLOR;
    [self addSubview:underline2];
    // 完成按钮
    [self addSubview:self.finishedBtn];
}

// 头部标题
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, TITLE_LABEL_MARGIN_TOP, SCREEN_WIDTH, TITLE_LABEL_HEIGHT)];
        _titleLabel.text = @"用户基本信息设置";
        _titleLabel.font = [UIFont systemFontOfSize:TITLE_LABEL_FONT_SIZE];
        _titleLabel.textColor = SIGMA_FONT_COLOR;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

// 头像
- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (HEIGHT(self.titleLabel)+TITLE_LABEL_MARGIN_BOTTOM), AVATAR_SIZE, AVATAR_SIZE)];
        _avatarImageView.layer.borderWidth = 2;
        _avatarImageView.layer.borderColor = SIGMA_BG_COLOR.CGColor;
        _avatarImageView.layer.cornerRadius = AVATAR_SIZE/2;
        _avatarImageView.userInteractionEnabled = YES;
        _avatarImageView.image = [UIImage imageNamed:@"avatar60"];
        _avatarImageView.clipsToBounds = YES;

        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarImageViewClicked:)];
        gestureRecognizer.numberOfTapsRequired = 1;
        [_avatarImageView addGestureRecognizer:gestureRecognizer];

    }
    return _avatarImageView;
}

// 昵称
- (UITextField *)nicknameTextField {
    if (!_nicknameTextField) {
        _nicknameTextField = [[UITextField alloc] initWithFrame:CGRectMake(MaxX(self.avatarImageView)+30, MinY(self.avatarImageView)+(HEIGHT(self.avatarImageView)-40)/2, SCREEN_WIDTH-(MaxX(self.avatarImageView)+30+15), 40)];
        _nicknameTextField.borderStyle = UITextBorderStyleNone;
        _nicknameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nicknameTextField.keyboardType = UIKeyboardTypeDefault;
        _nicknameTextField.placeholder = @"请输入你的昵称";
    }
    return _nicknameTextField;
}

- (void)setupAvatar:(UIImage *)image {
    self.avatarImageView.image = image;
}

- (void)avatarImageViewClicked:(UIImageView *)imageView {
    if ([self.delegate respondsToSelector:@selector(chooseImageForAvatar:)]) {
        [self.delegate chooseImageForAvatar:self];
    }
}

- (UIView *)leftCityView {
    if (!_leftCityView) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"city"]];
        imageView.frame = CGRectMake(15, (TEXT_FIELD_HEIGHT-18)/2, 18, 18);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(imageView)+3, 0, TEXT_FIELD_HEIGHT-3, TEXT_FIELD_HEIGHT)];
        label.text = @"城市";
        label.textColor = SIGMA_FONT_COLOR;
        label.font = [UIFont systemFontOfSize:16];
        UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(MaxX(label), (TEXT_FIELD_HEIGHT - 18) / 2, 0.5, 18)];
        rightLine.backgroundColor = SIGMA_FONT_COLOR;
        _leftCityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, TEXT_FIELD_HEIGHT)];
        [_leftCityView addSubview:imageView];
        [_leftCityView addSubview:label];
        [_leftCityView addSubview:rightLine];
    }
    return _leftCityView;
}

- (UIView *)rightCityView {
    if (!_rightCityView) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        [btn setTitle:@"选择" forState:UIControlStateNormal];
        [btn setTitleColor:SIGMA_FONT_COLOR forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];

        [btn addTarget:self action:@selector(citySelectionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

        _rightCityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 75, 40)];
        [_rightCityView addSubview:btn];
    }
    return _rightCityView;
}

- (void)citySelectionBtnClicked:(UIButton *)btn {
    [self.nicknameTextField resignFirstResponder];
    [self.cityTextField resignFirstResponder];
    [self.schoolTextField resignFirstResponder];

    SACitySearchTableView *citySearchTableView = [[SACitySearchTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];

    citySearchTableView.ownDelegate = self;

    [[UIApplication sharedApplication].keyWindow addSubview:citySearchTableView];
}

// 城市
- (UITextField *)cityTextField {
    if (!_cityTextField) {
        _cityTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, MaxY(self.avatarImageView)+TITLE_LABEL_MARGIN_BOTTOM, SCREEN_WIDTH, TEXT_FIELD_HEIGHT)];
        _cityTextField.borderStyle = UITextBorderStyleNone;
        _cityTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _cityTextField.leftView = self.leftCityView;
        _cityTextField.rightView = self.rightCityView;
        _cityTextField.leftViewMode = UITextFieldViewModeAlways;
        _cityTextField.rightViewMode = UITextFieldViewModeAlways;
        _cityTextField.keyboardType = UIKeyboardTypeDefault;
        _cityTextField.placeholder = @"请输入城市名称";
    }
    return _cityTextField;
}


- (UIView *)leftSchoolView {
    if (!_leftSchoolView) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"school"]];
        imageView.frame = CGRectMake(15, (TEXT_FIELD_HEIGHT-18)/2, 18, 18);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(imageView)+3, 0, TEXT_FIELD_HEIGHT-3, TEXT_FIELD_HEIGHT)];
        label.text = @"学校";
        label.textColor = SIGMA_FONT_COLOR;
        label.font = [UIFont systemFontOfSize:16];
        UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(MaxX(label), (TEXT_FIELD_HEIGHT - 18) / 2, 0.5, 18)];
        rightLine.backgroundColor = SIGMA_FONT_COLOR;
        _leftSchoolView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, TEXT_FIELD_HEIGHT)];
        [_leftSchoolView addSubview:imageView];
        [_leftSchoolView addSubview:label];
        [_leftSchoolView addSubview:rightLine];
    }
    return _leftSchoolView;
}

- (UIView *)rightSchoolView {
    if (!_rightSchoolView) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        [btn setTitle:@"选择" forState:UIControlStateNormal];
        [btn setTitleColor:SIGMA_FONT_COLOR forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];

        [btn addTarget:self action:@selector(schoolSelectionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

        _rightSchoolView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 75, 40)];
        [_rightSchoolView addSubview:btn];
    }
    return _rightSchoolView;
}

- (void)schoolSelectionBtnClicked:(UIButton *)btn {
    [self.nicknameTextField resignFirstResponder];
    [self.cityTextField resignFirstResponder];
    [self.schoolTextField resignFirstResponder];

    SASchoolSearchTableView *schoolSearchTableView = [[SASchoolSearchTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];

    schoolSearchTableView.ownDelegate = self;

    [[UIApplication sharedApplication].keyWindow addSubview:schoolSearchTableView];
}

// 学校
- (UITextField *)schoolTextField {
    if (!_schoolTextField) {
        _schoolTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, MaxY(self.cityTextField), SCREEN_WIDTH, TEXT_FIELD_HEIGHT)];
        _schoolTextField.borderStyle = UITextBorderStyleNone;
        _schoolTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _schoolTextField.leftView = self.leftSchoolView;
        _schoolTextField.rightView = self.rightSchoolView;
        _schoolTextField.leftViewMode = UITextFieldViewModeAlways;
        _schoolTextField.rightViewMode = UITextFieldViewModeAlways;
        _schoolTextField.keyboardType = UIKeyboardTypeDefault;
        _schoolTextField.placeholder = @"请输入学校名称";
    }
    return _schoolTextField;
}

- (UIButton *)finishedBtn {
    if (!_finishedBtn) {
        _finishedBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, MaxY(self.schoolTextField)+30, 200, 44)];
        [_finishedBtn setTitle:@"立即注册" forState:UIControlStateNormal];
        [_finishedBtn setTitleColor:SIGMA_FONT_COLOR forState:UIControlStateNormal];
        [_finishedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        _finishedBtn.layer.borderWidth = 2;
        _finishedBtn.layer.borderColor = SIGMA_FONT_COLOR.CGColor;
        _finishedBtn.layer.cornerRadius = 22;
        _finishedBtn.clipsToBounds = YES;
        [_finishedBtn setBackgroundImage:[UIImage imageNamed:@"small_active_bg"] forState:UIControlStateHighlighted];
        [_finishedBtn addTarget:self action:@selector(finishedBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishedBtn;
}

- (void)finishedBtnClicked:(UIButton *)btn {
    [self.nicknameTextField resignFirstResponder];
    [self.cityTextField resignFirstResponder];
    [self.schoolTextField resignFirstResponder];

    if ([self.cityTextField.text isEqualToString:@""] || [self.schoolTextField.text isEqualToString:@""] || self.avatarImageView.image == nil) {
        [JCAlertView showOneButtonWithTitle:@"温馨提示" Message:@"三个字段均不能为空" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"知道了" Click:^{}];
    } else {
        if ([self.delegate respondsToSelector:@selector(finishedBtnClicked:city:school:nickname:)]) {
            [self.delegate finishedBtnClicked:self city:_city_code school:_school_code nickname:self.nicknameTextField.text];
        }
    }
}


#pragma mark -
#pragma mark SACitySearchTableViewDelegate
- (void)cityCellDidClicked:(SACitySearchTableView *)searchTableView cell:(UITableViewCell *)cell {
    self.cityTextField.text = cell.textLabel.text;
    _city_code = cell.tag;
}

#pragma mark -
#pragma mark SASchoolSearchTableViewDelegate
- (void)schoolCellDidClicked:(SASchoolSearchTableView *)searchTableView cell:(UITableViewCell *)cell {
    self.schoolTextField.text = cell.textLabel.text;
    _school_code = cell.tag;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nicknameTextField resignFirstResponder];
    [self.cityTextField resignFirstResponder];
    [self.schoolTextField resignFirstResponder];
}

@end
