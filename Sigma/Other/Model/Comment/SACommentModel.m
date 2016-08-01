//
//  SACommentModel.m
//  Sigma
//
//  Created by 汤轶侬 on 16/7/27.
//  Copyright (c) 2016 blackcater. All rights reserved.
//

#import "SACommentModel.h"
#import "SADateHelper.h"

@implementation SACommentModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
//        @property (nonatomic, copy) NSString *avatar; // 用户头像地址
//        @property (nonatomic, copy) NSString *nickname; // 评论用户名称
//        @property (nonatomic, copy) NSString *school; // 所属学校
//        @property (nonatomic, copy) NSString *replayNickname; // 回复的用户名称
//        @property (nonatomic, copy) NSString *publish_date; // 格式化之后的评论发布时间
//        @property (nonatomic, copy) NSString *comment; // 评论内容
//
//        @property (nonatomic, assign) int publish_time; // 评论发布时间
//        @property (nonatomic, assign) int hasReplay; // 是否有回复
//        @property (nonatomic, assign) int dynamic_id; // 动态的id
//        @property (nonatomic, assign) int comment_id; // 评论的id
//        @property (nonatomic, assign) int user_id; // 用户id
//        @property (nonatomic, assign) int replay_id; // 回复人id
//        @property (nonatomic, assign) int is_approved; // 用户是否被认证
//        @property (nonatomic, assign) int user_level; // 用户等级
//        @property (nonatomic, assign) int praise;
        
        _hasReplay = (dict[@"sub_user"]== [NSNull null])?0:1;

        _avatar = [dict valueForKeyPath:@"user.image"];
        _nickname = [dict valueForKeyPath:@"user.nickname"];
        _school = [dict valueForKeyPath:@"user.school_name"];
        if (_hasReplay) {
            _replayNickname = [dict valueForKeyPath:@"sub_user.nickname"];
        }
        _comment = dict[@"comment"];
        _publish_date = [SADateHelper commentDate:[dict[@"publish_date"] intValue]];

        _publish_time = [dict[@"publish_date"] intValue];
        _dynamic_id = [dict[@"dynamic_id"] intValue];
        _comment_id = [dict[@"id"] intValue];
        _user_id = [dict[@"user_id"] intValue];
        if (_hasReplay) {
            _replay_id = [[dict valueForKeyPath:@"sub_user.id"] intValue];
        }
        _is_approved = [[dict valueForKeyPath:@"user.is_approved"] intValue];
        _user_level = [[dict valueForKeyPath:@"user.user_level"] intValue];
        _praise = [dict[@"praise"] intValue];
    }
    return self;
}

+ (instancetype)commentWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
