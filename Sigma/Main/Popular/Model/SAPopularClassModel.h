//
//  SAPopularClassModel.h
//  Sigma
//
//  Created by Terence on 16/7/29.
//  Copyright © 2016年 韩佳成. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAPopularClassModel : NSObject

@property(nonatomic, assign) int popularclass_id; // class这条消息的id
@property(nonatomic, assign) int ouser_id; // 用户id
@property(nonatomic, copy) NSString* title; // 课程标题
@property(nonatomic, copy) NSString* desc; // 课程描述
@property(nonatomic, copy) NSString* bg_image; // 背景图地址
@property(nonatomic, copy) NSString* url; // 视频的url地址
@property(nonatomic, assign) int category; // 类别id

@property(nonatomic, assign) int learn; // 学习课程的人数
@property(nonatomic, assign) int save; //保存课程的人数
@property(nonatomic, copy) NSString* publish_date; // 发布时间
@property(nonatomic, copy) NSString* last_look_date; // 上次被查看时间

@property(nonatomic, assign) int ouserid; //ouserid
@property(nonatomic, copy) NSString* nickname; // 用户昵称
@property(nonatomic, copy) NSString* avata; // 用户头像地址

@property(nonatomic, assign) int is_approved; // 用户是否被验证
@property(nonatomic, copy) NSString* city_name; // 机构所在城市


@property(nonatomic, assign) double cellHeight;

- (instancetype) initWithDict:(NSDictionary *)dict;

+ (instancetype) classWithDict:(NSDictionary *)dict;


@end
