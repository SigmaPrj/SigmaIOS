//
//  ContentOfSourceHeadView.m
//  Sigma
//
//  Created by 韩佳成 on 16/7/22.
//  Copyright © 2016年 Terence. All rights reserved.
//

//资源名称label的宽度
#define SOURCENAMELABLE_WIDTH 400*(SCREEN_WIDTH/SCREEN_HEIGHT)
//资源名称label的高度
#define SOURCENAMELABLE_HEIGHT 80*(SCREEN_WIDTH/SCREEN_HEIGHT)
//资源具体描述的纵坐标
#define SOURCEDESCRIPTION_Y 30*(SCREEN_WIDTH/SCREEN_HEIGHT)
//资源具体描述的高度
#define SOURCEDESCRIPTION_HEIGHT 300*(SCREEN_WIDTH/SCREEN_HEIGHT)
//资源点赞label的横坐标
#define SUPPORTNUM_X 90*(SCREEN_WIDTH/SCREEN_HEIGHT)
//资源点赞label的纵坐标
#define SUPPORTNUM_Y SOURCEDESCRIPTION_Y+SOURCEDESCRIPTION_HEIGHT+50*(SCREEN_WIDTH/SCREEN_HEIGHT)
//资源点赞label的宽度
#define SUPPORTNUM_WIDTH 100*(SCREEN_WIDTH/SCREEN_HEIGHT)
//资源点赞label的高度
#define SUPPORTNUM_HEIGHT 40*(SCREEN_WIDTH/SCREEN_HEIGHT)
//资源下载label的横坐标
#define DOWNLOADNUM_X SCREEN_WIDTH-30*(SCREEN_WIDTH/SCREEN_HEIGHT)-100*(SCREEN_WIDTH/SCREEN_HEIGHT)
//资源点赞button的横坐标
#define SUPPORTBUTTON_X 30*(SCREEN_WIDTH/SCREEN_HEIGHT)
//资源点赞button的宽度
#define SUPPORTBUTTON_WIDHT 40*(SCREEN_WIDTH/SCREEN_HEIGHT)
//资源下载button的横坐标
#define DOWNLOADBUTTON_X DOWNLOADNUM_X-SUPPORTBUTTON_WIDHT
//资源下载button的宽度
#define DOWNLOADBUTTON_WIDTH 35*(SCREEN_WIDTH/SCREEN_HEIGHT)
//写评论的button的纵坐标
#define WRITECOMMENT_Y SUPPORTNUM_Y+SUPPORTNUM_HEIGHT+10*(SCREEN_WIDTH/SCREEN_HEIGHT)
//写评论的button的宽度
#define WRITECOMMENT_WIDTH SCREEN_WIDTH-60*(SCREEN_WIDTH/SCREEN_HEIGHT)
//写评论的button的高度
#define WRITECOMMENT_HEIGHT 60*(SCREEN_WIDTH/SCREEN_HEIGHT)


#import "ContentOfSourceHeadView.h"
#import "SourceEngineInterface.h"
#import "ContentOfSouceHeadInfo.h"

@interface ContentOfSourceHeadView ()

//资源名称的label
@property(nonatomic,strong)UILabel* sourceNameLabel;

//资源的具体描述
@property(nonatomic,strong)UILabel* descriptionOfSource;

//资源的点赞数量
@property(nonatomic,strong)UILabel* supportNumberLabel;

//资源下载的数量
@property(nonatomic,strong)UILabel* downloadNumberLabel;

//资源点赞的图片button
@property(nonatomic,strong)UIButton* supportNumberButton;

//资源下载的图片button
@property(nonatomic,strong)UIButton* downloadNumberButton;

//写评论button
@property(nonatomic,strong)UIButton* writeCommentButton;

//数据array
@property(nonatomic,strong)NSMutableArray* dataArray;

//view层的数据
@property(nonatomic,strong)ContentOfSouceHeadInfo* contentOfSourceHeadInfo;

@end

