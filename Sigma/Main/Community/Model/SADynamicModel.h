//
//  SADynamicModel.h
//  Sigma
//
//  Created by 汤轶侬 on 16/7/20.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SADynamicModel : NSObject

@property (nonatomic, assign) int dynamic_id; // 点击评论和赞的时候有用
@property (nonatomic, assign) int user_id; // 当点击用户时，可以看到用户信息
@property (nonatomic, assign) int topic_id; // 当点击话题时，可以用于请求 话题下的动态
@property (nonatomic, copy) NSString *avatar; // 用户头像地址
@property (nonatomic, copy) NSString *nickname; // 用户昵称
@property (nonatomic, copy) NSString *school; // 用户所属学校
@property (nonatomic, copy) NSString *topic; // 相关联的话题名称
@property (nonatomic, copy) NSString *content; // 动态文字内容
@property (nonatomic, copy) NSString *publish_date; // 动态发送时间

@property (nonatomic, strong) NSArray *images; // 附加图片

@property (nonatomic, assign) int is_approved; // 用户是否被认证
@property (nonatomic, assign) int user_type; // 用户类型
@property (nonatomic, assign) int has_topic; // 是否和动态相关联
@property (nonatomic, assign) int praise; // 多少人赞
@property (nonatomic, assign) int look; // 多少人浏览

- (instancetype) initWithDict:(NSDictionary *)dict;

+ (instancetype) dynamicWithDict:(NSDictionary *)dict;

@end
