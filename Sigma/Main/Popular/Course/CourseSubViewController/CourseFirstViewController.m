//
//  CourseFirstViewController.m
//  Sigma
//
//  Created by 韩佳成 on 16/8/8.
//  Copyright © 2016年 韩佳成. All rights reserved.
//

#import "CourseFirstViewController.h"
#import "BriefIntroductionInfo.h"
#import "CourseEngine.h"

@interface CourseFirstViewController ()

@property(nonatomic,strong)UILabel* nameLabel;

@property(nonatomic,strong)UILabel* descriptionLabel;

@property(nonatomic,strong)UITableView* tableView;

@property(nonatomic,strong)NSMutableArray* dataArray;

@property(nonatomic,strong)BriefIntroductionInfo* briefIntroduction;

@end

@implementation CourseFirstViewController

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initUI];
    }
    return self;
}


-(void)initUI{
    self.dataArray = [[[CourseEngine shareInstances] briefIntroductionWithData] mutableCopy];
    BriefIntroductionInfo* info = (BriefIntroductionInfo*)[self.dataArray objectAtIndex:0];
    self.briefIntroduction = info;
    [self addSubview:self.tableView];
    [self.tableView addSubview:self.nameLabel];
    [self.tableView addSubview:self.descriptionLabel];
//    [self addSubview:self.nameLabel];
//    [self addSubview:self.descriptionLabel];
}

//延时加载课程名称
-(UILabel*)nameLabel{
    if(_nameLabel == nil){
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40*(SCREEN_WIDTH/SCREEN_HEIGHT), 10*(SCREEN_WIDTH/SCREEN_HEIGHT), SCREEN_WIDTH, 60*(SCREEN_WIDTH/SCREEN_HEIGHT))];
        _nameLabel.text = self.briefIntroduction.courseName;
    }
    return _nameLabel;
}

//延时加载课程的具体描述
-(UILabel*)descriptionLabel{
    if(_descriptionLabel == nil){
        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(40*(SCREEN_WIDTH/SCREEN_HEIGHT), 60*(SCREEN_WIDTH/SCREEN_HEIGHT), SCREEN_WIDTH-80*(SCREEN_WIDTH/SCREEN_HEIGHT), 200*(SCREEN_WIDTH/SCREEN_HEIGHT))];
        _descriptionLabel.text = self.briefIntroduction.courseDescription;
        _descriptionLabel.numberOfLines = 0;
        _descriptionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [_descriptionLabel setFont:[UIFont systemFontOfSize:13.0]];
    }
    return _descriptionLabel;
}

//延时加载tableview
-(UITableView*)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
         _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
