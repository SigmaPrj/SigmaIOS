//
//  SACommentModel.h
//  Sigma
//
//  Created by 汤轶侬 on 16/7/27.
//  Copyright (c) 2016 blackcater. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SACommentModel : NSObject

@property (nonatomic, copy) NSString *avatar; // 用户头像地址
@property (nonatomic, copy) NSString *nickname; // 评论用户名称
@property (nonatomic, copy) NSString *school; // 所属学校
@property (nonatomic, copy) NSString *replayNickname; // 回复的用户名称
@property (nonatomic, copy) NSString *publish_date; // 格式化之后的评论发布时间
@property (nonatomic, copy) NSString *comment; // 评论内容

@property (nonatomic, assign) int publish_time; // 评论发布时间
@property (nonatomic, assign) int hasReplay; // 是否有回复
@property (nonatomic, assign) int dynamic_id; // 动态的id
@property (nonatomic, assign) int comment_id; // 评论的id
@property (nonatomic, assign) int user_id; // 用户id
@property (nonatomic, assign) int replay_id; // 回复人id
@property (nonatomic, assign) int is_approved; // 用户是否被认证
@property (nonatomic, assign) int user_level; // 用户等级
@property (nonatomic, assign) int praise;

/*!
 *
 * 评论模型获取,对象方法
 *
 * @param dict
 * @return
 */
- (instancetype)initWithDict:(NSDictionary *)dict;

/*!
 *
 * 评论模型获取,类方法
 *
 * @param dict
 * @return
 */
+ (instancetype)commentWithDict:(NSDictionary *)dict;

@end
