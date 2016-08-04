//
//  SAPopularResourceModel.m
//  Sigma
//
//  Created by Terence on 16/7/29.
//  Copyright © 2016年 韩佳成. All rights reserved.
//

#import "SAPopularResourceModel.h"
#import "SADateHelper.h"

@implementation SAPopularResourceModel

- (instancetype) initWithDict:(NSDictionary *)dict{
    
//    @property(nonatomic, assign) int popularresource_id;
//    @property(nonatomic, assign) int user_id;
//    @property(nonatomic, assign) int category_id;
//    @property(nonatomic, copy) NSString* category;
//    @property(nonatomic, copy) NSString* category_img;
//    @property(nonatomic, copy) NSString* title;
//    @property(nonatomic, copy) NSString* desc;
//    @property(nonatomic, copy) NSString* resource_type;
//    @property(nonatomic, copy) NSString* url; // 资源链接
//    @property(nonatomic, assign) int save; // 收藏数量
//    @property(nonatomic, assign) int look; // 查看数量
//    @property(nonatomic, assign) int download; //下载数量
//    
//    @property(nonatomic, copy) NSString* publish_date; // 发布时间
//    @property(nonatomic, copy) NSString* last_look_date; // 上次被查看时间
//    
//    @property(nonatomic, assign) int userid;
//    @property(nonatomic, copy) NSString* nickname; // 用户昵称
//    @property(nonatomic, assign) int is_approved; // 是否被验证通过
//    @property(nonatomic, copy) NSString* avata; // 用户头像
//    @property(nonatomic, assign) int user_level; // 用户等级
//    @property(nonatomic, copy) NSString* school_name;
//    @property(nonatomic, assign) int user_type;
    
    
    _popularresource_id = [dict[@"id"] intValue];
    _user_id = [dict[@"user_id"] intValue];
    _category_id = [dict[@"category_id"] intValue];
    _category = dict[@"category"];
    _category_img = dict[@"image"];
    _title = dict[@"title"];
    _desc = dict[@"description"];
    _resource_type = dict[@"resource_type"];
    _url = dict[@"url"];
    _save = [dict[@"save"] intValue];
    _look = [dict[@"look"] intValue];
    _download = [dict[@"download"] intValue];
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

+ (instancetype) resourceWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];

}

@end
