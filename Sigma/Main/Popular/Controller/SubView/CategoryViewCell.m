//
//  CategoryViewCell.m
//  Sigma
//
//  Created by 韩佳成 on 16/7/19.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "CategoryViewCell.h"
#import "CategoryInfo.h"

//定义第一列图片的横坐标
#define FIRSTLINE_IMAGEX 20*(SCREEN_WIDTH/SCREEN_HEIGHT)
//定义第一行图片的纵坐标
#define FIRSTROW_IMAGEY 80*(SCREEN_WIDTH/SCREEN_HEIGHT)
//定义图片的长和宽，为正方形
#define IMAGE_WIDTHANDHEIGHT 100*(SCREEN_WIDTH/SCREEN_HEIGHT)
//定义描述label的高度
#define DESLABEL_HEIGHT 44*(SCREEN_WIDTH/SCREEN_HEIGHT)
//定义第二列图片的横坐标
#define SECONDLINE_IMAGEX SCREEN_WIDTH-200*(SCREEN_WIDTH/SCREEN_HEIGHT)-IMAGE_WIDTHANDHEIGHT
//定义第二行图片的纵坐标
#define SECONDROW_IMAGEY FIRSTROW_IMAGEY+IMAGE_WIDTHANDHEIGHT+20*(SCREEN_WIDTH/SCREEN_HEIGHT)
//定义第三行图片的纵左边
#define THIRD_IMAGEY SECONDROW_IMAGEY+IMAGE_WIDTHANDHEIGHT+20*(SCREEN_WIDTH/SCREEN_HEIGHT)


@interface CategoryViewCell()

//每个cell的标题
@property(nonatomic,strong)UILabel* cellNameLabel;

//第一个图片的button
@property(nonatomic,strong)UIButton* imageButton1;

//第一个图片右边描述内容的label
@property(nonatomic,strong)UILabel* desLabel1;

//第一个图片右边显示数量的label
@property(nonatomic,strong)UILabel* numLabel1;

//第一个图片的button
@property(nonatomic,strong)UIButton* imageButton2;

//第二个描述label
@property(nonatomic,strong)UILabel* desLabel2;

//第二个图片右边显示数量的label
@property(nonatomic,strong)UILabel* numLabel2;

//第三个图片的button
@property(nonatomic,strong)UIButton* imageButton3;

//第三个描述label
@property(nonatomic,strong)UILabel* desLabel3;

//第三个图片右边显示数量的label
@property(nonatomic,strong)UILabel* numLabel3;

//第四个图片的button
@property(nonatomic,strong)UIButton* imageButton4;

//第四个描述label
@property(nonatomic,strong)UILabel* desLabel4;

//第四个图片右边显示数量的label
@property(nonatomic,strong)UILabel* numLabel4;

//第五个图片的button
@property(nonatomic,strong)UIButton* imageButton5;

//第五个描述label
@property(nonatomic,strong)UILabel* desLabel5;

//第五个图片右边显示数量的label
@property(nonatomic,strong)UILabel* numLabel5;

//第六个图片的button
@property(nonatomic,strong)UIButton* imageButton6;

//第六个描述label
@property(nonatomic,strong)UILabel* desLabel6;

//第六个图片右边显示数量的label
@property(nonatomic,strong)UILabel* numLabel6;

@end

@implementation CategoryViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        //将cell设计为不能点击
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.cellNameLabel];
    [self.contentView addSubview:self.imageButton1];
    [self.contentView addSubview:self.desLabel1];
    [self.contentView addSubview:self.numLabel1];
    [self.contentView addSubview:self.imageButton2];
    [self.contentView addSubview:self.desLabel2];
    [self.contentView addSubview:self.numLabel2];
    [self.contentView addSubview:self.imageButton3];
    [self.contentView addSubview:self.desLabel3];
    [self.contentView addSubview:self.numLabel3];
    [self.contentView addSubview:self.imageButton4];
    [self.contentView addSubview:self.desLabel4];
    [self.contentView addSubview:self.numLabel4];
    [self.contentView addSubview:self.imageButton5];
    [self.contentView addSubview:self.desLabel5];
    [self.contentView addSubview:self.numLabel5];
    [self.contentView addSubview:self.imageButton6];
    [self.contentView addSubview:self.desLabel6];
    [self.contentView addSubview:self.numLabel6];



}

//延时加载cell的标题
-(UILabel*)cellNameLabel{
    if(_cellNameLabel == nil){
        _cellNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20*(SCREEN_WIDTH/SCREEN_HEIGHT), 0, 220*(SCREEN_WIDTH/SCREEN_HEIGHT), 66*(SCREEN_WIDTH/SCREEN_HEIGHT))];
        _cellNameLabel.backgroundColor = [UIColor whiteColor];
        [_cellNameLabel setTextColor:[UIColor blackColor]];
        _cellNameLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _cellNameLabel;
}

