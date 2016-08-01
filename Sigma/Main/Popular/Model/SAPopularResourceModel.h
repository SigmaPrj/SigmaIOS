//
//  SAPopularResourceModel.h
//  Sigma
//
//  Created by Terence on 16/7/29.
//  Copyright © 2016年 韩佳成. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAPopularResourceModel : NSObject

@property(nonatomic, assign) int popularresource_id;
@property(nonatomic, assign) int user_id;
@property(nonatomic, assign) int category_id;
@property(nonatomic, copy) NSString* category;
@property(nonatomic, copy) NSString* category_img;
@property(nonatomic, copy) NSString* title;
@property(nonatomic, copy) NSString* desc;
@property(nonatomic, copy) NSString* resource_type;
@property(nonatomic, copy) NSString* url; // 资源链接
@property(nonatomic, assign) int save; // 收藏数量
@property(nonatomic, assign) int look; // 查看数量
@property(nonatomic, assign) int download; //下载数量

@property(nonatomic, copy) NSString* publish_date; // 发布时间
@property(nonatomic, copy) NSString* last_look_date; // 上次被查看时间

@property(nonatomic, assign) int userid;
@property(nonatomic, copy) NSString* nickname; // 用户昵称
@property(nonatomic, assign) int is_approved; // 是否被验证通过
@property(nonatomic, copy) NSString* avata; // 用户头像
@property(nonatomic, assign) int user_level; // 用户等级
@property(nonatomic, copy) NSString* school_name;
@property(nonatomic, assign) int user_type;

- (instancetype) initWithDict:(NSDictionary *)dict;

+ (instancetype) resourceWithDict:(NSDictionary *)dict;

@end
