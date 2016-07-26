//
//  SASettingTableViewCell.m
//  Sigma
//
//  Created by Ace Hsieh on 7/25/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import "SASettingTableViewCell.h"

#import "SASettingCell.h"

#define TITLE_LEFT_MARGIN 30
#define LABEL_WIDTH 100
#define LABEL_HEIGHT 45

@interface SASettingTableViewCell()

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *additionInfoLabel;

@end

@implementation SASettingTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.contentView.backgroundColor=[UIColor whiteColor];
    
    UIView *maskView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    
    [self.contentView addSubview:maskView];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [maskView addSubview:self.titleLabel];
    [maskView addSubview:self.additionInfoLabel];
}

-(UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LEFT_MARGIN, 0, LABEL_WIDTH, LABEL_HEIGHT)];
        _titleLabel.font=[UIFont systemFontOfSize:16.f];
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    return _titleLabel;
}

-(UILabel*)additionInfoLabel{
    if (!_additionInfoLabel) {
        _additionInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-135, 0, LABEL_WIDTH, LABEL_HEIGHT)];
        _additionInfoLabel.backgroundColor = [UIColor clearColor];
        _additionInfoLabel.textAlignment = NSTextAlignmentRight;
        [_additionInfoLabel setFont:[UIFont systemFontOfSize:13.f]];
        [_additionInfoLabel setTextColor:COLOR_RGB(135, 135, 135)];
    }
    return _additionInfoLabel;
}

-(void)showMineCell{
    self.titleLabel.text = self.data.title;
    self.additionInfoLabel.text = self.data.additionInfo;
}


@end
