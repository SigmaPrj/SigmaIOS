//
//  SASettingViewEngine.m
//  Sigma
//
//  Created by Ace Hsieh on 7/25/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import "SASettingViewEngine.h"

#import "SASettingCell.h"

@interface SASettingViewEngine()

@property(nonatomic,strong)NSMutableArray *dataArray1;
@property(nonatomic,strong)NSMutableArray *dataArray2;
@property(nonatomic,strong)NSMutableArray *dataArray3;

@end

@implementation SASettingViewEngine


+(instancetype)shareInstance{
    static SASettingViewEngine *instance=nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[SASettingViewEngine alloc]init];
    });
    return instance;
}

-(instancetype)init{
    self=[super init];
    if (self) {
        _dataArray1=[[NSMutableArray alloc]init];
        _dataArray2=[[NSMutableArray alloc]init];
        _dataArray3=[[NSMutableArray alloc]init];
        
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

-(void)mineInitDataSection:(NSDictionary*)list{
    [_dataArray1 addObject:[[SASettingCell alloc]initWithTitle:@"帐号设置" andAdditionalInfo:@""]];
    
    [_dataArray2 addObject:[[SASettingCell alloc]initWithTitle:@"意见反馈" andAdditionalInfo:@""]];
    [_dataArray2 addObject:[[SASettingCell alloc]initWithTitle:@"去评分" andAdditionalInfo:@""]];
    [_dataArray2 addObject:[[SASettingCell alloc]initWithTitle:@"推荐给朋友" andAdditionalInfo:@""]];
    
    [_dataArray3 addObject:[[SASettingCell alloc]initWithTitle:@"清除缓存" andAdditionalInfo:@""]];
    [_dataArray3 addObject:[[SASettingCell alloc]initWithTitle:@"帮助中心" andAdditionalInfo:@""]];
    [_dataArray3 addObject:[[SASettingCell alloc]initWithTitle:@"关于" andAdditionalInfo:@""]];
    
}

@end
