//
//  SAPopularQuestionModel.h
//  Sigma
//
//  Created by Terence on 16/7/28.
//  Copyright © 2016年 韩佳成. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAPopularQuestionModel : NSObject

@property(nonatomic, assign) int popques_id; // 问答请求消息的id
@property(nonatomic, assign) int user_id; // 用户id
// 可能要展示的数据
@property(nonatomic, assign) int topic_id; // 话题id
// 展示
@property(nonatomic, copy) NSString* topic; // 话题
@property(nonatomic, copy) NSString* title; // 话题的标题
@property(nonatomic, copy) NSString* url; // url
@property(nonatomic, assign) int duration; //
@property(nonatomic, assign) int pay_type; //
@property(nonatomic, assign) int pay_num; //
@property(nonatomic, assign) int is_free; // 是否需要付费

// 展示
@property(nonatomic, assign) int look; // 查看数目
@property(nonatomic, assign) int save; // 收藏数目
@property(nonatomic, assign) int praise; // 多少人点赞

@property(nonatomic, copy) NSString* publish_date; // 发布时间
@property(nonatomic, copy) NSString* last_look_date; // 最后查看时间

@property(nonatomic, assign) int userid; // user->id
@property(nonatomic, copy) NSString* nickname; // user-> 昵称
@property(nonatomic, assign) int is_approved; // 是否被验证 0:false 1:true
@property(nonatomic, copy) NSString* avata; // 用户头像地址
@property(nonatomic, assign) int user_level; // 用户等级
@property(nonatomic, copy) NSString* school_name; // 用户学校名

@property(nonatomic, assign) int user_type;

@property (nonatomic, assign) double cellHeight;

- (instancetype) initWithDict:(NSDictionary *)dict;

+ (instancetype) quesWithDict:(NSDictionary *)dict;

@end
