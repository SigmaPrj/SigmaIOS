//
//  SAComposeViewController.m
//  发送动态
//  Sigma
//
//  Created by Terence on 16/7/25.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAComposeViewController.h"
#import "SAComposeView.h"
#import "SAComposeToolBar.h"
#import "SAComposePhotosView.h"

@interface SAComposeViewController () <UITextViewDelegate,SAComposeToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(nonatomic, weak)SAComposeView* textView;
@property(nonatomic, weak)SAComposeToolBar* toolbar;
@property(nonatomic, weak)SAComposePhotosView* photosView;
@property(nonatomic, strong) UIBarButtonItem* rightItem;

@end

@implementation SAComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
   
    
    // 设置导航条
    [self setUpNavigationBar];
    
    // 添加textView
    [self setUpTextView];
    
    // 添加工具条
    [self setUpToolBar];
    
    // 监听键盘弹出，使用通知处理
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 添加相册视图
    [self setUpPhotosView];
}

// 设置相册视图
-(void)setUpPhotosView{
    SAComposePhotosView *photosView = [[SAComposePhotosView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height - 80)];
    _photosView = photosView;
    [_textView addSubview:photosView];
}

#pragma mark - 监听键盘弹出通知
-(void)keyboardFrameChange:(NSNotification *)note{
    
    CGFloat durtion = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    
    // 获取键盘frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    
    if (frame.origin.y == self.view.frame.size.height) {
        [UIView animateWithDuration:durtion animations:^{
            _toolbar.transform = CGAffineTransformIdentity;
        }];
        
    }else{ // 弹出键盘
        // 工具条向上移动键盘高度
        [UIView animateWithDuration:durtion animations:^{
            _toolbar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
        }];
    }
}


#pragma mark - 添加工具条
-(void)setUpToolBar{
    CGFloat h = 35;
    CGFloat y = self.view.frame.size.height - h;
    
    
    SAComposeToolBar* toolbar = [[SAComposeToolBar alloc] initWithFrame:CGRectMake(0, y, self.view.frame.size.width, h)];
    [self.view addSubview:toolbar];
    
    toolbar.delegate = self;
    _toolbar = toolbar;
}

#pragma mark - SAComposeToolBarDelegate 图片按钮点击触发相册
-(void)composeToolBar:(SAComposeToolBar *)toolBar didClickBnt:(NSInteger)index{
    
    if (index == 0) { // 点击相册
        // 弹出系统相册
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        
        // 设置相册类型
//        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        imagePicker.delegate = self;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }else if (index == 1){
        NSLog(@"camera");
      
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
       
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        imagePicker.delegate = self;
    }
}

#pragma mark - 选择图片完成的时候调用
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    // 获取选中图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
     _photosView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    _rightItem.enabled = YES;
}


#pragma mark - 添加textView
-(void)setUpTextView{
    SAComposeView* textView = [[SAComposeView alloc] initWithFrame:self.view.bounds];
    
    // 设置占位符
    _textView = textView;
    textView.placeHolder = @"分享新动态...";
    [self.view addSubview:textView];
    
    // 监听文本框输入，通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextViewTextDidChangeNotification object:nil];
    
    
    // 监听拖拽
    _textView.delegate = self;
}

#pragma mark - 开始拖拽
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:NO];
}

-(void)setUpNavigationBar{
    
    //设置可用导航条文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.158  green:0.215  blue:0.386 alpha:1];
    
    self.title = @"发布动态";
    // left
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:0 target:self action:@selector(dismiss:)];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
    
    // right
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(compose:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0.192  green:0.211  blue:0.232 alpha:1]forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    
    
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn sizeToFit];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
    rightItem.enabled = NO;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
    _rightItem = rightItem;
    
    
}

#pragma mark - 文字改变时候调用
-(void)textChange:(id)sender{
    // 判断textView有没有内容
    if (_textView.text.length) { //有内容
        _textView.hidePlaceHolder = YES;
        _rightItem.enabled = YES;
    }else{
        _textView.hidePlaceHolder = NO;
        _rightItem.enabled = NO;
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [_textView becomeFirstResponder];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)dismiss:(id)sender{
    if (sender && [sender isKindOfClass:[UIBarButtonItem class]]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [_delegate ComposeDismisssViewController];
    }
}

// 发送动态
-(void)compose:(id)sender{
    if (sender && [sender isKindOfClass:[UIButton class]]) {
        NSLog(@"send");
    }
}



@end
