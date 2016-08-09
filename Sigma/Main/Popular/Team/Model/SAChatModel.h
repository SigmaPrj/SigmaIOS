//
//  SAChatModel.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/5.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger , SAChatMessageType) {
    SAChatMessageDefault = 0, // 文本
    SAChatMessageImage = 1, // 图片
    SAChatMessageVoice = 2 // 声音
};

@interface SAChatModel : NSObject

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, assign) NSInteger fromUser;
@property (nonatomic, assign) NSInteger toUser;
@property (nonatomic, assign) SAChatMessageType messageType;
@property (nonatomic, assign) NSInteger teamId;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)chatWthDict:(NSDictionary *)dict;

@end
