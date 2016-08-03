//
//  SAMineViewEngine.m
//  Sigma
//
//  Created by Ace Hsieh on 7/16/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import "SAMineViewEngine.h"

#import "SAUser.h"
#import "SAMineCell.h"
#import "SADynamicModel.h"
//#import "SACommunityUserModel.h"


@interface SAMineViewEngine()

@property(nonatomic,strong)NSMutableArray *dataArray1;
@property(nonatomic,strong)NSMutableArray *dataArray2;
@property(nonatomic,strong)NSMutableArray *dataArray3;
@property(nonatomic,strong)SAUser *user;
//@property (nonatomic, strong) NSDictionary* userDict; // 头部用户数据


@end

@implementation SAMineViewEngine


+(instancetype)shareInstance{
    static SAMineViewEngine *instance=nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[SAMineViewEngine alloc]init];
    });
    return instance;
}

-(instancetype)init{
    self=[super init];
    if (self) {
        _dataArray1=[[NSMutableArray alloc]init];
        _dataArray2=[[NSMutableArray alloc]init];
        _dataArray3=[[NSMutableArray alloc]init];
        
        _user=[[SAUser alloc]init];
//        _userModel=[[SACommunityUserModel alloc]init];
        [self mineSetUser:nil];
        [self mineInitDataSection:nil];
//        [self setUserModel:_userModel];
    }
    return self;
}

-(NSArray*)dataSection1{
    return self.dataArray1;
}

-(NSArray*)dataSection2{
    return self.dataArray2;
}

-(NSArray*)dataSection3{
    return self.dataArray3;
}

-(void)mineSetUser:(SAUser*)user{
    _user.headImageName=@"Head_Img_Of_HeaderView";
    _user.userName=@"Tsezihin";
    _user.level=1;
//    self.userModel = [SACommunityUserModel userModelWithDict:self.userDict];

//    NSLog(@"nickname=%@",self.userModel.nickname);
//
//    _user.userName=self.userModel.nickname;
    
    _user.feeds=10;
    _user.numberOfFollowers=20;
    _user.numberOfFans=30;
    _user.credits=40;

}

-(SAUser*)mineGetUser{
    return self.user;
}

-(void)mineInitDataSection:(NSDictionary*)list{
    [_dataArray1 addObject:[[SAMineCell alloc]initWithTitle:@"我的赛事" andAdditionalInfo:@""]];
    [_dataArray1 addObject:[[SAMineCell alloc]initWithTitle:@"我的课程" andAdditionalInfo:@""]];
    [_dataArray1 addObject:[[SAMineCell alloc]initWithTitle:@"我的问答" andAdditionalInfo:@""]];
    [_dataArray1 addObject:[[SAMineCell alloc]initWithTitle:@"我的消息" andAdditionalInfo:@""]];
    
    [_dataArray2 addObject:[[SAMineCell alloc]initWithTitle:@"我的足迹" andAdditionalInfo:@""]];
    [_dataArray2 addObject:[[SAMineCell alloc]initWithTitle:@"我的收藏" andAdditionalInfo:@""]];
    
    [_dataArray3 addObject:[[SAMineCell alloc]initWithTitle:@"设置" andAdditionalInfo:@""]];
    
}

//- (void)setUserModel:(SACommunityUserModel *)userModel {
//    _userModel = userModel;
//    
//    [self renderData];
//}

// 给组件添加内容和修改frame
//- (void)renderData {
    // 设置背景图片
//    NSURL *bgImageUrl = [NSURL URLWithString:self.userModel.bgImage];
//    [self.bgImageView sd_setImageWithURL:bgImageUrl placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageProgressiveDownload];
    
    // 设置avatarImageView frame
//    NSURL *avatarImageUrl = [NSURL URLWithString:self.userModel.image];
//    [self.avatarImageView sd_setImageWithURL:avatarImageUrl placeholderImage:[UIImage imageNamed:@"avatar60"] options:SDWebImageRetryFailed | SDWebImageProgressiveDownload];
    
    // 设置approvedImageView frame
//    if (self.userModel.is_approved == 1) {
//        CGFloat aImageLeft = MinX(self.avatarImageView)-COMMUNITY_APPROVED_IMAGE_SIZE-COMMUNITY_HEADER_VIEW_PADDING;
//        CGFloat aImageTop = self.frame.size.height - COMMUNITY_APPROVED_IMAGE_SIZE - COMMUNITY_HEADER_VIEW_BOTTOM;
//        self.approvedImageView.frame = CGRectMake(aImageLeft, aImageTop, COMMUNITY_APPROVED_IMAGE_SIZE, COMMUNITY_APPROVED_IMAGE_SIZE);
//    }
    
    // 设置 nickNameLabel frame
//    self.nickNameLabel.text = self.userModel.nickname;
//    CGRect newNickNameLabelFrame = [self.userModel.nickname boundingRectWithSize:CGSizeMake(200, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:COMMUNITY_HEADER_VIEW_NICKNAME_SIZE]} context:nil];
//    if (self.userModel.is_approved == 1) {
//        newNickNameLabelFrame.origin.x = MinX(self.approvedImageView) - newNickNameLabelFrame.size.width-COMMUNITY_COMPONENT_PADDING;
//        newNickNameLabelFrame.origin.y = self.frame.size.height - COMMUNITY_COMPONENT_PADDING - newNickNameLabelFrame.size.height;
//        self.nickNameLabel.frame = newNickNameLabelFrame;
//        _nickNameLabel.textColor = COMMUNITY_APPROVED_NAME_COLOR;
//    } else {
//        newNickNameLabelFrame.origin.x = MinX(self.avatarImageView) - newNickNameLabelFrame.size.width-COMMUNITY_COMPONENT_PADDING;
//        newNickNameLabelFrame.origin.y = self.frame.size.height - COMMUNITY_COMPONENT_PADDING - newNickNameLabelFrame.size.height;
//        self.nickNameLabel.frame = newNickNameLabelFrame;
//        _nickNameLabel.textColor = COMMUNITY_TEXT_COLOR;
//    }
    
//    NSLog(@"nickname=%@",self.userModel.nickname);
//}



@end
