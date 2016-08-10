//
//  SAFriendModel.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/10.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAFriendModel : NSObject

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *school;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, assign) NSInteger userLevel;

@property (nonatomic, assign) NSInteger userType;

@property (nonatomic, assign) NSInteger vip;

@property (nonatomic, assign) NSInteger *online;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)friendsModelWith:(NSDictionary *)dict;

@end
