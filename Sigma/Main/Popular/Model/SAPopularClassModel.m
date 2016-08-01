//
//  SAPopularClassModel.m
//  Sigma
//
//  Created by Terence on 16/7/29.
//  Copyright © 2016年 韩佳成. All rights reserved.
//

#import "SAPopularClassModel.h"
#import "SADateHelper.h"

@implementation SAPopularClassModel

- (instancetype) initWithDict:(NSDictionary *)dict{
    
//    @property(nonatomic, assign) int popularclass_id; // class这条消息的id
//    @property(nonatomic, assign) int ouser_id; // 用户id
//    @property(nonatomic, copy) NSString* title; // 课程标题
//    @property(nonatomic, copy) NSString* desc; // 课程描述
//    @property(nonatomic, copy) NSString* bg_image; // 背景图地址
//    @property(nonatomic, copy) NSString* url; // 视频的url地址
//    @property(nonatomic, assign) int category; // 类别id
//    
//    @property(nonatomic, assign) int learn; // 学习课程的人数
//    @property(nonatomic, assign) int save; //保存课程的人数
//    @property(nonatomic, copy) NSString* publish_date; // 发布时间
//    @property(nonatomic, copy) NSString* last_look_date; // 上次被查看时间
//    
//    @property(nonatomic, assign) int ouserid; //ouserid
//    @property(nonatomic, copy) NSString* nickname; // 用户昵称
//    
//    @property(nonatomic, assign) int is_approved; // 用户是否被验证
//    @property(nonatomic, copy) NSString* city_name; // 机构所在城市
    
    _popularclass_id = [dict[@"id"] intValue];
    _ouserid = [dict[@"ouser_id"] intValue];
    _title = dict[@"title"];
    _desc = dict[@"description"];
    _bg_image = dict[@"image"];
    _url = dict[@"url"];
    _category = [dict[@"category"] intValue];
    _learn = [dict[@"learn"] intValue];
    _save = [dict[@"save"] intValue];
    _publish_date = [SADateHelper humanizedDate:[dict[@"publish_date"] intValue]];
    _last_look_date = [SADateHelper humanizedDate:[dict[@"last_look_date"] intValue]];
    
    _ouserid = [[dict valueForKeyPath:@"ouser.id"] intValue];
    _nickname = [dict valueForKeyPath:@"ouser.nickname"];
    _avata = [dict valueForKeyPath:@"ouser.image"];
    _is_approved = [[dict valueForKeyPath:@"ouser.is_approved"] intValue];
    _city_name = [dict valueForKeyPath:@"ouser.city"];

    
    return self;
}

+ (instancetype) classWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}


@end