//延时加载第一个图片button
-(UIButton*)imageButton1{
    if(_imageButton1 == nil){
        _imageButton1 = [[UIButton alloc] initWithFrame:CGRectMake(FIRSTLINE_IMAGEX, FIRSTROW_IMAGEY, IMAGE_WIDTHANDHEIGHT, IMAGE_WIDTHANDHEIGHT)];
    }
    return _imageButton1;
}



//延时加载第一个label
-(UILabel*)desLabel1{
    if(_desLabel1 == nil){
        _desLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(FIRSTLINE_IMAGEX+IMAGE_WIDTHANDHEIGHT+20*(SCREEN_WIDTH/SCREEN_HEIGHT), FIRSTROW_IMAGEY+20*(SCREEN_WIDTH/SCREEN_HEIGHT), 160*(SCREEN_WIDTH/SCREEN_HEIGHT), DESLABEL_HEIGHT)];
        _desLabel1.backgroundColor = [UIColor whiteColor];
        [_desLabel1 setTextColor:[UIColor blackColor]];
        _desLabel1.adjustsFontSizeToFitWidth = YES;
    }
    return _desLabel1;
}

//延时加载第一个数量label
-(UILabel*)numLabel1{
    if(_numLabel1 == nil){
        _numLabel1 = [[UILabel alloc] initWithFrame:(CGRectMake(FIRSTLINE_IMAGEX+IMAGE_WIDTHANDHEIGHT+20*(SCREEN_WIDTH/SCREEN_HEIGHT), FIRSTROW_IMAGEY+20*(SCREEN_WIDTH/SCREEN_HEIGHT)+DESLABEL_HEIGHT, 100*(SCREEN_WIDTH/SCREEN_HEIGHT), DESLABEL_HEIGHT))];
        _numLabel1.backgroundColor = [UIColor whiteColor];
        [_numLabel1 setTextColor:COLOR_RGB(101, 101, 101)];
        _numLabel1.adjustsFontSizeToFitWidth = YES;
    }
    return _numLabel1;
}

//延时加载第二个图片button
-(UIButton*)imageButton2{
    if(_imageButton2 == nil){
        _imageButton2 = [[UIButton alloc] initWithFrame:CGRectMake(SECONDLINE_IMAGEX, FIRSTROW_IMAGEY, IMAGE_WIDTHANDHEIGHT, IMAGE_WIDTHANDHEIGHT)];
    }
    return _imageButton2;
}

//延时加载第二个label
-(UILabel*)desLabel2{
    if(_desLabel2 == nil){
        _desLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(SECONDLINE_IMAGEX+IMAGE_WIDTHANDHEIGHT+20*(SCREEN_WIDTH/SCREEN_HEIGHT), FIRSTROW_IMAGEY+20*(SCREEN_WIDTH/SCREEN_HEIGHT), 160*(SCREEN_WIDTH/SCREEN_HEIGHT), DESLABEL_HEIGHT)];
        _desLabel2.backgroundColor = [UIColor whiteColor];
        [_desLabel2 setTextColor:[UIColor blackColor]];
        _desLabel2.adjustsFontSizeToFitWidth = YES;
    }
    return _desLabel2;
}

//延时加载第二个数量label
-(UILabel*)numLabel2{
    if(_numLabel2 == nil){
        _numLabel2 = [[UILabel alloc] initWithFrame:(CGRectMake(SECONDLINE_IMAGEX+IMAGE_WIDTHANDHEIGHT+20*(SCREEN_WIDTH/SCREEN_HEIGHT), FIRSTROW_IMAGEY+20*(SCREEN_WIDTH/SCREEN_HEIGHT)+DESLABEL_HEIGHT, 100*(SCREEN_WIDTH/SCREEN_HEIGHT), DESLABEL_HEIGHT))];
        _numLabel2.backgroundColor = [UIColor whiteColor];
        [_numLabel2 setTextColor:COLOR_RGB(101, 101, 101)];
        _numLabel2.adjustsFontSizeToFitWidth = YES;
    }
    return _numLabel2;
}


//延时加载第三个图片button
-(UIButton*)imageButton3{
    if(_imageButton3 == nil){
        _imageButton3 = [[UIButton alloc] initWithFrame:CGRectMake(FIRSTLINE_IMAGEX, SECONDROW_IMAGEY, IMAGE_WIDTHANDHEIGHT, IMAGE_WIDTHANDHEIGHT)];
    }
    return _imageButton3;
}


