//
//  SAViewController.m
//  Sigma
//
//  Created by Terence on 16/7/13.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAViewController.h"

@interface SAViewController ()

@end

@implementation SAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

/**
 *  初始化公共操作
 */
-(instancetype)init{
    self = [super init];
    if (self){
        // 设置背景颜色和大小
        self.view.backgroundColor = COLOR_RGB(245, 245, 245);
        self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }

    return self;
}

/**
 * 添加搜索按钮
 */
-(void)addSearchBarButton {

}


/**
 *  右上角添加按钮
 *
 *  @param title     文字说明
 *  @param imageName    图片名称
 */
- (void)setRightNavigationItemWithTitle:(NSString *)title imageName:(NSString *)imageName
{
    if(imageName)
    {
        UIImage *rightImage = [UIImage imageNamed:imageName];
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setImage:rightImage forState:UIControlStateNormal];
        rightButton.frame = CGRectMake(0, 0, rightImage.size.width, rightImage.size.height);
        [rightButton addTarget:self action:@selector(rightItemTapped) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        self.navigationItem.rightBarButtonItem = rightItem;
        return;
    }
    if(title)
    {
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightItemTapped)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    
}

/**
 *  左上角按钮
 *
 *  @param title 文字说明
 *  @param imageName 图片名称
 */
- (void)setLeftNavigationItemWithTitle:(NSString *)title imageName:(NSString *)imageName{
    if(imageName)
    {
        UIImage *leftImage = [UIImage imageNamed:imageName];
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton setImage:leftImage forState:UIControlStateNormal];
        leftButton.frame = CGRectMake(0, 0, leftImage.size.width, leftImage.size.height);
        [leftButton addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        self.navigationItem.leftBarButtonItem = leftItem;
        return;
    }
    if(title)
    {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(doBack:)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }

}


-(void)rightItemTapped{
    NSLog(@"rightItemTapped clicked");
}

-(void)doBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
