//
//  SAEInfoDetailModel.h
//  Sigma
//
//  Created by Terence on 16/7/26.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAEInfoDetailModel : NSObject

@property(nonatomic, assign) int news_id;
@property(nonatomic, copy) NSString* news_title;
@property(nonatomic, copy) NSString* news_desc;
@property(nonatomic, copy) NSString* news_img;
@property(nonatomic, assign) int news_type;

@property(nonatomic, copy) NSString* publish_date; // 发布时间
@property(nonatomic, copy) NSString* last_look_date; // 上次被查看时间


@property(nonatomic, copy) NSString* start_date; // 开始时间
@property(nonatomic, copy) NSString* end_date; // 结束时间

@property(nonatomic, assign) int allow_personal; // 是否允许个人报名
@property(nonatomic, assign) int allow_team; // 是否允许组队报名
@property(nonatomic, assign) int allow_teacher; // 是否需要导师

@property(nonatomic, assign) int team_min_number; // 组队最小参与人数
@property(nonatomic, assign) int team_max_number; // 组队最大参与人数

@property(nonatomic, assign) int news_save_number; // 收藏资讯数量
@property(nonatomic, assign) int news_look_number; // 查看资讯数量
@property(nonatomic, assign) int news_join_number; // 参与活动人数数量

// 对象方法，初始化
- (instancetype)initWithDict:(NSDictionary *)dict;
// 类方法初始化
+ (instancetype)einformationModelWithDict:(NSDictionary *)dict;

@end
