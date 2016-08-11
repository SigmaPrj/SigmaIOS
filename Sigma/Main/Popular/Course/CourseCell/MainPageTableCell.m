//
//  MainPageTableCell.m
//  Sigma
//
//  Created by 韩佳成 on 16/7/27.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "MainPageTableCell.h"
#import "CourseCommonDefine.h"
#import "MainPageCellInfo.h"
#import "UIImageView+WebCache.h"

@interface MainPageTableCell()

//每个cell头的图片
@property(nonatomic,strong)UIImageView* headImageView;

//每个cell的课程的名称
@property(nonatomic,strong)UILabel* classNameLabel;

//每个cell显示多少人学习的label
@property(nonatomic,strong)UILabel* numOfStudyLabel;

//为了传递具体描述的label
@property(nonatomic,strong)UILabel* descriptionLabel;

//为了传递具体作者图片的label
@property(nonatomic,strong)UILabel* headImageLabel;

//为了传递作者昵称的label
@property(nonatomic,strong)UILabel* authorNameLabel;

//为了传递作者城市的label
@property(nonatomic,strong)UILabel* authorCityLabel;

//为了传递视频地址的label
@property(nonatomic,strong)UILabel* videoUrlPathLabel;

@end

@implementation MainPageTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        //使cell没有点击阴影
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.contentView.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.classNameLabel];
    [self.contentView addSubview:self.numOfStudyLabel];
    [self.contentView addSubview:self.descriptionLabel];
    [self.contentView addSubview:self.headImageLabel];
    [self.contentView addSubview:self.authorNameLabel];
    [self.contentView addSubview:self.authorCityLabel];
    [self.contentView addSubview:self.videoUrlPathLabel];
}

//延时加载cell头的图片
-(UIImageView*)headImageView{
    if(_headImageView == nil){
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MAINPAGECELL_X, MAINPAGECELL_Y, MAINPAGECELL_WIDTH, MAINPAGECELL_HEIGHT)];
    }
    return _headImageView;
}

//延时加载每个cell的课程的名称
-(UILabel*)classNameLabel{
    if(_classNameLabel == nil){
        _classNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(MAINPAGENAMELABEL_X, 0, MAINPAGENAMELABEL_WIDTH, MAINPAGENAMELABEL_HEIGHT)];
        _classNameLabel.adjustsFontSizeToFitWidth = YES;
        [_classNameLabel setFont:[UIFont systemFontOfSize:16.0]];
        _classNameLabel.tag = 1000;
    }
    return _classNameLabel;
}

//延时加载每个cell显示多少人学习的label
-(UILabel*)numOfStudyLabel{
    if(_numOfStudyLabel == nil){
        _numOfStudyLabel = [[UILabel alloc] initWithFrame:CGRectMake(MAINPAGENUMOFSTUDY_X, MAINPAGENUMOFSTUDY_Y, MAINPAGENUMOFSTUDY_WIDTH, MAINPAGENUMOFSTYDY_HEIGHT)];
        _numOfStudyLabel.adjustsFontSizeToFitWidth = YES;
        [_numOfStudyLabel setFont:[UIFont systemFontOfSize:10.0]];
    }
    return _numOfStudyLabel;
}

//延时加载传递具体描述的label
-(UILabel*)descriptionLabel{
    if(_descriptionLabel == nil){
        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _descriptionLabel.tag = 2000;
    }
    return _descriptionLabel;
}

//延时加载传递作者头像的label
-(UILabel*)headImageLabel{
    if(_headImageLabel == nil){
        _headImageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _headImageLabel.tag = 3000;
    }
    return _headImageLabel;
}

//延时加载传递作者昵称的label
-(UILabel*)authorNameLabel{
    if(_authorNameLabel == nil){
        _authorNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _authorNameLabel.tag = 4000;
    }
    return _authorNameLabel;
}

//延时加载传递作者城市的label
-(UILabel*)authorCityLabel{
    if(_authorCityLabel == nil){
        _authorCityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _authorCityLabel.tag = 5000;
    }
    return _authorCityLabel;
}

//延时加载传递视频地址的label
-(UILabel*)videoUrlPathLabel{
    if(_videoUrlPathLabel == nil){
        _videoUrlPathLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _videoUrlPathLabel.tag = 6000;
    }
    return _videoUrlPathLabel;
}

//获得cell中控件的内容
-(void)showMainPageViewCell{
    NSURL* urlImage = [NSURL URLWithString:self.mainPageCellInfo.imageName];
    [self.headImageView sd_setImageWithURL:urlImage];
    self.classNameLabel.text = self.mainPageCellInfo.className;
    self.numOfStudyLabel.text = [NSString stringWithFormat:@"%d人学习",self.mainPageCellInfo.numOfStudy];
    self.descriptionLabel.text = self.mainPageCellInfo.descriptionOfCourse;
    self.headImageLabel.text = self.mainPageCellInfo.headImageName;
    self.authorNameLabel.text = self.mainPageCellInfo.nickname;
    self.authorCityLabel.text = self.mainPageCellInfo.city;
    self.videoUrlPathLabel.text = self.mainPageCellInfo.courseVideoUrlPath;
}

@end
