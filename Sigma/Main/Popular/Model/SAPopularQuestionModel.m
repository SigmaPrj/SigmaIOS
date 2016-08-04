//
//  SAPopularQuestionModel.m
//  Sigma
//
//  Created by Terence on 16/7/28.
//  Copyright © 2016年 韩佳成. All rights reserved.
//

#import "SAPopularQuestionModel.h"
#import "SADateHelper.h"

@implementation SAPopularQuestionModel

- (instancetype) initWithDict:(NSDictionary *)dict{
//    @property(nonatomic, assign) int popques_id;
//    @property(nonatomic, assign) int user_id;
//    // 可能要展示的数据
//    @property(nonatomic, assign) int topic_id;
//    // 展示
//    @property(nonatomic, copy) NSString* topic;
//    @property(nonatomic, copy) NSString* title;
//    @property(nonatomic, copy) NSString* url;
//    @property(nonatomic, assign) int duration;
//    @property(nonatomic, assign) int pay_type;
//    @property(nonatomic, assign) int pay_num;
//    @property(nonatomic, assign) int is_free;
//    
//    // 展示
//    @property(nonatomic, assign) int look;
//    @property(nonatomic, assign) int save;
//    @property(nonatomic, assign) int praise;
//    
//    @property(nonatomic, assign) NSTimeInterval publish_date;
//    @property(nonatomic, assign) NSTimeInterval last_look_date;
//    
//    @property(nonatomic, assign) int userid;
//    @property(nonatomic, copy) NSString* nickname;
//    @property(nonatomic, assign) int is_approved;
//    @property(nonatomic, copy) NSString* avata; // 用户头像地址
//    @property(nonatomic, assign) int user_level; // 用户等级
//    @property(nonatomic, copy) NSString* school_name; // 用户学校名
//    
//    @property(nonatomic, assign) int user_type;
    
    
    _popques_id = [dict[@"id"] intValue];
    _user_id = [dict[@"user_id"] intValue];
    _topic_id = [dict[@"topic_id"] intValue];
    _topic = dict[@"topic"];
    _title = dict[@"title"];
    
    // 音频文件url    
    _url = dict[@"url"];
    _duration = [dict[@"duration"] intValue];
    _pay_type = [dict[@"pay_type"] intValue];
    _pay_num = [dict[@"pay_num"] intValue];
    _is_free = [dict[@"is_free"] intValue];
    _look = [dict[@"look"] intValue];
    _save = [dict[@"save"] intValue];
    _praise = [dict[@"praise"] intValue];
    _publish_date = [SADateHelper humanizedDate:[dict[@"publish_date"] intValue]];
    _last_look_date = [SADateHelper humanizedDate:[dict[@"last_look_date"] intValue]];
    
    _userid = [[dict valueForKeyPath:@"user.id"] intValue];
    _nickname = [dict valueForKeyPath:@"user.nickname"];
    _is_approved = [[dict valueForKeyPath:@"user.is_approved"] intValue];
    _avata = [dict valueForKeyPath:@"user.image"];
    _user_level = [[dict valueForKeyPath:@"user.user_level"] intValue];
    _school_name = [dict valueForKeyPath:@"user.school_name"];
    _user_type = [[dict valueForKeyPath:@"user.user_type"] intValue];
    
    
    return self;
}

+ (instancetype) quesWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
