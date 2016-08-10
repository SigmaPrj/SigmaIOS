//
//  SASignUpUserInfoController.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/8.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SASignUpUserInfoController.h"
#import "UIView+HRExtention.h"
#import "SASignUpSetPasswordView.h"
#import "SASignUpSetInfoView.h"
#import "SASignUpRequest.h"
#import "CLProgressHUD.h"
#import "SAUserDataManager.h"
#import "SASignInRequest.h"
#import "SARootViewController.h"
#import "QNUploadManager.h"
#import "QNUploadOption.h"
#import "JCAlertView.h"

#define KStatusHeight 20
#define KNavBarHeight 44

@interface SASignUpUserInfoController() <SASignUpSetPasswordViewDelegate, SASignUpSetInfoViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SASignUpSetInfoView *bkInfoView;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *avatarFilePath;

@end

@implementation SASignUpUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = NO;

    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationItem.hidesBackButton = YES;

    [self.view addSubview:self.scrollView];
    //设置title
    [self setupTitle];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // 添加监听事件
    [self addAllNotifications];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    // 清除监听事件
    [self removeAllNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setupTitle {
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"第一步",@"第二步"]];
    //设置宽度
    segment.width = 180;
    //设置选中和普通状态 文字颜色为白色
    [segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.44 green:0.42 blue:0.41 alpha:0.5]} forState:UIControlStateNormal];
    [segment setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateSelected];
    [segment setTintColor:[UIColor colorWithRed:0.16 green:0.15 blue:0.14 alpha:0.5]];

    //默认选中第0个
    segment.selectedSegmentIndex = 0;

    [segment setEnabled:NO forSegmentAtIndex:1];

    //添加
    self.navigationItem.titleView = segment;
    _segment = segment;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, 0);
        _scrollView.contentOffset = CGPointMake(0, 0);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.alwaysBounceHorizontal = NO;
        _scrollView.alwaysBounceVertical = NO;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = NO;

        [self addViewsToScrollView];
    }
    return _scrollView;
}

- (void)addViewsToScrollView {
    for (int i = 0; i <3; ++i) {
        UIView *signUpView;
        switch (i) {
            case 0:
            {
                // 设置用户的密码
                signUpView = [[SASignUpSetPasswordView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT(self.scrollView)-KStatusHeight-KNavBarHeight)];
                ((SASignUpSetPasswordView *)signUpView).delegate = self;
            }
                break;
            case 1:
            {
                // 设置用户详细信息
                signUpView = [[SASignUpSetInfoView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, HEIGHT(self.scrollView)-KStatusHeight-KNavBarHeight)];
                ((SASignUpSetInfoView *)signUpView).delegate = self;
            }
                break;
            default:
                break;
        }

        [self.scrollView addSubview:signUpView];
    }
}

#pragma mark -
#pragma mark SASignUpSetPasswordViewDelegate
- (void)nextStepBtnClicked:(SASignUpSetPasswordView *)passwordView password:(NSString *)password {
    // 测试
/*    [self.segment setEnabled:NO forSegmentAtIndex:0];
    [self.segment setEnabled:YES forSegmentAtIndex:1];
    [self.segment setSelectedSegmentIndex:1];
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, -(KStatusHeight+KNavBarHeight)) animated:YES];*/

    _password = password;
    // 显示等待
    [CLProgressHUD showInView:self.view delegate:self tag:1 title:@"请稍等..."];
    // 发送更新密码请求
    [SASignUpRequest requestSetPass:password];
}

#pragma mark -
#pragma mark SASignUpSetInfoViewDelegate
- (void)chooseImageForAvatar:(SASignUpSetInfoView *)infoView {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"图片选择" message:@"选择可以获得图片的方式" preferredStyle:UIAlertControllerStyleActionSheet];

    _bkInfoView = infoView;

    __weak typeof(self) weakSelf = self;
    // 照相机
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = weakSelf;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [weakSelf presentViewController:imagePicker animated:YES completion:nil];
    }];

    // 相册
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"本地相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = weakSelf;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [weakSelf presentViewController:imagePicker animated:YES completion:nil];
    }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {}];

    [alertController addAction:cameraAction];
    [alertController addAction:albumAction];
    [alertController addAction:cancelAction];

    [self presentViewController:alertController animated:YES completion:^{}];
}

- (void)finishedBtnClicked:(SASignUpSetInfoView *)infoView city:(NSInteger)city school:(NSInteger)school nickname:(NSString *)nickname {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"city_code"] = @(city);
    dictionary[@"school_code"] = @(school);
    dictionary[@"nickname"] = nickname;

    [CLProgressHUD showInView:self.view delegate:self tag:2 title:@"正在完成注册..."];
    [SASignUpRequest requestSetUserInfo:dictionary];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info {
    if ([[info allKeys] containsObject:@"UIImagePickerControllerEditedImage"]) {
        UIImage *image = (UIImage *)info[@"UIImagePickerControllerEditedImage"];
        [self.bkInfoView setupAvatar:[self scaleFromImage:image toSize:CGSizeMake(80, 80)]];
        [self dismissViewControllerAnimated:YES completion:^{}];

        //  七牛保存图片
        NSString *filePath = [self saveImageToLocal:image];
        [self uploadImageToQN:filePath];
    }
}

- (void)uploadImageToQN:(NSString *)filePath {
    _avatarFilePath = filePath;
    // 发送请求 获取 文件上传token
    [self sendQNToenRequest];
}