//延时加载第三个label
-(UILabel*)desLabel3{
    if(_desLabel3 == nil){
        _desLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(FIRSTLINE_IMAGEX+IMAGE_WIDTHANDHEIGHT+20*(SCREEN_WIDTH/SCREEN_HEIGHT), SECONDROW_IMAGEY+20*(SCREEN_WIDTH/SCREEN_HEIGHT), 160*(SCREEN_WIDTH/SCREEN_HEIGHT), DESLABEL_HEIGHT)];
        _desLabel3.backgroundColor = [UIColor whiteColor];
        [_desLabel3 setTextColor:[UIColor blackColor]];
        _desLabel3.adjustsFontSizeToFitWidth = YES;
    }
    return _desLabel3;
}

//延时加载第三个数量label
-(UILabel*)numLabel3{
    if(_numLabel3 == nil){
        _numLabel3 = [[UILabel alloc] initWithFrame:(CGRectMake(FIRSTLINE_IMAGEX+IMAGE_WIDTHANDHEIGHT+20*(SCREEN_WIDTH/SCREEN_HEIGHT), SECONDROW_IMAGEY+20*(SCREEN_WIDTH/SCREEN_HEIGHT)+DESLABEL_HEIGHT, 100*(SCREEN_WIDTH/SCREEN_HEIGHT), DESLABEL_HEIGHT))];
        _numLabel3.backgroundColor = [UIColor whiteColor];
        [_numLabel3 setTextColor:COLOR_RGB(101, 101, 101)];
        _numLabel3.adjustsFontSizeToFitWidth = YES;
    }
    return _numLabel3;
}

//延时加载第四个图片button
-(UIButton*)imageButton4{
    if(_imageButton4 == nil){
        _imageButton4 = [[UIButton alloc] initWithFrame:CGRectMake(SECONDLINE_IMAGEX, SECONDROW_IMAGEY, IMAGE_WIDTHANDHEIGHT, IMAGE_WIDTHANDHEIGHT)];
    }
    return _imageButton4;
}

//延时加载第四个label
-(UILabel*)desLabel4{
    if(_desLabel4 == nil){
        _desLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(SECONDLINE_IMAGEX+IMAGE_WIDTHANDHEIGHT+20*(SCREEN_WIDTH/SCREEN_HEIGHT), SECONDROW_IMAGEY+20*(SCREEN_WIDTH/SCREEN_HEIGHT), 160*(SCREEN_WIDTH/SCREEN_HEIGHT), DESLABEL_HEIGHT)];
        _desLabel4.backgroundColor = [UIColor whiteColor];
        [_desLabel4 setTextColor:[UIColor blackColor]];
        _desLabel4.adjustsFontSizeToFitWidth = YES;
    }
    return _desLabel4;
}

//延时加载第四个数量label
-(UILabel*)numLabel4{
    if(_numLabel4 == nil){
        _numLabel4 = [[UILabel alloc] initWithFrame:(CGRectMake(SECONDLINE_IMAGEX+IMAGE_WIDTHANDHEIGHT+20*(SCREEN_WIDTH/SCREEN_HEIGHT), SECONDROW_IMAGEY+20*(SCREEN_WIDTH/SCREEN_HEIGHT)+DESLABEL_HEIGHT, 100*(SCREEN_WIDTH/SCREEN_HEIGHT), DESLABEL_HEIGHT))];
        _numLabel4.backgroundColor = [UIColor whiteColor];
        [_numLabel4 setTextColor:COLOR_RGB(101, 101, 101)];
        _numLabel4.adjustsFontSizeToFitWidth = YES;
    }
    return _numLabel4;
}

//延时加载第五个图片button
-(UIButton*)imageButton5{
    if(_imageButton5 == nil){
        _imageButton5 = [[UIButton alloc] initWithFrame:CGRectMake(FIRSTLINE_IMAGEX, THIRD_IMAGEY, IMAGE_WIDTHANDHEIGHT, IMAGE_WIDTHANDHEIGHT)];
    }
    return _imageButton5;
}


//延时加载第五个label
-(UILabel*)desLabel5{
    if(_desLabel5 == nil){
        _desLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(FIRSTLINE_IMAGEX+IMAGE_WIDTHANDHEIGHT+20*(SCREEN_WIDTH/SCREEN_HEIGHT), THIRD_IMAGEY+20*(SCREEN_WIDTH/SCREEN_HEIGHT), 160*(SCREEN_WIDTH/SCREEN_HEIGHT), DESLABEL_HEIGHT)];
        _desLabel5.backgroundColor = [UIColor whiteColor];
        [_desLabel5 setTextColor:[UIColor blackColor]];
        _desLabel5.adjustsFontSizeToFitWidth = YES;
    }
    return _desLabel5;
}

