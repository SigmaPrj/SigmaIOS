//
//  SASettingAboutViewController.m
//  Sigma
//
//  Created by Ace Hsieh on 7/25/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import "SASettingAboutViewController.h"

#import "TextEnhance.h"

#define MARGIN 15


#define IMAGE_NAME @"Head_Img_Of_HeaderView"
#define IMAGE_REC_SIZE 80

@interface SASettingAboutViewController ()

@property(nonatomic,strong)UIImageView* logoImgView;
@property(nonatomic,strong)UILabel* nameLabel;
@property(nonatomic,strong)UILabel* versionLabel;
//@property(nonatomic,strong)UILabel* additionInfoLabel;

@end

@implementation SASettingAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.title=@"关于Sigma";
    self.view.backgroundColor=[UIColor colorWithWhite:0.902 alpha:1.000];
    
    [self.view addSubview:self.logoImgView];
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.versionLabel];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(UIImageView*)logoImgView{
    if (!_logoImgView) {
        _logoImgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:IMAGE_NAME]];
        _logoImgView.frame=CGRectMake((SCREEN_WIDTH-IMAGE_REC_SIZE)/2, IMAGE_REC_SIZE/2, IMAGE_REC_SIZE, IMAGE_REC_SIZE);
    }
    return _logoImgView;
}

-(UILabel*)nameLabel{
    if (!_nameLabel) {
        _nameLabel=[[UILabel alloc]init];
        _nameLabel.frame=CGRectMake(0, CGRectGetMaxY(self.logoImgView.frame)+MARGIN, SCREEN_WIDTH, 20);
        
        _nameLabel.text=@"Sigma-让竞赛更简单";
        [_nameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
        [_nameLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _nameLabel;
    
}


-(UILabel*)versionLabel{
    if (!_versionLabel) {
        _versionLabel=[[UILabel alloc]init];
        _versionLabel.text=@"版本号：V1.0";
        [_versionLabel setFont:[UIFont systemFontOfSize:11.f]];
        [_versionLabel setTextAlignment:NSTextAlignmentCenter];
        _versionLabel.frame=CGRectMake(0, CGRectGetMaxY(self.nameLabel.frame)+MARGIN/1.5, SCREEN_WIDTH, 20);
        
    }
    return _versionLabel;
}

//-(UILabel*)additionInfoLabel{
//    if (!_additionInfoLabel) {
//        
//    }
//    return _additionInfoLabel;
//}

@end
