//
//  SAQuestionViewController.m
//  Sigma
//
//  Created by Terence on 16/7/26.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAQuestionViewController.h"
#import "SAComposeView.h"

@interface SAQuestionViewController () <UITextViewDelegate, UINavigationControllerDelegate>

@property(nonatomic, strong) UIBarButtonItem* rightItem;
@property(nonatomic, weak)SAComposeView* textView;

@end

@implementation SAQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    // 设置导航条
    [self setUpNavigationBar];
    
    // 添加textView
    [self setUpTextView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


#pragma mark - 添加navigationbar
-(void)setUpNavigationBar{
    
    //设置可用导航条文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.158  green:0.215  blue:0.386 alpha:1];
    
    self.title = @"发布提问";
    // left
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:0 target:self action:@selector(dismiss:)];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
    
    // right
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(compose:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"提问" forState:UIControlStateNormal];
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


#pragma mark - 添加textView
-(void)setUpTextView{
    SAComposeView* textView = [[SAComposeView alloc] initWithFrame:self.view.bounds];
    
    // 设置占位符
    _textView = textView;
    textView.placeHolder = @"提出自己的问题吧...";
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

-(void)dismiss:(id)sender{
    if (sender && [sender isKindOfClass:[UIBarButtonItem class]]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [_delegate questionDismissViewController];
    }
}

// 发送动态
-(void)compose:(id)sender{
    if (sender && [sender isKindOfClass:[UIButton class]]) {
        NSLog(@"question");
    }
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

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