//延时加载第五个数量label
-(UILabel*)numLabel5{
    if(_numLabel5 == nil){
        _numLabel5 = [[UILabel alloc] initWithFrame:(CGRectMake(FIRSTLINE_IMAGEX+IMAGE_WIDTHANDHEIGHT+20*(SCREEN_WIDTH/SCREEN_HEIGHT), THIRD_IMAGEY+20*(SCREEN_WIDTH/SCREEN_HEIGHT)+DESLABEL_HEIGHT, 100*(SCREEN_WIDTH/SCREEN_HEIGHT), DESLABEL_HEIGHT))];
        _numLabel5.backgroundColor = [UIColor whiteColor];
        [_numLabel5 setTextColor:COLOR_RGB(101, 101, 101)];
        _numLabel5.adjustsFontSizeToFitWidth = YES;
    }
    return _numLabel5;
}

//延时加载第六个图片button
-(UIButton*)imageButton6{
    if(_imageButton6 == nil){
        _imageButton6 = [[UIButton alloc] initWithFrame:CGRectMake(SECONDLINE_IMAGEX, THIRD_IMAGEY, IMAGE_WIDTHANDHEIGHT, IMAGE_WIDTHANDHEIGHT)];
    }
    return _imageButton6;
}

//延时加载第六个label
-(UILabel*)desLabel6{
    if(_desLabel6 == nil){
        _desLabel6 = [[UILabel alloc] initWithFrame:CGRectMake(SECONDLINE_IMAGEX+IMAGE_WIDTHANDHEIGHT+20*(SCREEN_WIDTH/SCREEN_HEIGHT), THIRD_IMAGEY+20*(SCREEN_WIDTH/SCREEN_HEIGHT), 160*(SCREEN_WIDTH/SCREEN_HEIGHT), DESLABEL_HEIGHT)];
        _desLabel6.backgroundColor = [UIColor whiteColor];
        [_desLabel6 setTextColor:[UIColor blackColor]];
        _desLabel6.adjustsFontSizeToFitWidth = YES;
    }
    return _desLabel6;
}

//延时加载第六个数量label
-(UILabel*)numLabel6{
    if(_numLabel6 == nil){
        _numLabel6 = [[UILabel alloc] initWithFrame:(CGRectMake(SECONDLINE_IMAGEX+IMAGE_WIDTHANDHEIGHT+20*(SCREEN_WIDTH/SCREEN_HEIGHT), THIRD_IMAGEY+20*(SCREEN_WIDTH/SCREEN_HEIGHT)+DESLABEL_HEIGHT, 100*(SCREEN_WIDTH/SCREEN_HEIGHT), DESLABEL_HEIGHT))];
        _numLabel6.backgroundColor = [UIColor whiteColor];
        [_numLabel6 setTextColor:COLOR_RGB(101, 101, 101)];
        _numLabel6.adjustsFontSizeToFitWidth = YES;
    }
    return _numLabel6;
}


//将cell中的内容显示出来
-(void)showCategoryCell{
    self.cellNameLabel.text = self.categoryInfor.cellName;
    [self.imageButton1 setImage:[UIImage imageNamed:self.categoryInfor.imageName1] forState:UIControlStateNormal];
    self.desLabel1.text = self.categoryInfor.desLabel1;
    self.numLabel1.text = [NSString stringWithFormat:@"%d",self.categoryInfor.numLabel1];
    [self.imageButton2 setImage:[UIImage imageNamed:self.categoryInfor.imageName2] forState:UIControlStateNormal];
    self.desLabel2.text = self.categoryInfor.desLabel2;
    self.numLabel2.text = [NSString stringWithFormat:@"%d",self.categoryInfor.numLabel2];
    [self.imageButton3 setImage:[UIImage imageNamed:self.categoryInfor.imageName3] forState:UIControlStateNormal];
    self.desLabel3.text = self.categoryInfor.desLabel3;
    self.numLabel3.text = [NSString stringWithFormat:@"%d",self.categoryInfor.numLabel3];
    [self.imageButton4 setImage:[UIImage imageNamed:self.categoryInfor.imageName4] forState:UIControlStateNormal];
    self.desLabel4.text = self.categoryInfor.desLabel4;
    self.numLabel4.text = [NSString stringWithFormat:@"%d",self.categoryInfor.numLabel4];
    [self.imageButton5 setImage:[UIImage imageNamed:self.categoryInfor.imageName5] forState:UIControlStateNormal];
    self.desLabel5.text = self.categoryInfor.desLabel5;
    self.numLabel5.text = [NSString stringWithFormat:@"%d",self.categoryInfor.numLabel5];
   [self.imageButton6 setImage:[UIImage imageNamed:self.categoryInfor.imageName6] forState:UIControlStateNormal];
    self.desLabel6.text = self.categoryInfor.desLabel6;
    self.numLabel6.text = [NSString stringWithFormat:@"%d",self.categoryInfor.numLabel6];

}



@end
