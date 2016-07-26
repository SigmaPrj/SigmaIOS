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

@interface SAMineViewEngine()

@property(nonatomic,strong)NSMutableArray *dataArray1;
@property(nonatomic,strong)NSMutableArray *dataArray2;
@property(nonatomic,strong)NSMutableArray *dataArray3;
@property(nonatomic,strong)SAUser *user;

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
        [self mineSetUser:nil];
        [self mineInitDataSection:nil];
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



@end
