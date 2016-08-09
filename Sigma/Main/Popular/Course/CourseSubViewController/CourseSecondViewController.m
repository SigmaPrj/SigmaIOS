//
//  CourseSecondViewController.m
//  Sigma
//
//  Created by 韩佳成 on 16/8/8.
//  Copyright © 2016年 韩佳成. All rights reserved.
//

#import "CourseSecondViewController.h"
#import "AuthorInfo.h"
#import "CourseEngine.h"
#import "UIImageView+WebCache.h"

@interface CourseSecondViewController ()

@property(nonatomic,strong)UITableView* tableView;

//作者头像的view
@property(nonatomic,strong)UIImageView* headImageView;

//作者名字的label
@property(nonatomic,strong)UILabel* authorNickNameLabel;

//作者城市的label
@property(nonatomic,strong)UILabel* authorCityLabel;

@property(nonatomic,strong)NSMutableArray* dataArray;

@property(nonatomic,strong)AuthorInfo* authorInfo;

@end

@implementation CourseSecondViewController

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.dataArray = [[[CourseEngine shareInstances] authorInfoWithData] mutableCopy];
    AuthorInfo* authorInfo = (AuthorInfo*)[self.dataArray objectAtIndex:0];
    self.authorInfo = authorInfo;
    [self addSubview:self.tableView];
    [self.tableView addSubview:self.headImageView];
    [self.tableView addSubview:self.authorNickNameLabel];
    [self.tableView addSubview:self.authorCityLabel];
}

//延时加载tableView
-(UITableView*)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

//延时加载作者头像的view
-(UIImageView*)headImageView{
    if(_headImageView == nil){
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100*(SCREEN_WIDTH/SCREEN_HEIGHT))/2, 40*(SCREEN_WIDTH/SCREEN_HEIGHT), 100*(SCREEN_WIDTH/SCREEN_HEIGHT), 100*(SCREEN_WIDTH/SCREEN_HEIGHT))];
        NSURL* urlImage = [NSURL URLWithString:self.authorInfo.headImageName];
        [_headImageView sd_setImageWithURL:urlImage];
        _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
        _headImageView.layer.masksToBounds = YES;

    }
    return _headImageView;
}

//延时加载作者名字的label
-(UILabel*)authorNickNameLabel{
    if(_authorNickNameLabel == nil){
        _authorNickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-400*(SCREEN_WIDTH/SCREEN_HEIGHT))/2, 150*(SCREEN_WIDTH/SCREEN_HEIGHT), 400*(SCREEN_WIDTH/SCREEN_HEIGHT), 60*(SCREEN_WIDTH/SCREEN_HEIGHT))];
        _authorNickNameLabel.text = [NSString stringWithFormat:@"作者: %@",self.authorInfo.nickName];
        [_authorNickNameLabel setFont:[UIFont systemFontOfSize:13.0]];
        _authorNickNameLabel.textAlignment = NSTextAlignmentCenter;
}
    return _authorNickNameLabel;
}

//延时加载作者城市的label
-(UILabel*)authorCityLabel{
    if(_authorCityLabel == nil){
        _authorCityLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200*(SCREEN_WIDTH/SCREEN_HEIGHT))/2, 220*(SCREEN_WIDTH/SCREEN_HEIGHT), 200*(SCREEN_WIDTH/SCREEN_HEIGHT), 60*(SCREEN_WIDTH/SCREEN_HEIGHT))];
        _authorCityLabel.text = [NSString stringWithFormat:@"城市: %@",self.authorInfo.city];
        [_authorCityLabel setFont:[UIFont systemFontOfSize:13.0]];
        _authorCityLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _authorCityLabel;
}

@end
