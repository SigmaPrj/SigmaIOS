//
//  SAEInfoDetailModel.m
//  Sigma
//
//  Created by Terence on 16/7/26.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAEInfoDetailModel.h"
#import "SADateHelper.h"

@implementation SAEInfoDetailModel


-(instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
//    @property(nonatomic, assign) int news_id;
//    @property(nonatomic, copy) NSString* news_title;
//    @property(nonatomic, copy) NSString* news_desc;
//    @property(nonatomic, copy) NSString* news_img;
//    @property(nonatomic, assign) int news_type;
//    
//    @property(nonatomic, copy) NSString* publish_date; // 发布时间
//    @property(nonatomic, copy) NSString* last_look_date; // 上次被查看时间
//    
//    
//    @property(nonatomic, copy) NSString* start_date; // 开始时间
//    @property(nonatomic, copy) NSString* end_date; // 结束时间
//    
//    @property(nonatomic, assign) int allow_personal; // 是否允许个人报名
//    @property(nonatomic, assign) int allow_team; // 是否允许组队报名
//    @property(nonatomic, assign) int allow_teacher; // 是否需要导师
//    
//    @property(nonatomic, assign) int team_min_number; // 组队最小参与人数
//    @property(nonatomic, assign) int team_max_number; // 组队最大参与人数
//    
//    @property(nonatomic, assign) int news_save_number; // 收藏资讯数量
//    @property(nonatomic, assign) int news_look_number; // 查看资讯数量
//    @property(nonatomic, assign) int news_join_number; // 参与活动人数数量
    
    
    
    if (self) {
        _news_id = [dict[@"id"] intValue];
        _news_title = dict[@"title"];
        _news_desc = dict[@"descriptions"];
        _news_img = dict[@"image"];
        _news_type = [dict[@"news_type"] intValue];
        
        _publish_date = [SADateHelper humanizedDate:[dict[@"publish_date"] intValue]];
        _last_look_date = [SADateHelper humanizedDate:[dict[@"last_look_date"] intValue]];
        
        _start_date = [SADateHelper humanizedDate:[dict[@"s_date"] intValue]];
        _end_date = [SADateHelper humanizedDate:[dict[@"e_date"] intValue]];
        
        _allow_personal = [dict[@"allow_personal"] intValue];
        _allow_team = [dict[@"allow_team"] intValue];
        _allow_teacher = [dict[@"allow_teacher"] intValue];
        
        _team_min_number = [dict[@"team_min_number"] intValue];
        _team_max_number = [dict[@"team_max_number"] intValue];
        
        _news_save_number = [dict[@"save"] intValue];
        _news_look_number = [dict[@"look"] intValue];
        _news_join_number = [dict[@"join"] intValue];
                            
    }
    
    return self;
}


+(instancetype)einformationModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
