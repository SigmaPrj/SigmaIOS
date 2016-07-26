//
//  SAEInformationCell.m
//  Sigma
//
//  Created by Terence on 16/7/18.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAEInformationCell.h"
#import "SAEInformationModel.h"

@interface SAEInformationCell ()

@property(nonatomic, strong)UIImageView* mainImgView;
@property(nonatomic, strong)UILabel* descLabel;
@property(nonatomic, strong)UILabel* numberLabel;
@property(nonatomic, strong)SAEInformationModel* data;

@end

@implementation SAEInformationCell

/**
 *  重写initWithStyle
 *
 *  @param style           <#style description#>
 *  @param reuseIdentifier <#reuseIdentifier description#>
 *
 *  @return <#return value description#>
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

/**
 *  设置数据
 *
 *  @param data 
 */
-(void)setData:(SAEInformationModel *)data{
    _data = data;
}

/**
 *  初始化UI
 *
 *  @return <#return value description#>
 */
-(instancetype)initUI{
    
    return self;
}


-(UIImageView*)mainImgView{
    if (!_mainImgView) {
        _mainImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 50, 50)];
        
    }
    return _mainImgView;
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end