@implementation ContentOfSourceHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.dataArray = [[[SourceEngineInterface shareInstances] contentOfSourcePageWithData] mutableCopy];
    _contentOfSourceHeadInfo = [[ContentOfSouceHeadInfo alloc] init];
    for(int index =0 ; index < self.dataArray.count; index++){
        _contentOfSourceHeadInfo = (ContentOfSouceHeadInfo*)[self.dataArray objectAtIndex:index];
    }
    [self addSubview:self.sourceNameLabel];
    [self addSubview:self.descriptionOfSource];
    [self addSubview:self.supportNumberLabel];
    [self addSubview:self.downloadNumberLabel];
    [self addSubview:self.supportNumberButton];
    [self addSubview:self.downloadNumberButton];
    [self addSubview:self.writeCommentButton];
}

//延时加载资源名称的label
-(UILabel*)sourceNameLabel{
    if(_sourceNameLabel == nil){
        _sourceNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20*SCREEN_WIDTH/SCREEN_HEIGHT, 30*SCREEN_WIDTH/SCREEN_HEIGHT, SOURCENAMELABLE_WIDTH, SOURCENAMELABLE_HEIGHT)];
        _sourceNameLabel.text = self.contentOfSourceHeadInfo.sourceName;
        _sourceNameLabel.backgroundColor = [UIColor clearColor];
        [_sourceNameLabel setTextColor:[UIColor blackColor]];
        [_sourceNameLabel sizeToFit];
    }
    return _sourceNameLabel;
}

//延时加载资源的具体描述
-(UILabel*)descriptionOfSource{
    if(_descriptionOfSource == nil){
        _descriptionOfSource = [[UILabel alloc] initWithFrame:CGRectMake(20*SCREEN_WIDTH/SCREEN_HEIGHT, SOURCEDESCRIPTION_Y, SCREEN_WIDTH-40*SCREEN_WIDTH/SCREEN_HEIGHT, SOURCEDESCRIPTION_HEIGHT)];
        _descriptionOfSource.text = self.contentOfSourceHeadInfo.descriptionOfSource;
        _descriptionOfSource.backgroundColor = [UIColor clearColor];
        [_descriptionOfSource setTextColor:COLOR_RGB(153, 153, 153)];
        _descriptionOfSource.numberOfLines = 0;
        _descriptionOfSource.textAlignment = NSTextAlignmentLeft;
        [_descriptionOfSource sizeToFit];
//        _descriptionOfSource.lineBreakMode = NSLineBreakByTruncatingTail;
        [_descriptionOfSource setFont:[UIFont systemFontOfSize:14.0]];

    }
    return _descriptionOfSource;
}

//延时加载资源点赞数量的label
-(UILabel*)supportNumberLabel{
    if(_supportNumberLabel == nil){
        _supportNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(SUPPORTNUM_X, SUPPORTNUM_Y, SUPPORTNUM_WIDTH, SUPPORTNUM_HEIGHT)];
        _supportNumberLabel.text = self.contentOfSourceHeadInfo.supportNumber;
        _supportNumberLabel.backgroundColor = [UIColor clearColor];
        [_supportNumberLabel setFont:[UIFont systemFontOfSize:12.f]];
        [_supportNumberLabel setTextColor:COLOR_RGB(153, 153, 153)];
    }
    return _supportNumberLabel;
}

//延时加载资源下载数量的label
-(UILabel*)downloadNumberLabel{
    if(_downloadNumberLabel == nil){
        _downloadNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(DOWNLOADNUM_X, SUPPORTNUM_Y, SUPPORTNUM_WIDTH, SUPPORTNUM_HEIGHT)];
        _downloadNumberLabel.text = self.contentOfSourceHeadInfo.downloadNumber;
        [_downloadNumberLabel setFont:[UIFont systemFontOfSize:12.f]];
        _downloadNumberLabel.backgroundColor = [UIColor clearColor];
        [_downloadNumberLabel setTextColor:COLOR_RGB(153, 153, 153)];
    }
    return _downloadNumberLabel;
}