- (void)sendQNToenRequest {
    [SASignUpRequest requestQNUploadToken];
}

- (void)receiveQNTokenSuccess:(NSNotification *)notification {
    if ([notification.userInfo[@"code"] intValue] == 200) {
        NSInteger userId = [SAUserDataManager readUserId];
        QNUploadManager *uploadManager = [[QNUploadManager alloc] init];
        QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:nil params:@{@"x:userId": [NSString stringWithFormat:@"%d", userId]} checkCrc:NO cancellationSignal:nil];
        [uploadManager putFile:_avatarFilePath key:nil token:[notification.userInfo valueForKeyPath:@"data.token"] complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            NSLog(@"qiniu info : %@", info);
            NSLog(@"qiniu resp : %@", resp);
        } option:uploadOption];
    } else {
        [JCAlertView showOneButtonWithTitle:@"头像上传失败" Message:@"请稍后再试" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"知道了" Click:^{}];
    }
}

- (void)receiveQNTokenFailed:(NSNotification *)notification {
    [JCAlertView showOneButtonWithTitle:@"头像上传失败" Message:@"网络异常!" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"知道了" Click:^{}];
}

- (NSString *)saveImageToLocal:(UIImage *)image {
    NSString *filePath = nil;
    NSData *data = nil;
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, 1.0);
    } else {
        data = UIImagePNGRepresentation(image);
    }

    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];

    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];

    NSDictionary *userDict = [SAUserDataManager readUser];
    NSString *filename = [NSString stringWithFormat:@"%@_avatar", userDict[@"username"]];

    NSString *ImagePath = [[NSString alloc] initWithFormat:@"/%@.png", filename];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:ImagePath] contents:data attributes:nil];

    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@", DocumentsPath, ImagePath];
    return filePath;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark -
#pragma mark Notifications
- (void)addAllNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(passSetSuccess:) name:NOTI_SIGNUP_PASS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(passSetFailed:) name:NOTI_SIGNUP_PASS_ERROR object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(infoSetSuccess:) name:NOTI_SIGNUP_INFO object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(infoSetFailed:) name:NOTI_SIGNUP_INFO_ERROR object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveUserDataSuccess:) name:NOTI_SIGNIN_AUTH object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveUserDataFailed:) name:NOTI_SIGNIN_AUTH_ERRPR object:nil];

    // 七牛
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveQNTokenSuccess:) name:NOTI_QINIU_TOKEN object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveQNTokenFailed:) name:NOTI_QINIU_TOKEN_ERROR object:nil];
}

- (void)removeAllNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)passSetSuccess:(NSNotification *)notification {
    if ([notification.userInfo[@"code"] intValue] == 200) {
        [CLProgressHUD dismissHUDByTag:1 delegate:self inView:self.view];
        [self.segment setEnabled:NO forSegmentAtIndex:0];
        [self.segment setEnabled:YES forSegmentAtIndex:1];
        [self.segment setSelectedSegmentIndex:1];
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, -(KStatusHeight+KNavBarHeight)) animated:YES];
    } else {
        [CLProgressHUD dismissHUDByTag:1 delegate:self inView:self.view];
        [CLProgressHUD showErrorInView:self.view delegate:self title:@"密码设置失败!" duration:.4];
    }
}

- (void)passSetFailed:(NSNotification *)notification {
    [CLProgressHUD dismissHUDByTag:1 delegate:self inView:self.view];
    [CLProgressHUD showErrorInView:self.view delegate:self title:@"请稍后再试!" duration:.4];
}

- (void)infoSetSuccess:(NSNotification *)notification {
    if ([notification.userInfo[@"code"] intValue] == 200) {

        // 获取用户信息
        NSDictionary *dict = [SAUserDataManager readUser];
        NSString *username = dict[@"username"];
        NSString *password = self.password;

        // 获取授权请求
        [SASignInRequest requestSignInWithUsername:username password:password];

    } else {
        [CLProgressHUD dismissHUDByTag:2 delegate:self inView:self.view];
        [CLProgressHUD showErrorInView:self.view delegate:self title:@"信息注册失败!" duration:.4];
    }
}

- (void)infoSetFailed:(NSNotification *)notification {
    [CLProgressHUD dismissHUDByTag:2 delegate:self inView:self.view];
    [CLProgressHUD showErrorInView:self.view delegate:self title:@"请稍后再试!" duration:.4];
}

- (void)receiveUserDataSuccess:(NSNotification *)notification {
    if ([notification.userInfo[@"code"] intValue] == 200) {
        // 保存用户信息
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

        // 关闭弹出层
        [CLProgressHUD dismissHUDByTag:2 delegate:self inView:self.view];
        [CLProgressHUD showSuccessInView:self.view delegate:self title:@"注册成功!" duration:.5];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 切换主界面
            SARootViewController *rootViewController = [[SARootViewController alloc] init];
            [UIApplication sharedApplication].keyWindow.rootViewController = rootViewController;
        });
    } else {
        [CLProgressHUD dismissHUDByTag:2 delegate:self inView:self.view];
        [CLProgressHUD showErrorInView:self.view delegate:self title:@"信息设置失败!" duration:.4];
    }
}

- (void)receiveUserDataFailed:(NSNotification *)notification {
    [CLProgressHUD dismissHUDByTag:2 delegate:self inView:self.view];
    [CLProgressHUD showErrorInView:self.view delegate:self title:@"请稍后再试!" duration:.4];
}

@end
