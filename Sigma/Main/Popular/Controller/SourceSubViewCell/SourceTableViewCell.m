//
//  SourceTableViewCell.m
//  Sigma
//
//  Created by 韩佳成 on 16/7/17.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SourceTableViewCell.h"
#import "SourceMainPageInfo.h"
#import "SourceCommonDefine.h"
#import "UIImageView+WebCache.h"

@interface SourceTableViewCell()

//资源名称的label
@property(nonatomic,strong)UILabel* sourceNameLabel;

//资源页面每个cell的时间的label
@property(nonatomic,strong)UILabel* sourceDateLabel;

//资源页面每个cell的具体描述的cell
@property(nonatomic,strong)UILabel* sourceDescriptionLabel;

//资源页面每个cell左下角的图标
@property(nonatomic,strong)UIImageView* leftBottomImageView;

//资源页面每个cell右下角点赞的label
@property(nonatomic,strong)UILabel* supportLabel;

//资源页面每个cell右下角评论的label
@property(nonatomic,strong)UILabel* commmentLabel;

//资源页面每个cell右下角下载的label
@property(nonatomic,strong)UILabel* downloadLabel;

@end

@implementation SourceTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [ self.contentView addSubview:self.sourceNameLabel];
    [ self.contentView addSubview:self.sourceDateLabel];
    [ self.contentView addSubview:self.sourceDescriptionLabel];
    [ self.contentView addSubview:self.leftBottomImageView];
    [ self.contentView addSubview:self.supportLabel];
    [ self.contentView addSubview:self.commmentLabel];
    [ self.contentView addSubview:self.downloadLabel];
}

//定义资源名的label
-(UILabel*)sourceNameLabel{
    if(_sourceNameLabel == nil){
        _sourceNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20*(SCREEN_WIDTH/SCREEN_HEIGHT), 0, SCREEN_WIDTH*3/4, CELL_HEIGHT/4)];
        _sourceNameLabel.backgroundColor = [UIColor whiteColor];
        _sourceNameLabel.tag = 1000;
        [_sourceNameLabel setFont:[UIFont systemFontOfSize:16.0]];
    }
    return _sourceNameLabel;
}

//定义资源时间的label
-(UILabel*)sourceDateLabel{
    if(_sourceDateLabel == nil){
        _sourceDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*3/4, 0, SCREEN_WIDTH/4, CELL_HEIGHT/4)];
        _sourceDateLabel.backgroundColor = [UIColor whiteColor];
        [_sourceDateLabel setFont:[UIFont systemFontOfSize:12.0]];
    }
    return _sourceDateLabel;
}

//定义资源具体描述的label
-(UILabel*)sourceDescriptionLabel{
    if(_sourceDescriptionLabel == nil){
        _sourceDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20*(SCREEN_WIDTH/SCREEN_HEIGHT), CELL_HEIGHT/4, (SCREEN_WIDTH-20*(SCREEN_WIDTH/SCREEN_HEIGHT)*2), CELL_HEIGHT/2)];
        _sourceDescriptionLabel.backgroundColor = [UIColor whiteColor];
        _sourceDescriptionLabel.numberOfLines = 3;
        _sourceDescriptionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _sourceDescriptionLabel.tag = 2000;
        [_sourceDescriptionLabel setFont:[UIFont systemFontOfSize:13.0]];
    }
    return _sourceDescriptionLabel;
}

//定义资源页面左下角的图标
-(UIImageView*)leftBottomImageView{
    if(_leftBottomImageView == nil){
        _leftBottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, CELL_HEIGHT*3/4, 30, 30)];
        
    }
    return _leftBottomImageView;
}

//定义资源页面右下角点赞的label
-(UILabel*)supportLabel{
    if(_supportLabel == nil){
        _supportLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, CELL_HEIGHT*3/4+5, 50, 20)];
        _supportLabel.backgroundColor = [UIColor whiteColor];
        _supportLabel.tag = 3000;
        [_supportLabel setFont:[UIFont systemFontOfSize:12.0]];
    }
    return _supportLabel;
}

//定义资源页面右下角评论的label
-(UILabel*)commmentLabel{
    if(_commmentLabel == nil){
        _commmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+65, CELL_HEIGHT*3/4+5, 50, 20)];
         _commmentLabel.backgroundColor = [UIColor whiteColor];
        [_commmentLabel setFont:[UIFont systemFontOfSize:12.0]];
    }
    return _commmentLabel;
}

//定义资源页面右下角下载的label
-(UILabel*)downloadLabel{
    if(_downloadLabel == nil){
        _downloadLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+130, CELL_HEIGHT*3/4+5, 60, 20)];
        _downloadLabel.backgroundColor = [UIColor whiteColor];
        _downloadLabel.tag = 4000;
        [_downloadLabel setFont:[UIFont systemFontOfSize:12.0]];
    }
    return _downloadLabel;
}

//将cell中的数据显示出来
-(void)showSourceCell{
    self.sourceNameLabel.text = self.sourceMainPageInfo.title;
    self.sourceDateLabel.text = self.sourceMainPageInfo.publish_date;
    self.sourceDescriptionLabel.text = self.sourceMainPageInfo.desc;
    self.supportLabel.text = [NSString stringWithFormat:@"%d点赞",self.sourceMainPageInfo.save];
    self.commmentLabel.text = [NSString stringWithFormat:@"%d评论",self.sourceMainPageInfo.look];
    self.downloadLabel.text = [NSString stringWithFormat:@"%d下载",self.sourceMainPageInfo.download];
    NSURL* urlImage = [NSURL URLWithString:self.sourceMainPageInfo.image];
    [self.leftBottomImageView sd_setImageWithURL:urlImage];
}
@end
