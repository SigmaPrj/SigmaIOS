//
//  SAMessageModel.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/5.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, SAMessageUserType) {
    SAMessageUserDefault = 1,
    SAMessageUserTeacher = 2
};

@interface SAMessageModel : NSObject

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *school;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *date;

@property (nonatomic, assign) int user_id;
@property (nonatomic, assign) int fuser_id;
@property (nonatomic, assign) int tuser_id;
@property (nonatomic, assign) int team_id;
@property (nonatomic, assign) int user_level;
@property (nonatomic, assign) int user_type;

@property (nonatomic, assign, getter=isApproved) BOOL is_approved;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)messageWithDict:(NSDictionary *)dict;

@end
