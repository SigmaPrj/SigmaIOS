//
//  SADynamicCommentController.m
//  Sigma
//
//  Created by 汤轶侬 on 16/7/28.
//  Copyright (c) 2016 blackcater. All rights reserved.
//

#import "SADynamicCommentController.h"
#import "SACommentView.h"
#import "SADynamicModel.h"
#import "SACommunityRequest.h"
#import "SVProgressHUD.h"
#import "JCAlertView.h"
#import "CLBottomCommentView.h"
#import "CLProgressHUD.h"

static CGFloat const kBottomViewHeight = 46.0;

@interface SADynamicCommentController() <SACommentViewDelegate, CLBottomCommentViewDelegate>

@property (nonatomic, strong) CLBottomCommentView *bottomView;
@property (nonatomic, strong) SACommentView *commentView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, assign) NSInteger dynamic_id;
@property (nonatomic, strong) SADynamicModel *dynamicModel;

@end

@implementation SADynamicCommentController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.bottomView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self addNotifications];

    [self sendRequest];

    [self startLoading];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self removeNotifications];
    [self stopLoading];
    [super viewWillDisappear:animated];
}

- (instancetype)initWithDynamicId:(NSInteger)dynamic_id dynamicModel:(SADynamicModel *)dynamicModel {
    self = [super init];
    if (self) {
        _dynamic_id = dynamic_id;
        _dynamicModel = dynamicModel;

        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"动态正文";

        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self.view addSubview:self.commentView];
    [self.view addSubview:self.maskView];
}

- (void)startLoading {
    [SVProgressHUD show];
}

- (void)stopLoading {
    [SVProgressHUD dismiss];
}

/*!
 * 发送请求
 */
- (void)sendRequest {
    [SACommunityRequest requestCommentsWithDynamicId:(int)self.dynamic_id options:nil];
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    }
    return _maskView;
}

- (SACommentView *)commentView {
    if (!_commentView) {
        _commentView = [[SACommentView alloc] initWithHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)] frame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-kBottomViewHeight)];
    }
    return _commentView;
}

#pragma mark -
#pragma mark 通知
-(void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataSuccessHandler:) name:NOTI_COMMUNITY_DYNAMIC_COMMENTS_DATA object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataErrorHandler:) name:REQUEST_DATA_ERROR object:nil];
}

- (void)removeNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)receiveDataSuccessHandler:(NSNotification *)noti {
    NSDictionary *dict = noti.userInfo;
    int code = [dict[@"code"] intValue];
    switch (code) {
        case 200:
        {
            [self stopLoading];
            [self.maskView removeFromSuperview];
            [self.commentView setCommentsData:dict[@"data"]];
        }
            break;
            
        default:
            break;
    }
}

- (void)receiveDataErrorHandler:(NSNotification *)noti {
    NSDictionary* dict = noti.userInfo;
    int code = [dict[@"code"] intValue];
    switch (code) {
        case 404:
            [self alertPlaeseChoose:@"温馨提示" message:@"已经是最新数据，请稍后再试！"];
            break;
        case 403:
            [self alertPlaeseChoose:@"权限不够" message:@"您好像没有权限这么做，请确认后再试!"];
            break;
        default:
            [self alertPlaeseChoose:@"网络出错" message:@"您的网络好像出现了问题，请稍后再试!"];
            break;
    }
}

- (void)alertPleaseGoBack:(NSString *)title message:(NSString *)msg {
    __weak typeof(self) weakSelf = self;
    [JCAlertView showOneButtonWithTitle:title Message:msg ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"返回" Click:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)alertPlaeseChoose:(NSString *)title message:(NSString *)msg {
    [JCAlertView showTwoButtonsWithTitle:title Message:msg ButtonType:JCAlertViewButtonTypeCancel ButtonTitle:@"知道了" Click:^{
        
    } ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"重试" Click:^{
        [self sendRequest];
    }];
}

#pragma mark -
#pragma mark SACommentViewDelegate
- (void)addDataSuccess:(SACommentView *)commentView commentsData:(NSMutableArray *)commentsData {

}

/**
 * 评论框
 */
#pragma mark -
#pragma mark CLBottomCommentViewDelegate
- (void)bottomViewDidShare {
    [CLProgressHUD showInView:self.view delegate:self title:@"正在分享中..." duration:3.0];
}

- (void)bottomViewDidMark:(UIButton *)markButton {
    [CLProgressHUD showInView:self.view delegate:self title:@"正在收藏中..." duration:2.0];

    [self performSelector:@selector(changeMarkButtonState:) withObject:markButton afterDelay:2.0];
}

- (void)cl_textViewDidChange:(CLTextView *)textView {
    if (textView.commentTextView.text.length > 0) {
        NSString *originalString = [NSString stringWithFormat:@"[草稿]%@",textView.commentTextView.text];
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:originalString];
        [attriString addAttributes:@{NSForegroundColorAttributeName: kColorNavigationBar} range:NSMakeRange(0, 4)];
        [attriString addAttributes:@{NSForegroundColorAttributeName: kColorTextMain} range:NSMakeRange(4, attriString.length - 4)];

        self.bottomView.editTextField.attributedText = attriString;
    }
}

- (void)cl_textViewDidEndEditing:(CLTextView *)textView {
    [CLProgressHUD showInView:self.view delegate:self title:@"正在发送评论中..." duration:2.0];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.bottomView clearComment];
    });
}

#pragma mark - Private Method

- (void)changeMarkButtonState:(UIButton *)sender {
    sender.selected = !sender.selected;
}

#pragma mark - Accessor

- (CLBottomCommentView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[CLBottomCommentView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kBottomViewHeight-64, SCREEN_WIDTH, kBottomViewHeight)];
        _bottomView.delegate = self;
        _bottomView.clTextView.delegate = self;
    }
    return _bottomView;
}

@end
