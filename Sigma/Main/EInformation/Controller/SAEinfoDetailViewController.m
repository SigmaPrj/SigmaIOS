//
//  SAEinfoDetailViewController.m
//  Sigma
//
//  Created by Terence on 16/7/26.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAEinfoDetailViewController.h"
#import "TextEnhance.h"

#define BACKGROUND_IMG_HEIGHT 200
#define COMPETITION_TITLE_WIDTH 400 // 标题宽
#define COMPETITION_TITLE_HEIGHT 40 // 标题高

#define TIMELABEL_WIDTH 400
#define TIMTLABEL_HEIGHT 20

#define SAVELABEL_WIDTH 200
#define SAVELABEL_HEIGHT 30

#define DESCLABEL_WIDTH (SCREEN_WIDTH-20)
#define DESCLABEL_HEIGHT 140

#define TITLELABEL_WIDTH 70
#define TITLELABEL_HEIGHT 20

#define RULESVIEW_WIDTH SCREEN_WIDTH-20
#define RULESVIEW_HEIGHT 130

#define RULESTITLE_WIDTH 70
#define RULESTITLE_HEIGHT 20

#define ALLOWPERSONAL_WIDTH 200
#define ALLOWPERSONAL_HEIGHT 20

#define ALLOWTEAM_WIDTH 200
#define ALLOWTEAM_HEIGHT 20


@interface SAEinfoDetailViewController ()

@property(nonatomic, strong)UITableView* tableview;
@property(nonatomic, strong)UIView* desc;
@property(nonatomic, strong)UIImageView* bgImage;
@property(nonatomic, strong)SAEInfoDetailModel* model;
@property(nonatomic, strong)UIView* rulesView;

@end

@implementation SAEinfoDetailViewController

-(instancetype)initWithDetailData:(NSArray*)data index:(int)index{
    self = [super init];
    
    if (self) {
        self.view.backgroundColor = [UIColor colorWithRed:0.827  green:0.828  blue:0.827 alpha:1];
        self.currectIndex = index;
        self.detailDataArray = data;
        self.model = [SAEInfoDetailModel einformationModelWithDict:self.detailDataArray[self.currectIndex]];
        [self.view addSubview:self.tableview];
        [self.tableview addSubview:self.desc];
        [self.tableview addSubview:self.bgImage];
        [self.tableview addSubview:self.rulesView];
        
        
    }
    
    return self;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLeftNavigationItemWithTitle:nil imageName:@"back.png"];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(UITableView*)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-60)];
        _tableview.separatorStyle = NO;
//        _tableview.backgroundColor = [UIColor blueColor];
    }
    
    return _tableview;
}

-(UIImageView*)bgImage{
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, BACKGROUND_IMG_HEIGHT)];
        _bgImage.backgroundColor = [UIColor colorWithRed:0.866  green:0.889  blue:0.968 alpha:1];
        
        NSURL* url = [[NSURL alloc] initWithString:self.model.news_img];
        [_bgImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:url]]];
        
        // 遮罩层
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, BACKGROUND_IMG_HEIGHT)];
        view.backgroundColor = COLOR_RGBA(0, 0, 0, 0.4);
        [_bgImage addSubview:view];
        
        
        // 标题
        UILabel* competitionTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-COMPETITION_TITLE_WIDTH)/2, 15, COMPETITION_TITLE_WIDTH, COMPETITION_TITLE_HEIGHT)];
        [competitionTitleLabel setText:self.model.news_title];
        competitionTitleLabel.textColor = [UIColor orangeColor];
        competitionTitleLabel.textAlignment = NSTextAlignmentCenter;
        [competitionTitleLabel setFont:[UIFont systemFontOfSize:21.f]];
        [_bgImage addSubview:competitionTitleLabel];
        
        
        // 报名日期
        UILabel* applyTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-TIMELABEL_WIDTH)/2, (competitionTitleLabel.frame.origin.y+50), TIMELABEL_WIDTH, TIMTLABEL_HEIGHT)];
        
        NSString *time = [NSString stringWithFormat:@"赛程：%@ - %@",self.model.start_date,self.model.end_date];
        applyTimeLabel.textColor = [UIColor whiteColor];
        [applyTimeLabel setFont:[UIFont systemFontOfSize:13.f]];
        applyTimeLabel.text = time;
        applyTimeLabel.textAlignment = NSTextAlignmentCenter;
        [_bgImage addSubview:applyTimeLabel];
        
        // 收藏label
        UILabel* saveLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, _bgImage.frame.size.height-35, SAVELABEL_WIDTH, SAVELABEL_HEIGHT)];
//        saveLabel.backgroundColor = [UIColor blueColor];
        saveLabel.text = [NSString stringWithFormat:@"%d人收藏·%d人浏览",self.model.news_save_number, self.model.news_look_number];
        saveLabel.textColor = [UIColor whiteColor];
        [saveLabel setFont:[UIFont systemFontOfSize:11.f]];
        
        [TextEnhance resizeUILabelWidth:saveLabel];
        CGRect rect = saveLabel.frame;
        //        rect.origin.x = (SCREEN_WIDTH-_numberLabel.frame.size.width)/2;
//        rect.origin.x = SCREEN_WIDTH-saveLabel.frame.size.width-60;
        saveLabel.frame = rect;
        [_bgImage addSubview:saveLabel];
        UIImageView* loveIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, _bgImage.frame.size.height-37, 20, 20)];
        [loveIcon setImage:[UIImage imageNamed:@"love-active.png"]];
        [_bgImage addSubview:loveIcon];
        
    }
    
    return _bgImage;
}



