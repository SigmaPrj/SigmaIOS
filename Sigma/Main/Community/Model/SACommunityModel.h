//
//  SACommunityModel.h
//  Sigma
//
//  Created by 汤轶侬 on 16/7/15.
//  Copyright (c) 2016 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 动态数据, 每个动态应该具有的数据内容
 */
@interface SACommunityModel : NSObject

@property (nonatomic, copy) NSString *user_name; // 用户昵称
@property (nonatomic, copy) NSString *user_avatar; // 用户头像
@property (nonatomic, assign) int level; // 用户等级
@property (nonatomic, copy) NSString *message; // 动态内容
@property (nonatomic, copy) NSString *topic; // 话题
@property (nonatomic, copy) NSArray *images; // 动态附加图片


- (instancetype)initWithDict:(NSDictionary *)dict ;
+ (instancetype)communityWithDict:(NSDictionary *)dict ;

@end