//延时加载资源点赞数量的button
-(UIButton*)supportNumberButton{
    if(_supportNumberButton == nil){
        _supportNumberButton = [[UIButton alloc] initWithFrame:CGRectMake(SUPPORTBUTTON_X, SUPPORTNUM_Y, SUPPORTBUTTON_WIDHT, 35*SCREEN_WIDTH/SCREEN_HEIGHT)];
        [_supportNumberButton setImage:[UIImage imageNamed:@"supportNumber.png"] forState:UIControlStateNormal];
        [_supportNumberButton addTarget:self action:@selector(supportButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _supportNumberButton;
}

//点赞button的事件
-(void)supportButtonClicked:(id)sender{
    if(sender && [sender isKindOfClass:[UIButton class]]){
        NSLog(@"加一次赞");
        [self.supportNumberButton setImage:[UIImage imageNamed:@"clickedSupportNumber.png"] forState:UIControlStateNormal];
    }
}

//延时加载资源下载数量的button
-(UIButton*)downloadNumberButton{
    if(_downloadNumberButton == nil){
        _downloadNumberButton = [[UIButton alloc] initWithFrame:CGRectMake(DOWNLOADBUTTON_X, SUPPORTNUM_Y, DOWNLOADBUTTON_WIDTH, SUPPORTNUM_HEIGHT)];
        [_downloadNumberButton setImage:[UIImage imageNamed:@"downloadNumber.png"] forState:UIControlStateNormal];
        [_downloadNumberButton addTarget:self action:@selector(downloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _downloadNumberButton;
}

//下载button的事件
-(void)downloadButtonClicked:(id)sender{
    if(sender && [sender isKindOfClass:[UIButton class]]){
        NSLog(@"下载");
    }
}

//延时加载写评论的button
-(UIButton*)writeCommentButton{
    if(_writeCommentButton == nil){
        _writeCommentButton = [[UIButton alloc] initWithFrame:CGRectMake(SUPPORTBUTTON_X, WRITECOMMENT_Y+40*SCREEN_WIDTH/SCREEN_HEIGHT, WRITECOMMENT_WIDTH, WRITECOMMENT_HEIGHT)];
        _writeCommentButton.backgroundColor = [UIColor clearColor];
        //设置button边界线的宽度和颜色
        [_writeCommentButton.layer setBorderWidth:1.0];
        [_writeCommentButton.layer setBorderColor:[COLOR_RGB(153, 153, 153) CGColor]];
        //设置button的圆角
        [_writeCommentButton.layer setMasksToBounds:YES];
        [_writeCommentButton.layer setCornerRadius:10.0];
        
        //在button上添加图片
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake((WRITECOMMENT_WIDTH-150*(SCREEN_WIDTH/SCREEN_HEIGHT))/2, 10*(SCREEN_WIDTH/SCREEN_HEIGHT), 40*(SCREEN_WIDTH/SCREEN_HEIGHT), 40*(SCREEN_WIDTH/SCREEN_HEIGHT))];
        imageView.image = [UIImage imageNamed:@"writerCommen.png"];
        [_writeCommentButton addSubview:imageView];
        
        //在button上添加label
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake((WRITECOMMENT_WIDTH-150*(SCREEN_WIDTH/SCREEN_HEIGHT))/2+50*(SCREEN_WIDTH/SCREEN_HEIGHT), 10*(SCREEN_WIDTH/SCREEN_HEIGHT), SUPPORTNUM_WIDTH, 40*(SCREEN_WIDTH/SCREEN_HEIGHT))];
        label.text = @"写评论";
        [label setTextColor:COLOR_RGB(168, 168, 168)];
        [_writeCommentButton addSubview:label];
        
        [_writeCommentButton addTarget:self action:@selector(commentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _writeCommentButton;
}

//写评论button的事件
-(void)commentButtonClicked:(id)sender{
    if(sender && [sender isKindOfClass:[UIButton class]]){
        NSLog(@"写评论");
    }
}

@end
