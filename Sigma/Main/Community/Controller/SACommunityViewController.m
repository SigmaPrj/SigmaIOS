//
//  SACommunityViewController.m
//  Sigmaprj
//
//  Created by Terence on 16/7/13.
//  Copyright © 2016年 Sigma. All rights reserved.
//  @author : blackcater
//

#import "SACommunityViewController.h"
#import "SACommunityTableView.h"
#import "SACommunityRequest.h"
#import "SADynamicCommentController.h"
#import "SVProgressHUD.h"
#import "JCAlertView.h"
#import "SAUserDataManager.h"

#define COMMUNITY_BOTTOM 64



@interface SACommunityViewController () <SACommunityTableViewDelegate, SALoadingTableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) SACommunityTableView *communityTableView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, assign) BOOL firstRequest;
@property (nonatomic, weak) UIImageView *bgImageView;

@end

@implementation SACommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self render];

    self.navigationController.navigationBar.tintColor = SIGMA_FONT_COLOR;

    self.firstRequest = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // 添加通知
    [self addAllNotification];
    
    if (self.firstRequest) {
        // 开始显示加载动画
        [self startLoading];

        [self sendRequest];
    }

}

- (void)viewWillDisappear:(BOOL)animated {
    // 移除所有事件监听
    [self removeAllNotification];
    [super viewWillDisappear:animated];
}

- (void)render {
    [self.view addSubview:self.communityTableView];

    [self.view addSubview:self.maskView];
}

// 惰性加载
- (SACommunityTableView *)communityTableView {
    if (!_communityTableView) {
        _communityTableView = [[SACommunityTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT-COMMUNITY_BOTTOM-49)) style:UITableViewStylePlain];
        _communityTableView.showsHorizontalScrollIndicator = NO;
        _communityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        _communityTableView.ownDelegate = self;

        _communityTableView.loadingDelegate = self;
    }
    return _communityTableView;
}

// 遮罩层
- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT-COMMUNITY_BOTTOM))];
        _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    }
    return _maskView;
}

- (void)startLoading {
    [SVProgressHUD show];
}

- (void)endLoading {
    [SVProgressHUD dismiss];
}

/**
 * 发送请求
 */
- (void)sendRequest {
    // 请求dynamic数据
    NSString *token = [SAUserDataManager readToken];

    NSLog(@"token : %@", token);

    [SACommunityRequest requestDynamics:@{@"t": @(662605661)} user_id:28 token:token];
}

#pragma mark -
#pragma mark 通知
- (void) addAllNotification {
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataSuccessHandler:) name:NOTI_COMMUNITY_USER_DATA object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataSuccessHandler:) name:NOTI_COMMUNITY_DYNAMICS_DATA object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDataErrorHandler:) name:REQUEST_DATA_ERROR object:nil];
}

- (void) removeAllNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*!
 * 从服务器获取数据成功
 * @param noti
 */
- (void)receiveDataSuccessHandler:(NSNotification *)noti {
    // table view header数据

    if ([noti.name isEqualToString:NOTI_COMMUNITY_DYNAMICS_DATA]) {
        if ([noti.userInfo[@"status"] intValue] == 1) {
            // 加载动态数据成功
            [self.communityTableView setDynamicData:noti.userInfo[@"data"]];
            if (self.firstRequest) {
                // 停止加载动画
                self.firstRequest = NO;
                [self deleteMaskView];
            }
            [self stopLoading];
        } else {
            [self alert:@"动态数据加载失败" message:noti.userInfo[@"error"]];
        }
    }
}



- (void)stopLoading {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_END_LOADING object:nil userInfo:nil];
}


/*!
 * 从服务器获取数据失败
 * @param notification
 */
- (void)receiveDataErrorHandler:(NSNotification *)notification {
    int code = [notification.userInfo[@"code"] intValue];
    switch (code) {
        case 404:
        {
            int requestType = [notification.userInfo[@"requestType"] intValue];
            if (requestType == FIRST_REQUEST) {
                [self alert:@"温馨提示" message:@"没有和你相关的动态, 去关注些人吧(～ o ～)~zZ~"];
            } else if (requestType == LOAD_NEW_REQUEST) {
                [self alert:@"温馨提示" message:@"已经是最新数据╮(╯_╰)╭"];
                [self stopLoading];
            } else {
                [self alert:@"温馨提示" message:@"木有数据啦~\\(≧▽≦)/~"];
                [self stopLoading];
            }
        }
            break;
        case 400:
            [self alert:@"你没有权限这么做!" message:@""];
            break;
        default:
            [self alert:@"数据加载失败" message:@"你的网络好像出现了问题，请检查之后再试!"];
            break;
    }
}


/**
 * 删除遮罩层
 */
- (void)deleteMaskView {
    [self endLoading];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.3 animations:^{
        weakSelf.maskView.alpha = 0;
    } completion:^(BOOL finished) {
        // 删除视图
        [weakSelf.maskView removeFromSuperview];
    }];
}


/**
 * 首页自定义弹窗
 *
 * @param title
 * @param msg
 */
- (void)alert:(NSString *)title message:(NSString *)msg {
    __weak typeof(self) weakSelf = self;
    [JCAlertView showTwoButtonsWithTitle:title Message:msg ButtonType:JCAlertViewButtonTypeCancel ButtonTitle:@"算了" Click:^{
        [weakSelf deleteMaskView];
    } ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"重试" Click:^{
        [weakSelf sendRequest];
    }];
}

#pragma mark -
#pragma mark SACommunityTableViewDelegate
- (void)commentBtnDidClicked:(NSInteger)dynamic_id dynamicModel:(SADynamicModel *)dynamicModel {
    SADynamicCommentController *commentController = [[SADynamicCommentController alloc] initWithDynamicId:dynamic_id dynamicModel:dynamicModel];
    commentController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:commentController animated:YES];
}

- (void)bgImageViewDidClickd:(UIImageView *)imageView {
    _bgImageView = imageView;

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"图片选择" message:@"选择可以获得图片的方式" preferredStyle:UIAlertControllerStyleActionSheet];

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

#pragma mark -
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info {
    if ([[info allKeys] containsObject:@"UIImagePickerControllerEditedImage"]) {
        UIImage *image = (UIImage *)info[@"UIImagePickerControllerEditedImage"];
        self.bgImageView.image = [self scaleFromImage:image toSize:CGSizeMake(640, 480)];
        [self dismissViewControllerAnimated:YES completion:^{}];

        // TODO : 七牛保存图片
        [self saveImageToLocal:image];
    }
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
    NSString *filename = [NSString stringWithFormat:@"%@_bgImage", userDict[@"username"]];

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
#pragma mark SALoadingTableViewDelegate
- (void)endHeaderLoadingAnimation:(SAHeaderLoadingView *)loadingView {
    // 加载最新数据
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSString *token = [SAUserDataManager readToken];
    [SACommunityRequest requestDynamics:@{@"t": @(self.communityTableView.time), @"now": @(now)} user_id:28 token:token];
}

- (void)endFooterLoadingAnimation:(SAFooterLoadingView *)footerLoadingView {
    // 下拉加载更多数据
    NSString *token = [SAUserDataManager readToken];
    [SACommunityRequest requestDynamics:@{@"t": @(self.communityTableView.time), @"c": @(self.communityTableView.count)} user_id:28 token:token];
}


@end