/**
 *  描述label懒加载
 *
 *  @return
 */
-(UIView*)desc{
    if (!_desc) {
        _desc = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-DESCLABEL_WIDTH)/2, BACKGROUND_IMG_HEIGHT+30, DESCLABEL_WIDTH, DESCLABEL_HEIGHT)];
//        _desc.backgroundColor = [UIColor yellowColor];
        
        
        // 分隔线
        UIView* upline = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DESCLABEL_WIDTH, 0.5)];
        upline.backgroundColor = [UIColor colorWithRed:0.827  green:0.828  blue:0.827 alpha:1];
        [_desc addSubview:upline];
        
        // 赛事简介标题
        UILabel* titleLable = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, TITLELABEL_WIDTH, TITLELABEL_HEIGHT)];
        titleLable.text = @"赛事简介";
//        titleLable.textAlignment = NSTextAlignmentCenter;
        [titleLable setFont:[UIFont systemFontOfSize:14.f]];
        [_desc addSubview:titleLable];
        
        // 赛事简介详情
        UILabel* detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLable.frame.origin.y + 20, DESCLABEL_WIDTH, DESCLABEL_HEIGHT-(titleLable.frame.origin.y + 20)-10)];
        [detailLabel setFont:[UIFont systemFontOfSize:13.f]];
        detailLabel.numberOfLines = 0;
//        detailLabel.textAlignment = NSTextAlignmentCenter;
        detailLabel.text = self.model.news_desc;
        [_desc addSubview:detailLabel];
        
        
        // 分隔线
        UIView* downline = [[UIView alloc] initWithFrame:CGRectMake(0, DESCLABEL_HEIGHT, DESCLABEL_WIDTH, 0.5)];
        downline.backgroundColor = [UIColor colorWithRed:0.827  green:0.828  blue:0.827 alpha:1];
        [_desc addSubview:downline];

    }
    
    return _desc;
}

-(UIView*)rulesView{
    if (!_rulesView) {
        _rulesView = [[UIView alloc] initWithFrame:CGRectMake(self.desc.frame.origin.x,self.desc.frame.origin.y + 20 + RULESVIEW_HEIGHT, RULESVIEW_WIDTH, RULESVIEW_HEIGHT)];
        
        // 报名规则
        UILabel* rulesTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, RULESTITLE_WIDTH, RULESTITLE_HEIGHT)];
        rulesTitle.text = @"报名规则";
        [rulesTitle setFont:[UIFont systemFontOfSize:14.f]];
        [_rulesView addSubview:rulesTitle];
        
//        "allow_personal": 1
//        "allow_team": 0  "team_min_number": 2  "team_max_number": 5
//        "allow_teacher": 0
        UILabel* allowPeronalLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, rulesTitle.frame.origin.y + 30, ALLOWPERSONAL_WIDTH, ALLOWPERSONAL_HEIGHT)];
        [allowPeronalLabel setFont:[UIFont systemFontOfSize:12.f]];
        UILabel* allowTeamLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, allowPeronalLabel.frame.origin.y+20, ALLOWTEAM_WIDTH, ALLOWTEAM_HEIGHT)];
        [allowTeamLabel setFont:[UIFont systemFontOfSize:12.f]];
        NSString* allowpersonalstr = [NSString string];
        NSString* allowTeamstr = [NSString string];
        
        if ((self.model.allow_personal == 1) && (self.model.allow_team == 1) ) {
            allowpersonalstr = [NSString stringWithFormat:@"是否允许个人参赛：%@", @"是"];
            allowTeamstr = [NSString stringWithFormat:@"是否允许组队参赛：%@ (%d ~ %d人)", @"是", self.model.team_min_number, self.model.team_max_number];
        } else if ((self.model.allow_personal == 1) && (self.model.allow_team == 0)){
            allowpersonalstr = [NSString stringWithFormat:@"是否允许个人参赛：%@", @"是"];
            allowTeamstr = [NSString stringWithFormat:@"是否允许组队参赛：%@", @"否"];
        } else if ((self.model.allow_personal == 0) && (self.model.allow_team == 1)){
            allowpersonalstr = [NSString stringWithFormat:@"是否允许个人参赛：%@", @"否"];
            allowTeamstr = [NSString stringWithFormat:@"是否允许组队参赛：%@ (%d ~ %d人)", @"是", self.model.team_min_number, self.model.team_max_number];
        } else {
            allowpersonalstr = [NSString stringWithFormat:@"是否允许个人参赛：%@", @"是"];
            allowTeamstr = [NSString stringWithFormat:@"是否允许组队参赛：%@ (%d ~ %d人)", @"是", self.model.team_min_number, self.model.team_max_number];
        }
        
        allowPeronalLabel.text = allowpersonalstr;
        allowTeamLabel.text = allowTeamstr;
        
        
        // 分隔线
        UIView* downline = [[UIView alloc] initWithFrame:CGRectMake(0, RULESVIEW_HEIGHT-30, RULESVIEW_WIDTH, 0.5)];
        downline.backgroundColor = [UIColor colorWithRed:0.827  green:0.828  blue:0.827 alpha:1];
        [_rulesView addSubview:downline];
        
        [_rulesView addSubview:allowPeronalLabel];
        [_rulesView addSubview:allowTeamLabel];
        
    }
    return _rulesView;
}



@end
