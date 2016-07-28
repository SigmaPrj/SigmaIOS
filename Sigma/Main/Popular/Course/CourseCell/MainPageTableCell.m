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

@interface MainPageTableCell()

//每个cell头的图片
@property(nonatomic,strong)UIImageView* headImageView;

//每个cell的课程的名称
@property(nonatomic,strong)UILabel* classNameLabel;

//每个cell显示多少人学习的label
@property(nonatomic,strong)UILabel* numOfStudyLabel;

@end

@implementation MainPageTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.contentView.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.classNameLabel];
    [self.contentView addSubview:self.numOfStudyLabel];
}

//延时加载cell头的图片
-(UIImageView*)headImageView{
    if(_headImageView == nil){
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, MAINPAGECELL_Y, MAINPAGECELL_WIDTH, MAINPAGECELL_HEIGHT)];
    }
    return _headImageView;
}

//延时加载每个cell的课程的名称
-(UILabel*)classNameLabel{
    if(_classNameLabel == nil){
        _classNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(MAINPAGENAMELABEL_X, 0, MAINPAGENAMELABEL_WIDTH, MAINPAGENAMELABEL_HEIGHT)];
        _classNameLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _classNameLabel;
}

//延时加载每个cell显示多少人学习的label
-(UILabel*)numOfStudyLabel{
    if(_numOfStudyLabel == nil){
        _numOfStudyLabel = [[UILabel alloc] initWithFrame:CGRectMake(MAINPAGENUMOFSTUDY_X, MAINPAGENUMOFSTUDY_Y, MAINPAGENUMOFSTUDY_WIDTH, MAINPAGENUMOFSTYDY_HEIGHT)];
        _numOfStudyLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _numOfStudyLabel;
}

//获得cell中控件的内容
-(void)showMainPageViewCell{
    self.headImageView.image = [UIImage imageNamed:self.mainPageCellInfo.imageName];
    self.classNameLabel.text = self.mainPageCellInfo.className;
    self.numOfStudyLabel.text = [NSString stringWithFormat:@"%d人学习",self.mainPageCellInfo.numOfStudy];
}


@end
